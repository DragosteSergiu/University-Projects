class Point:
    def __init__(self, x, y):
        self.__x = x
        self.__y = y

    @property
    def x(self):
        return self.__x
    @x.setter
    def x(self, value):
        self.__x = value

    @property
    def y(self):
        return self.__y
    @y.setter
    def y(self, value):
        self.__y = value

    def __str__(self):
        return "Point(" + str(self.__x) + ", " + str(self.__y) + ");"