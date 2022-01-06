from ACOMap import ACOMap
from constants import *
from gui import *
from map import *
from domain import *
from repository import *


class Controller:
    def __init__(self):
        self.__acoMap = ACOMap(MAP)
        self.__sensorLen = self.__acoMap.getSensorsLength()
        self.__pheromonTable = [[1.0 for _ in range(self.__sensorLen)] for _ in range(self.__sensorLen)]
        self.__distances = self.__acoMap.getDistances()
        self.__mapM = MAP.surface
        self.__nodes = self.__acoMap.getNodes()

    def searchAStar(self, finalX, finalY):
        return self.__acoMap.searchAStar(finalX, finalY)

    def setDrone(self, drone):
        self.__acoMap.setDrone(drone)

    def moveAnts(self, ants, q0):

        for i in range(len(ants)):
            ant = ants[i]
            for step in range(self.__sensorLen - 1):
                ant.nextMove(self.__distances, self.__pheromonTable, q0)
        aliveAnts = []
        for i in range(len(ants)):
                ants[i].computeFitness()
                aliveAnts.append(ants[i])
        return aliveAnts

    @staticmethod
    def selectBestAnt(ants):
        bestAnt = None
        bestFitness = 0
        for ant in ants:
            if bestFitness < ant.getFitness():
                bestFitness = ant.getFitness()
                bestAnt = ant
        return bestAnt

    def simulateEpoch(self, antCount, alpha, beta, q0, rho):
        ants = [Ant() for _ in range(antCount)]
        ants = self.moveAnts(ants, q0)
        for i in range(self.__sensorLen):
            for j in range(self.__sensorLen):
                self.__pheromonTable[i][j] = (1 - rho) * self.__pheromonTable[i][j]
        for ant in ants:
            newPheromone = 1.0 / ant.getFitness()
            currentPath = ant.getPath()
            for i in range(len(currentPath) - 1):
                currentNode = currentPath[i]
                nextNode = currentPath[i + 1]
                self.__pheromonTable[currentNode][nextNode] += newPheromone
        return self.selectBestAnt(ants)

    def updateBestSolution(self, bestSolution):
        currentSolution = self.simulateEpoch(NO_ANTS, ALPHA, BETA, Q0, RHO)
        if currentSolution is None:
            return bestSolution
        currentPathLength = len(currentSolution.getPath())
        if bestSolution is None or currentPathLength > len(bestSolution.getPath()) or (
                currentPathLength == len(bestSolution.getPath()) and currentSolution.getFitness() < bestSolution.getFitness()):
            return currentSolution
        return bestSolution


    def run(self):
        bestSolution = None
        for epoch in range(100):
            bestSolution = self.updateBestSolution(bestSolution)
        for sensor in bestSolution.getPath():
            print("Sensor " + str(sensor) + ", Position"+ SENSORS[sensor].__str__())
        return bestSolution



