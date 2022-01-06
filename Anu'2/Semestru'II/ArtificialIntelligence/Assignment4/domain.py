from random import randint, random

import pygame

from constants import *
from repository import MAP


class Node:
    def __init__(self, x, y, value):
        self.x = x
        self.y = y
        self.value = value

        self.__f = undefined
        self.__g = undefined
        self.__h = undefined

    def getParent(self):
        return self.__parent

    def setParent(self, value):
        self.__parent = value

    def getPosition(self):
        return self.__position

    def setPosition(self, value):
        self.__position = value

    def getF(self):
        return self.__f

    def setF(self, value):
        self.__f = value

    def getG(self):
        return self.__g

    def setG(self, value):
        self.__g = value

    def getH(self):
        return self.__h

    def setH(self, value):
        self.__h = value


class Ant:
    def __init__(self, energy = 75):
        self.__path = [randint(0, len(SENSORS)-1)]
        self.__energy = energy
        self.__fitness = 0

    def getPath(self):
        return self.__path

    def getEnergy(self):
        return self.__energy

    def getFitness(self):
        return self.__fitness

    def computeFitness(self):
        self.__fitness = 1 / (len(self.__path))

    def getPossibleMoves(self, map):
        moves = [ ]
        current = self.__path[-1]
        distances = map[current]
        numberOfNodes = len(SENSORS)
        for next in range(numberOfNodes):
            if next != current and distances[next] != undefined and next not in self.__path and self.__energy >= distances[next]:
                moves.append(next)
        return moves

    def probabilityNextMove(self, moves, map, pheromonTable, beta = BETA, alpha = ALPHA):
        currentIndex = self.__path[-1]
        numberOfNodes = len(SENSORS)
        nextProb = [0 for _ in range(numberOfNodes)]
        for i in moves:
            distanceNext = map[currentIndex][i]
            pheromoneNext = pheromonTable[currentIndex][i]
            probability = ((distanceNext + 0.001) ** alpha) * (pheromoneNext ** beta)
            nextProb[i] = probability
        return nextProb

    def nextMove(self, map, pheromonTable, q0):
        possibleMoves = self.getPossibleMoves(map)
        if not possibleMoves:
            return False
        nextProb = self.probabilityNextMove(possibleMoves, map, pheromonTable)
        if random() < q0:
            bestMove = max(nextProb)
            selectedNode = nextProb.index(bestMove)
        else:
            selectedNode = self.selection(nextProb)
        self.__energy -= map[self.__path[-1]][selectedNode]
        self.__path.append(selectedNode)
        return True

    @staticmethod
    def selection(nextProbabilities):
        probabilitySum = sum(nextProbabilities)
        if probabilitySum == 0:
            return randint(0, len(nextProbabilities) - 1)
        partipartialSums = [nextProbabilities[0] / probabilitySum]
        for i in range(1, len(nextProbabilities)):
            partipartialSums.append(partipartialSums[i - 1] + nextProbabilities[i] / probabilitySum)
        r = random()
        position = 0
        while r > partipartialSums[position]:
            position += 1
        return position


class Drone:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.image = pygame.image.load("drona.png")
        self.openList = []
        self.openList.clear()
        self.closeList = dict()
        self.closeList.clear()
        self.openList.append((0, (self.x, self.y)))


    def getX(self):
        return self.x
    def setX(self, value):
        self.x = value

    def getY(self):
        return self.y
    def setY(self, value):
        self.y = value

class ACONode:
    def __init__(self, x, y):
        self.__x = x
        self.__y = y

    def getX(self):
        return self.__x
    def setX(self, value):
        self.__x = value

    def getY(self):
        return self.__y
    def setY(self, value):
        self.__y = value

    def __str__(self):
        str = "N(" + str(self.__x) + ", " + str(self.__y) + ")"
        return str

class Sensor(ACONode):
    def __init__(self, x, y):
        super().__init__(x, y)
        self.__energy = 0
        self.__vision = [ ]
        self.checkEnergy()

    def getEnergy(self):
        return self.__energy

    def checkEnergy(self, map=MAP.surface):
        visionList = [0] * 6
        for i in range(1, 6):
            for d in directions:
                dumX = self.getX()
                dumY = self.getY()
                for position in range(i):
                    dumX = dumX + d[0]
                    dumY = dumY + d[1]
                    if 0 <= dumX < 20 and 0 <= dumY < 20:
                        if map[dumX][dumY] != 1:
                            visionList[i] += 1
                        else:
                            break
        self.__vision = visionList
        self.__energy = visionList.index(max(visionList))

    def __str__(self):
        str = "S(" + str(self.__x) + ", " + str(self.__y) + ")"
        return str

class Population:
    def __init__(self, size = 5):
        self.ants = [Ant() for _ in range(size)]
        self.size = size