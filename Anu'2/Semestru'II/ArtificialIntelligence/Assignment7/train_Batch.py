import torch
from matplotlib import pyplot as plt

from myModel import *
from createdb import *

class trainBatch:

    @staticmethod
    def run():
        dbCreator = DBCreator()
        dbCreator.saveData()

        xValues, yValues, fValues = torch.load('mydataset.dat')
        points = torch.column_stack((xValues, yValues))

        fValues = fValues.unsqueeze(1)

        loss_function = torch.nn.MSELoss()

        ann = Net(nFeature=2, nHidden=10, nOutput=1)
        print(ann)

        optimizer_batch = torch.optim.SGD(ann.parameters(), lr=0.02)
        loss_list = []
        avg_loss_list = []

        batch_size = 16
        n_batches = int(len(fValues) / batch_size)
        print(n_batches)

        for epoch in range(2000):

            loss_sum = 0

            for batch in range(n_batches):
                batch_variables = points[batch * batch_size:(batch + 1) * batch_size, ]
                batch_function = fValues[batch * batch_size:(batch + 1) * batch_size, ]

                prediction = ann(batch_variables)

                loss = loss_function(prediction, batch_function)
                loss_sum += loss.item()
                optimizer_batch.zero_grad()
                loss.backward()
                optimizer_batch.step()

            avg_loss_list.append(loss_sum / n_batches)
            f_pred = ann(points)
            loss = loss_function(f_pred, fValues)
            loss_list.append(loss.item())
            if epoch % 100 == 99:
                print('\rEpoch: {}\tLoss =  {:.5f}'.format(epoch, loss))
                #plt.scatter(float(epoch), float(loss), c="black", marker='.')

        plt.plot(loss_list)
        plt.savefig("plot.png")
        plt.show()
        torch.save(ann.state_dict(), 'myNet.pt')
