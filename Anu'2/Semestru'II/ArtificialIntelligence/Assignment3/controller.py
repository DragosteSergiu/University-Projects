from repository import *


class Controller():
    def __init__(self, repository):
        self.__repository = repository
        # args - list of parameters needed in order to create the controller
    

    def iteration(self, population, numberPerSelection, numberOfGenerations):
        # args - list of parameters needed to run one iteration
        # a iteration:
        # selection of the parents
        # create offsprings by crossover of the parents
        # apply some mutations
        # selection of the survivors
        newPopulation = population
        for numberOfGeneration in range(0, numberOfGenerations):
            newPopulation.evaluate(self.getMap())
            parents = population.selection(numberPerSelection)
            result = [ ]
            for i in range(0, len(parents)-1):
                for j in range(i+1, len(parents)):
                    children = parents[i].crossover(parents[j])
                    result.append(children[0])
                    result.append(children[1])
            for i in result:
                i.mutate()
            newPopulation = Population()
            newPopulation.setV(result)
        return newPopulation.getIndividuals()
        
    def run(self, population, numberPerSelection, numberOfPopulation):
        # args - list of parameters needed in order to run the algorithm
        
        # until stop condition
        #    perform an iteration
        #    save the information need it for the statistics
        
        # return the results and the info for statistics
        self.addPopulation(population)
        children = self.iteration(self.__repository.getPopulations()[numberOfPopulation], numberPerSelection, 20)
        parents = self.__repository.getPopulationOnPosition(numberOfPopulation).getIndividuals()
        result = []
        for parent in parents:
            result.append(parent)
        for child in children:
            result.append(child)
        newPopulation = Population(len(result))
        newPopulation.setV(result)
        self.__repository.setPopulation(numberOfPopulation, newPopulation)

    
    
    def solver(self, populationSize, individualSize, numberPerSelection, numberOfPopulations):
        # args - list of parameters needed in order to run the solver
        
        # create the population,
        # run the algorithm
        # return the results and the statistics
        for i in range(0,numberOfPopulations):
            population = Population(populationSize, individualSize)
            self.run(population, numberPerSelection, i)


    def getMap(self):
        return self.__repository.getCurrentMap()

    def getSavedMaps(self):
        return self.__repository.getMaps()

    def savedMapsToString(self):
        result = ""
        maps = self.__repository.getMaps()
        for map in maps:
            result = result + map + "\n"
        return result

    def loadMap(self, fileName):
        if (fileName in self.__repository.getMaps()):
            self.__repository.loadMap(fileName)
        else:
            return False

    def saveMap(self, fileName):
        self.__repository.saveMap(fileName)

    def createRandomMap(self):
        self.__repository.createRandomMap()

    def addPopulation(self, population):
        self.__repository.addPopulation(population)

    def getPopulations(self):
        return self.__repository.getPopulations()