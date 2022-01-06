class Cluster:
    def __init__(self):
        self.__points = set()
        self.__centroid = 0


    @property
    def points(self):
        return self.__points
    @points.setter
    def points(self, value):
        self.__points = value

    @property
    def centroid(self):
        return self.__centroid
    @centroid.setter
    def centroid(self, value):
        self.__centroid = value

    def addPoint(self, point):
        self.__points.add(point)

    def deletePoint(self, point):
        self.__points.remove(point)

    def calculateCentroid(self):
        x = 0
        y = 0
        for point in self.__points:
            x += float(point.x)
            y += float(point.y)
        if len(self.__points) > 0:
            x = x / len(self.__points)
            y = y / len(self.__points)
            return (x, y)
        else:
            return (0, 0)

    def __str__(self):
        str = ""
        for point in self.__points:
            str += point.__str__() + "\n"
        return str

    def stats(self):
        aCount = 0
        bCount = 0
        cCount = 0
        dCount = 0
        for point in self.__points:
            if point.type == "A":
                aCount += 1
            if point.type == "B":
                bCount += 1
            if point.type == "C":
                cCount += 1
            if point.type == "D":
                dCount += 1
        n = len(self.__points)
        return (aCount, bCount, cCount, dCount)
