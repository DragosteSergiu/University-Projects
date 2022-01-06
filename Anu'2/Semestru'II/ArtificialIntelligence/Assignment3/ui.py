# -*- coding: utf-8 -*-


# imports
from gui import *
from controller import *
from repository import *
from domain import *


# create a menu
#   1. map options:
#         a. create random map
#         b. load a map
#         c. save a map
#         d. visualise map
#   2. EA options:
#         a. parameters setup
#         b. run the solver
#         c. visualise the statistics
#         d. view the drone moving on a path
#              function gui.movingDrone(currentMap, path, speed, markseen)
#              ATENTION! the function doesn't check if the path passes trough walls
class UI:
    def __init__(self):
        repository = Repository()
        self.__controller = Controller(repository)
        self.__parameters = [ ]

    def printMainMenu(self):
        print("1 - map options")
        print("2 - EA options")
        print("x - exit")

    def printMapOptions(self):
        print("a - create random map")
        print("b - load a map")
        print("c - save a map")
        print("d - visualize map")
        print("x - return to main menu")

    def printEAOptions(self):
        print("a - setup parameters")
        print("b - run the solver")
        print("c - visualize the statistics")
        print("d - view the drone moving on a path")
        print("x - return to main menu")

    def createRandom(self, isGenerated, areSettedUp, isExecuted):
        self.__controller.createRandomMap()
        print("..creating random map")
        return True, areSettedUp, isExecuted

    def load(self, isGenerated, areSettedUp, isExecuted):
        print("Saved files: ")
        print(self.__controller.savedMapsToString())
        print("Give the name of the file: ")
        fileName = input()
        self.__controller.loadMap(fileName)
        print("..loading map from the file " + fileName)
        return True, areSettedUp, isExecuted

    def save(self, isGenerated, areSettedUp, isExecuted):
        if (isGenerated == True):
            print("Give the name of the file: ")
            fileName = input()
            self.__controller.saveMap(fileName)
            print("..saving map in the file " + fileName)
        else:
            print("..cannot save the map in the file, maybe generate a map")
        return isGenerated, areSettedUp, isExecuted

    def visualize(self, isGenerated, areSettedUp, isExecuted):
        if (isGenerated == True):
            print("..visualizing the map for 5 seconds")
            map = self.__controller.getMap()
            screen = initPyGame((map.getRows() * 20, map.getColumns() * 20))
            screen.blit(image(map), (0, 0))
            pygame.display.flip()
            time.sleep(5)
        else:
            print("..cannot visualize the map, maybe generate a map")
        return isGenerated, areSettedUp, isExecuted

    def setupParameters(self, isGenerated, areSettedUp, isExecuted):
        if (isGenerated == True):
            self.__parameters = []
            print("..setting up the parameters")
            print("Give the population size: ")
            populationSize = int(input())
            self.__parameters.append(populationSize)
            print("Give the individual size: ")
            individualSize = int(input())
            self.__parameters.append(individualSize)
            print("Give the number for selection: ")
            selectionNumber = int(input())
            self.__parameters.append(selectionNumber)
            print("Give the number of populations: ")
            numberOfPopulations = int(input())
            self.__parameters.append(numberOfPopulations)
            return isGenerated, True, isExecuted
        else:
            print("..cannot set up the parameters, maybe generate a map")
            return isGenerated, areSettedUp, isExecuted

    def runSolver(self, isGenerated, areSettedUp, isExecuted):
        if (isGenerated == True and areSettedUp == True):
            print("..running the solver")
            self.__controller.solver(self.__parameters[0], self.__parameters[1], self.__parameters[2], self.__parameters[3])
            return isGenerated, areSettedUp, True
        else:
            print("..cannot run the solver, maybe generate a map, or setup the parameters")
            return isGenerated, areSettedUp, isExecuted

    def displayStatistics(self, isGenerated, areSettedUp, isExecuted):
        if (isGenerated == True and areSettedUp == True and isExecuted ==True):
            print("..displaying the statistics")
            populations = self.__controller.getPopulations()
            for i in range(0, len(populations)-1):
                populations[i].evaluate(self.__controller.getMap())
                print(populations[i].populationStatistics(i))
            return isGenerated, areSettedUp, isExecuted
        else:
            print("..cannot display the statistics, maybe generate a map, setup the parameters, or run the solver")
            return isGenerated, areSettedUp, isExecuted

    def viewTheDrone(self, isGenerated, areSettedUp, isExecuted):
        if (isGenerated == True and areSettedUp == True and isExecuted == True):
            print("..visualizing the drone moving on a path")
            path = self.__controller.getPopulations()[len(self.__controller.getPopulations())-1].getIndividuals()[0].getPath()
            movingDrone(self.__controller.getMap(), path)
            return isGenerated, areSettedUp, isExecuted
        else:
            print("..cannot visualize the drone moving, maybe generate a map, setup the parameters, or run the solver")
            return isGenerated, areSettedUp, isExecuted

    def run(self):
        mapCommands = {"a" : self.createRandom, "b" : self.load, "c" : self.save, "d" : self.visualize}
        eaCommands = {"a" : self.setupParameters, "b" : self.runSolver, "c" : self.displayStatistics, "d": self.viewTheDrone}
        isGenerated = False
        areSettedUp = False
        isExecuted = False
        print("Hello user!")
        while True:
            self.printMainMenu()
            print("Give the command: ")
            command = input()
            if command == "1":
                while True:
                    self.printMapOptions()
                    print("Give the command: ")
                    command = input()
                    if command in mapCommands:
                        isGenerated, areSettedUp, isExecuted = mapCommands[command](isGenerated, areSettedUp, isExecuted)
                    else:
                        break
            elif command == "2":
                while True:
                    self.printEAOptions()
                    print("Give the command: ")
                    command = input()
                    if command in eaCommands:
                        isGenerated, areSettedUp, isExecuted = eaCommands[command](isGenerated, areSettedUp, isExecuted)
                    else:
                        break
            else:
                print("..exit")
                break


if __name__ == "__main__":
    ui = UI()
    ui.run()