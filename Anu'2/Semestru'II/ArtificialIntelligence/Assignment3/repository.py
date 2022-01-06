# -*- coding: utf-8 -*-

import pickle
from domain import *


class Repository():
    def __init__(self):
         
        self.__populations = []
        self.__maps = []
        self.currentMap = Map()
        
    def createPopulation(self, args):
        # args = [populationSize, individualSize] -- you can add more args    
        return Population(args[0], args[1])

    def getPopulations(self):
        return self.__populations
    # TO DO : add the other components for the repository: 
    #    load and save from file, etc

    def getCurrentMap(self):
        return self.currentMap

    def getMaps(self):
        self.getMapsFromFile()
        return self.__maps

    def getMapsFromFile(self):
        self.__maps = [ ]
        f = open("savedmaps.txt", "r")
        while True:
            line = f.readline()
            if not line:
                break
            self.__maps.append(line[0:len(line)-1])
        f.close()

    def loadMap(self, fileName):
        f = open(fileName, "r")
        walls = [ ]
        dimension = f.readline().split()
        self.currentMap.setRows(int(dimension[0]))
        self.currentMap.setColumns(int(dimension[1]))
        while True:
            line = f.readline()
            if not line:
                break
            coordinates = line.split()
            walls.append((coordinates[0], coordinates[1]))
        self.currentMap.load(walls)
        f.close()

    def saveMap(self, fileName):
        self.getMaps()
        self.__maps.append(fileName)
        f = open("savedmaps.txt", "w")
        for map in self.__maps:
            f.write(map + "\n")
        f.close()
        g = open(fileName, "w")
        g.write(str(self.currentMap.getRows()) + " " + str(self.currentMap.getColumns()) + "\n")
        walls = self.currentMap.getWalls()
        for wall in walls:
            g.write(str(wall[0]) + " " + str(wall[1]) + "\n")
        g.close()

    def createRandomMap(self):
        self.currentMap.randomMap()

    def addPopulation(self, population):
        self.__populations.append(population)

    def setPopulation(self, position, value):
        self.__populations[position] = value

    def getPopulationOnPosition(self, position):
        return self.__populations[position]