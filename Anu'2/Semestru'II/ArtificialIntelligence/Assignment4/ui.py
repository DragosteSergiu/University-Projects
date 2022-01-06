from copy import deepcopy

from controller import *
import pygame
import time
class Ui:
    def __init__(self):
        self.controller = Controller()

    def seePath(self):
        bestSolution = self.controller.run()
        path = [ ]
        for sensor in range(len(bestSolution.getPath())-1):
            self.controller.setDrone(Drone(SENSORS[sensor][0], SENSORS[sensor][1]))
            path.extend(self.controller.searchAStar(SENSORS[sensor+1][0], SENSORS[sensor+1][1]))
        movingDrone(MAP, path)
        closePyGame()

if __name__ == "__main__":
    # choice = input()
    ui = Ui()
    bestSolution = ui.seePath()