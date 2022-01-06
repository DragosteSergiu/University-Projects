import torch
import math


class DBCreator:

    def saveData(self):
        xValues = torch.rand(1000) * 20 - 10
        yValues = torch.rand(1000) * 20 - 10
        fValues = torch.sin(torch.add(xValues, yValues, alpha=1 / math.pi))
        pairs = torch.stack((xValues, yValues, fValues))
        torch.save(pairs, 'mydataset.dat')

