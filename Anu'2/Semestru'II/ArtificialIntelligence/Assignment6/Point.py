class Point:

    def __init__(self, type, x, y):
        self.__type = type
        self.__x = x
        self.__y = y

    @property
    def type(self):
        return self.__type
    @type.setter
    def type(self, value):
        self.__type = value

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
        return "(" + self.type + "): " + "[" + self.x + ", " + self.__y + "]"