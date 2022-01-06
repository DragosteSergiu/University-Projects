class Node:
    def __init__(self, parent=None, position=None):
        self.parent = parent
        self.position = position

        self.f = 0
        self.g = 0
        self.h = 0

    def getParent(self):
        return self.parent

    def setParent(self, value):
        self.parent = value

    def getPosition(self):
        return self.position

    def setPosition(self, value):
        self.position = value

    def getF(self):
        return self.f

    def setF(self, value):
        self.f = value

    def getG(self):
        return self.g

    def setG(self, value):
        self.g = 0

    def getH(self):
        return self.h

    def setH(self, value):
        self.h = 0

    def __eq__(self, value):
        return self.position == value.position