from torchvision import transforms
from train import SimpleNet
from PIL import Image
import torch

def load_image(image_path):
    image = Image.open(image_path)

    image_size = 32
    transformations = transforms.Compose(
        [
            transforms.Resize(image_size),
            transforms.CenterCrop(image_size),
            transforms.ToTensor(),
            transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))
        ]
    )

    return transformations(image).unsqueeze(0)

if __name__ == '__main__':
    model_path = 'models/model_17.model'

    model = SimpleNet(num_classes = 2)
    model.load_state_dict(torch.load(model_path))

    print()

    images_path = ['pictures/barbati/barbat27.jpg', 'pictures/femei/femeie42.jpg', 'pictures/obiecte/obiect5.jpg',
                   'pictures/obiecte/obiect12.jpg', 'pictures/barbati/barbat33.jpg', 'pictures/femei/femeie6.jpg']

    for image_path in images_path:
        try:

            image = load_image(image_path)

            prediction = model(image).detach().numpy()[0]

            not_face = prediction[0]
            face = prediction[1]

            if face > 0:
                print("The image '{}:' contains a face.". format(image_path))
            elif not_face > 0:
                print("The image '{}:' does not contain a face.". format(image_path))
            else:
                print("The model can not determine if the image '{}:' is a face.". format(image_path))

            print()
        except KeyboardInterrupt:
            break