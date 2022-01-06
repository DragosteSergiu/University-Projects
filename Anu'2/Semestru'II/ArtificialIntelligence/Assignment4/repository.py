import os
import pickle
from domain import *
from map import Map


class Repository:
    def __init__(self):
        self.mapsRepresentation = []
        self.__populations = []
        self.map = Map()
        self.load_file()
        self.map.surface = self.mapsRepresentation[0]

    def initialize_random_map(self):
        cmap = Map()
        cmap.randomMap()
        self.mapsRepresentation.append(cmap.surface)

    @staticmethod
    def create_population(args):
        # args = [populationSize, individualSize] -- you can add more args
        return Population(args[1], args[2])

    # TO DO : add the other components for the repository:
    #    load and save from file, etc

    def load_file(self):
        if os.path.getsize('maps.pickle') > 0:
            with open('maps.pickle', 'rb') as file:
                # Call load method to deserialze
                myvar = pickle.load(file)
                self.mapsRepresentation = myvar

    def save_file(self):
        with open('maps.pickle', 'wb') as file:
            # A new file will be created
            pickle.dump(self.mapsRepresentation, file)


MAP = Repository().map