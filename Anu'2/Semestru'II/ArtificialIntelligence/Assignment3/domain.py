# -*- coding: utf-8 -*-

from random import *
from utils import *
import numpy as np

# the glass gene can be replaced with int or float, or other types
# depending on your problem's representation

class gene:
    def __init__(self):
        # random initialise the gene according to the representation
        self.__direction = DIRECTION[randint(0, 3)]

    def getDirection(self):
        return self.__direction
    def setDirection(self, value):
        self.__direction = value
    def __str__(self):
        return str(self.__direction)

class Individual:
    def __init__(self, size = 0):
        self.__size = size
        self.__x = [gene() for i in range(self.__size)]
        self.__f = None
        self.__battery = size

    def __str__(self):
        result = ""
        for gene in self.__x:
            result = result + gene.__str__() + " "
        return result[0 : len(result)-1]

    def getPath(self):
        path = [ ]
        newX = 5
        newY = 5
        for gene in self.__x:
            if gene.getDirection() == UP:
                newX = newX-1
            if gene.getDirection() == DOWN:
                newX = newX+1
            if gene.getDirection() == LEFT:
                newY = newY-1
            if gene.getDirection() == RIGHT:
                newY = newY+1
            path.append((newX, newY))
        return path

    def getGenes(self):
        result =  [ ]
        for i in self.__x:
            result.append(i.getDirection())
        return result

    def getGeneOnPosition(self, position):
        return self.__x[position]

    def setGeneOnPosition(self, position, value):
        self.__x[position] = value

    def getFitness(self):
        return self.__f

    def getVisibility(self, x, y, map):
        result = [ ]
        for i in range(x-1, -1, -1):
            if (map.surface[i][y] != 0):
                break
            result.append((i, y))
        for i in range(x+1, map.getRows()):
            if (map.surface[i][y] != 0):
                break
            result.append((i, y))
        for i in range(y-1, -1, -1):
            if (map.surface[x][i] != 0):
                break
            result.append((x, i))
        for i in range(y+1, map.getColumns()):
            if (map.surface[x][i] != 0):
                break
            result.append((x, i))
        return result
        
    def fitness(self, map):
        # compute the fitness for the indivisual
        # and save it in self.__f
        totalVisibility = set()
        newX = 5
        newY = 5
        sum = 0
        battery = self.__battery
        for gene in self.__x:
            if battery > 0:
                if gene.getDirection() == UP:
                    newX = newX-1
                if gene.getDirection() == DOWN:
                    newX = newX+1
                if gene.getDirection() == LEFT:
                    newY = newY-1
                if gene.getDirection() == RIGHT:
                    newY = newY+1
                if map.checkIfIsValid(newX, newY) == True:
                    result = self.getVisibility(newX, newY, map)
                    for i in result:
                        if not i in totalVisibility:
                            totalVisibility.add(i)
                else:
                    sum += PENALTY
            battery -= 1
        self.__f = len(totalVisibility) - sum
    
    def mutate(self, mutateProbability = 0.04):
        if random() < mutateProbability:
            # perform a mutation with respect to the representation
            self.setGeneOnPosition(randint(0, self.__size - 1), gene())

    
    def crossover(self, otherParent, crossoverProbability = 0.8):
        offspring1, offspring2 = Individual(self.__size), Individual(self.__size) 
        if random() < crossoverProbability:
            crossverPoint = randint(self.__size//2-1, self.__size//+1)
            for i in range(0, self.__size):
                if (i < crossverPoint):
                    offspring1.setGeneOnPosition(i, self.getGeneOnPosition(i))
                    offspring2.setGeneOnPosition(i, otherParent.getGeneOnPosition(i))
                else:
                    offspring1.setGeneOnPosition(i, otherParent.getGeneOnPosition(i))
                    offspring2.setGeneOnPosition(i, self.getGeneOnPosition(i))
            # perform the crossover between the self and the otherParent
        return offspring1, offspring2
    
class Population():
    def __init__(self, populationSize = 0, individualSize = 0):
        self.__populationSize = populationSize
        self.__v = [Individual(individualSize) for x in range(populationSize)]

    def setV(self, value):
        self.__v = value
        
    def evaluate(self, map):
        # evaluates the population
        for x in self.__v:
            x.fitness(map)

    def getIndividuals(self):
        return self.__v
            
    def __str__(self):
        result = ""
        for individual in self.__v:
            result = result + individual.__str__() +"\n"
            #print(individual.toString())
        return result

    def addIndividual(self, individual):
        self.__v.append(individual)
        self.__populationSize += 1

    def selection(self, k = 0):
        # perform a selection of k individuals from the population
        # and returns that selection
        sum = 0
        result = [ ]
        cond = random()
        for individual in self.__v:
            sum += individual.getFitness()
        while len(result) < k:
            for individual in self.__v:
                if (len(result) == k):
                    break
                if (individual.getFitness()/sum > cond):
                    result.append(individual)
            cond = random()
        return result

    def getAverageFitness(self):
        sum = 0
        for individual in self.__v:
            sum += individual.getFitness()
        return sum/len(self.__v)

    def populationStatistics(self, generationNumber):
        return "Generation: " + str(generationNumber) +", Number of individuals: " + str(len(self.__v)) + ", Average fitness: " + str(self.getAverageFitness())
    
class Map():
    def __init__(self, n = 20, m = 20):
        self.n = n
        self.m = m
        self.surface = np.zeros((self.n, self.m))

    def getRows(self):
        return self.n
    def setRows(self, value):
        self.n = value

    def getColumns(self):
        return self.m
    def setColumns(self, value):
        self.m = value
    
    def randomMap(self, fill = 0.2):
        for i in range(self.n):
            for j in range(self.m):
                if random() <= fill :
                    self.surface[i][j] = 1

    def load(self, walls):
        for wall in walls:
            self.surface[int(wall[0])][int(wall[1])] = 1

    def getWalls(self):
        result = [ ]
        for i in range(0, self.n):
            for j in range(0, self.m):
                if (self.surface[i][j] == 1):
                    result.append((i, j))
        return result
                
    def __str__(self):
        string=""
        for i in range(self.n):
            for j in range(self.m):
                string = string + str(int(self.surface[i][j]))
            string = string + "\n"
        return string

    def checkIfIsValid(self, x, y):
        if self.surface[x][y] == 0:
            return True
        return False


