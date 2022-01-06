import torch.nn as nn
import torch
import os
from torch.autograd import Variable
from torch.optim import Adam
from torch.utils.data import DataLoader
from random import shuffle
from PIL import Image
from dataset import ImageClassifierDataset


class Unit(nn.Module):

    def __init__(self, in_channels, out_channels):
        super(Unit, self).__init__()
        self.conv = nn.Conv2d(in_channels=in_channels, kernel_size=3, out_channels=out_channels, stride=1, padding=1)
        self.bn = nn.BatchNorm2d(num_features=out_channels)
        self.relu = nn.ReLU()

    def forward(self, input):
        output = self.conv(input)
        output = self.bn(output)
        output = self.relu(output)
        return output


class SimpleNet(nn.Module):

    def __init__(self, num_classes=2):
        super(SimpleNet, self).__init__()

        self.unit1 = Unit(in_channels=3, out_channels=32)
        self.unit2 = Unit(in_channels=32, out_channels=32)
        self.unit3 = Unit(in_channels=32, out_channels=32)

        self.pool1 = nn.MaxPool2d(kernel_size=2)

        self.unit4 = Unit(in_channels=32, out_channels=64)
        self.unit5 = Unit(in_channels=64, out_channels=64)
        self.unit6 = Unit(in_channels=64, out_channels=64)
        self.unit7 = Unit(in_channels=64, out_channels=64)

        self.pool2 = nn.MaxPool2d(kernel_size=2)

        self.unit8 = Unit(in_channels=64, out_channels=128)
        self.unit9 = Unit(in_channels=128, out_channels=128)
        self.unit10 = Unit(in_channels=128, out_channels=128)
        self.unit11 = Unit(in_channels=128, out_channels=128)

        self.pool3 = nn.MaxPool2d(kernel_size=2)

        self.unit12 = Unit(in_channels=128, out_channels=128)
        self.unit13 = Unit(in_channels=128, out_channels=128)
        self.unit14 = Unit(in_channels=128, out_channels=128)

        self.avgpool = nn.AvgPool2d(kernel_size=4)

        self.net = nn.Sequential(
            self.unit1,
            self.unit2,
            self.unit3,
            self.pool1,
            self.unit4,
            self.unit5,
            self.unit6,
            self.unit7,
            self.pool2,
            self.unit8,
            self.unit9,
            self.unit10,
            self.unit11,
            self.pool3,
            self.unit12,
            self.unit13,
            self.unit14,
            self.avgpool
        )

        self.fc = nn.Linear(in_features=128, out_features=num_classes)

    def forward(self, input):
        output = self.net(input)
        output = output.view(-1, 128)
        output = self.fc(output)
        return output

def load_images(directory_name, image_list, image_classes, contains_faces):
    files = [file for file in os.listdir(directory_name) if os.path.isfile(os.path.join(directory_name, file))]

    for file in files:
        image = Image.open(f'{directory_name}/{file}').convert('RGB')
        image_list.append(image)
        image_classes.append(1 if contains_faces else 0)

def create_datasets(factor=0.8):


    image_list = []
    image_classes = []

    load_images('pictures/barbati', image_list, image_classes, contains_faces=True)
    load_images('pictures/femei', image_list, image_classes, contains_faces=True)
    load_images('pictures/obiecte', image_list, image_classes, contains_faces=False)

    images_and_labels = list(zip(image_list, image_classes))

    shuffle(images_and_labels)

    image_list.clear()
    image_classes.clear()

    for image, label in images_and_labels:
        image_list.append(image)
        image_classes.append(label)

    train_size = int(len(image_list) * factor)

    train_images = image_list[:train_size]
    train_classes = image_classes[:train_size]

    test_images = image_list[train_size:]
    test_classes = image_classes[train_size:]

    return ImageClassifierDataset(train_images, train_classes), ImageClassifierDataset(test_images, test_classes)


def adjust_learning_rate(optimizer, epoch):
    lr = 0.0001

    if epoch > 180:
        lr = lr / 1000000
    elif epoch > 150:
        lr = lr / 100000
    elif epoch > 120:
        lr = lr / 10000
    elif epoch > 90:
        lr = lr / 1000
    elif epoch > 60:
        lr = lr / 100
    elif epoch > 30:
        lr = lr / 10

    for param_group in optimizer.param_groups:
        param_group["lr"] = lr


def save_models(model, epoch):
    torch.save(model.state_dict(), "models/model_{}.model".format(epoch))
    print("Checkpoint saved")


def test(model, test_loader):
    model.eval()
    test_acc = 0.0

    for _, (images, labels) in enumerate(test_loader):

        if torch.cuda.is_available():
            images = Variable(images.cuda())
            labels = Variable(labels.cuda())

        outputs = model(images)

        _, prediction = torch.max(outputs.data, 1)

        test_acc += torch.sum(torch.eq(prediction, labels.data))

    test_acc = test_acc / len(test_loader)

    return test_acc


def train(model, optimizer, loss_fn, train_loader, test_loader, num_epochs):
    best_acc = 0.0

    for epoch in range(num_epochs):
        model.train()

        train_acc = 0.0
        train_loss = 0.0

        for _, (images, labels) in enumerate(train_loader):

            if torch.cuda.is_available():
                images = Variable(images.cuda())
                labels = Variable(labels.cuda())

            optimizer.zero_grad()

            outputs = model(images)

            loss = loss_fn(outputs, labels)

            loss.backward()

            optimizer.step()

            train_loss += loss.cpu().data.item() * images.size(0)
            _, prediction = torch.max(outputs.data, 1)

            train_acc += torch.sum(prediction == labels.data)

        adjust_learning_rate(optimizer, epoch)

        train_acc = train_acc / len(train_loader)
        train_loss = train_loss / len(train_loader)

        test_acc = test(model, test_loader)

        print("Epoch {}: Train Accuracy: {:.4f}, TrainLoss: {:.4f}, Test Accuracy: {:.4f}".format(epoch, train_acc,
                                                                                                  train_loss, test_acc))

        if test_acc >= best_acc:
            save_models(model, epoch)
            best_acc = test_acc


if __name__ == "__main__":
    train_set, test_set = create_datasets()

    batch_size = 1

    train_loader = DataLoader(train_set, batch_size=batch_size, shuffle=True, num_workers=4)

    test_loader = DataLoader(test_set, batch_size=batch_size, shuffle=False, num_workers=4)

    model = SimpleNet(num_classes=2)

    if torch.cuda.is_available():
        model.cuda()

    optimizer = Adam(model.parameters(), lr=0.001, weight_decay=0.0001)

    loss_fn = nn.CrossEntropyLoss()

    train(model, optimizer, loss_fn, train_loader, test_loader, 15)