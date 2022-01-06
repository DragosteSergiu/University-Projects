from copy import deepcopy

from ACOController import ACOController
from constants import *
from domain import Drone


class ACOMap:
    def __init__(self, map):
        self.__nodes = [ ]
        self.__map = map
        self.__controller = ACOController()
        self._sensorLen = len(self.__controller.sensors)
        self._distances = [[undefined for _ in range(self._sensorLen)] for _ in range(self._sensorLen)]
        self.initializeNodes()
        self.setDistances()

    def searchAStar(self, finalX, finalY):
        return self.__controller.searchAStar(finalX, finalY)

    def setDrone(self, drone):
        self.__controller.setDrone(drone)

    def getNodes(self):
        return self.__controller.sensors

    def getSensorsLength(self):
        return self._sensorLen

    def getDistances(self):
        return self._distances

    @staticmethod
    def checkDifferenceNodes(nodeX, nodeY):
        if (nodeX[0] != nodeY[0]) or (nodeX[1] != nodeY[1]):
            return True
        else:
            return False

    def initializeNodes(self):
        for i in range(len(self.__controller.sensors)):
            self.__nodes.append(self.__controller.sensors[i])

    def setDistances(self):
        sensors = self.__controller.sensors
        for i in range(self._sensorLen):
            nodeI = (sensors[i].getX(), sensors[i].getY())
            for j in range(self._sensorLen):
                nodeJ = (sensors[j].getX(), sensors[j].getY())
                if self.checkDifferenceNodes(nodeI, nodeJ):
                    self.__controller.drone = Drone(nodeI[0], nodeI[1])
                    self._distances[i][j] = len(deepcopy(self.__controller.searchAStar(nodeJ[0], nodeJ[1]).copy()))
                else:
                    self._distances[i][j] = 0