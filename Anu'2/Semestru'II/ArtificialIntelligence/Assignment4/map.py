import numpy
import random
import pygame

from constants import *


class Map:
    def __init__(self, n=20, m=20):
        self.n = n
        self.m = m
        self.surface = numpy.zeros((n, m))
        self.sensors = []

    def randomMap(self, fill=0.2):
        for i in range(self.n):
            for j in range(self.m):
                if random.random() <= fill:
                    self.surface[i][j] = 1


    def getSensors(self):
        return self.sensors

    def setSensors(self, listOfSensors):
        self.sensors = listOfSensors
        for sensor in listOfSensors:
            self.surface[sensor[0]][sensor[1]] = 2


    def image(self, colour=BLUE, background=WHITE):
        imagine = pygame.Surface((20*self.n, 20*self.m))

        brick = pygame.Surface((20, 20))
        brick.fill(BLUE)

        sensor = pygame.Surface((20, 20))
        sensor.fill(RED)

        imagine.fill(WHITE)
        for i in range(self.n):
            for j in range(self.m):
                if (self.surface[i][j] == 1):
                    imagine.blit(brick, (j * 20, i * 20))
                elif (self.surface[i][j] == 2):
                    imagine.blit(sensor, (j * 20, i * 20))

        return imagine

