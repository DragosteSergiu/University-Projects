import torch
import torch.nn.functional as F
from createdb import *

class Net(torch.nn.Module):
    def __init__(self, nFeature, nHidden, nOutput):
        super(Net, self).__init__()
        self.hidden = torch.nn.Linear(nFeature, nHidden)
        self.hidden2 = torch.nn.Linear(nHidden, nHidden)
        self.output = torch.nn.Linear(nHidden, nOutput)

    def forward(self, x):
        x = F.relu(self.hidden(x))
        x = F.relu(self.hidden2(x))
        x = self.output(x)
        return x
