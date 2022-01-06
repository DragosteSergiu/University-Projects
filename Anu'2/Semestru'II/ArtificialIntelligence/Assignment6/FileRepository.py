from Point import Point
class FileRepository:
    def __init__(self, fileName = "dataset.csv"):
        self.__fileName = fileName
        self.__points = [ ]

    def readFromFile(self):
        fileHandler = open(self.__fileName, "r");
        fileHandler.readline()
        for line in fileHandler:
            parameters = line.split(',')
            point = Point(parameters[0], parameters[1], parameters[2].strip())
            self.__points.append(point)
        fileHandler.close()

    @property
    def points(self):
        return self.__points

    @points.setter
    def points(self, value):
        self.__points = value
