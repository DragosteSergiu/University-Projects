from PIL import Image
from matplotlib import image
from matplotlib import pyplot

class Picture:

    def __init__(self, filename):
        self.__image = Image.open(filename)
        self.__data = image.imread(filename)

    def displayImage(self):
        print(self.__image.format)
        print(self.__image.mode)
        print(self.__image.size)

        self.__image.show()

    def convertToNumpy(self):
        #print(self.__data.dtype)
        #print(self.__data.shape)
        pyplot.imshow(self.__data)
        pyplot.show()

    def createThumbnail(self):
        print(self.__image.size)
        self.__image.thumbnail((100, 100))
        print(self.__image.size)

if __name__ == "__main__":
    picture = Picture('f1.jpg')
    picture.displayImage()
    picture.convertToNumpy()
    picture.createThumbnail()