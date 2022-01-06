from domain import Sensor, Node, Drone
from constants import SENSORS, directions, manhattanDistance, undefined
from map import *
from repository import MAP


class ACOController:
    def __init__(self, drone=Drone(1, 1), map=MAP, sensors=SENSORS):
        self.drone = drone
        self.map = map
        self.moves = []
        self.sensors = sensors
        self.explorationMap = []
        self.setSensors()

    def setDrone(self, drone):
        self.drone = drone

    def setSensors(self):
        sensors = []
        for i in self.sensors:
            sensor = Sensor(i[0], i[1])
            sensors.append(sensor)
        self.sensors = sensors
        for i in self.sensors:
            self.map.surface[i.getX()][i.getY()] = 6

    @staticmethod
    def isValid(x, y):
        return 0 <= x < 20 and 0 <= y < 20

    def isEmpty(self, x, y):
        return self.map.surface[x][y] == 0

    def initializeFirstPosition(self):
        self.explorationMap[self.drone.x][self.drone.y].g = 0
        self.explorationMap[self.drone.x][self.drone.y].h = 0
        self.explorationMap[self.drone.x][self.drone.y].f = 0
        self.explorationMap[self.drone.x][self.drone.y].x = self.drone.x
        self.explorationMap[self.drone.x][self.drone.y].y = self.drone.y

    def transformMap(self):
        for i in range(self.map.m):
            for j in range(self.map.n):
                self.drone.closeList[(i, j)] = False

        return [[Node(-1, -1, self.map.surface[j][i]) for i in range(self.map.m)] for j in
                range(self.map.n)]

    def computePath(self, finalX, finalY):
        self.moves.clear()
        row = finalX
        column = finalY
        while self.explorationMap[row][column].x != row or self.explorationMap[row][column].y != column:
            self.moves.append((row, column))
            temp_row = self.explorationMap[row][column].x
            temp_column = self.explorationMap[row][column].y
            row = temp_row
            column = temp_column

        self.moves.append((row, column))
        self.moves.reverse()
        return self.moves

    def searchAStar(self, finalX, finalY):
        self.explorationMap = self.transformMap()
        self.initializeFirstPosition()
        while len(self.drone.openList) > 0:
            currentElement = self.drone.openList[0]
            self.drone.openList.remove(currentElement)
            i = currentElement[1][0]
            j = currentElement[1][1]
            self.drone.closeList[(i, j)] = True
            for d in directions:

                currentX = i + d[0]
                currentY = j + d[1]

                if self.isValid(currentX, currentY):
                    if currentX == finalX and currentY == finalY:
                        self.explorationMap[currentX][currentY].x = i
                        self.explorationMap[currentX][currentY].y = j
                        self.computePath(finalX, finalY)
                        return self.moves
                    elif not self.drone.closeList[(currentX, currentY)]:
                        if self.isEmpty(currentX, currentY):
                            gFunction = self.explorationMap[i][j].getG() + 1
                            hFunction = manhattanDistance(self.drone.x, self.drone.y, finalX, finalY)
                            fFunction = gFunction + hFunction
                            if self.explorationMap[currentX][currentY].getF() == undefined or self.explorationMap[currentX][currentY].getF() > fFunction:
                                self.drone.openList.append((fFunction, (currentX, currentY)))
                                self.explorationMap[currentX][currentY].setF(fFunction)
                                self.explorationMap[currentX][currentY].setG(gFunction)
                                self.explorationMap[currentX][currentY].setH(hFunction)
                                self.explorationMap[currentX][currentY].x = i
                                self.explorationMap[currentX][currentY].y = j
        return []
