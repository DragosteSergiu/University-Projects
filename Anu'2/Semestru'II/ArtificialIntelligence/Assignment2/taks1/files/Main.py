import pygame,time
from pygame.locals import *
from random import randint
from Utils import WHITE
from Utils import EUCLIDIAN_DISTANCE
from Utils import MANHATTAN_DISTANCE
from Controller import Controller
from Map import Map
from Drone import Drone
import timeit


class Main():

    def __init__(self):
        pass

    def run(self):
        # we create the map
        m = Map()
        # m.randomMap()
        # m.saveMap("test2.map")
        m.loadMap("test1.map")

        # initialize the pygame module
        pygame.init()
        # load and set the logo
        logo = pygame.image.load("../logo32x32.png")
        pygame.display.set_icon(logo)
        pygame.display.set_caption("Path in simple environment")


        # we position the drone somewhere in the area
        startX = randint(0, 19)
        startY = randint(0, 19)
        while m.isValid(startX, startY) == False:
            startX = randint(0, 19)
            startY = randint(0, 19)
        if m.isValid(startX, startY) == True:
            # create drona
            d = Drone(startX, startY)

        endX = randint(0, 19)
        endY = randint(0, 19)
        while m.isValid(endX, endY) == False:
            endX = randint(0, 19)
            endY = randint(0, 19)

        controller = Controller(m, d)

        # create a surface on screen that has the size of 400 x 480
        screen = pygame.display.set_mode((400, 400))
        screen.fill(WHITE)

        # define a variable to control the main loop

        screen.blit(d.mapWithDrone(m.image()), (0, 0))
        pygame.display.flip()

        #OPTION = MANHATTAN_DISTANCE
        OPTION = EUCLIDIAN_DISTANCE

        execution_start = timeit.default_timer()

        path = controller.searchGreedy(d.x, d.y, endX, endY, OPTION)

        execution_stop = timeit.default_timer()
        execution_time = execution_stop - execution_start
        if path != False:
            print(path)
            screen.blit(controller.displayWithPath(m.image(), path), (0, 0))
        else:
            print("Can't find a path for start(" + startX.__str__() +", "+ startY.__str__() + ") to end(" +endX.__str__() +", " + endY.__str__() + ")")
            screen.blit(d.mapWithDrone(m.image()), (0, 0))

        print(execution_time)
        pygame.display.flip()
        time.sleep(5)
        pygame.quit()

if __name__=="__main__":
    # call the main function
    m = Main()
    m.run()