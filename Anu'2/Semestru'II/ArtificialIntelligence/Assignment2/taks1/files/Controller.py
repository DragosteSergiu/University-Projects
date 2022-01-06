import pygame
from Node import Node
from Utils import GREEN
from Utils import v
from Utils import FUNCTIONS

class Controller():
    def __init__(self, Map, Drone):
        self.Map = Map
        self.Drone = Drone
        self.path = [ ]

    def searchAStar(self, initialX, initialY, finalX, finalY, OPTION):
        start_node = Node(None, (initialX, initialY))
        start_node.setF(0), start_node.setG(0), start_node.setH(0)
        end_node = Node(None, (finalX,finalY))
        end_node.setF(0), end_node.setG(0), end_node.setH(0)

        open_list = []
        closed_list = []

        open_list.append(start_node)

        while len(open_list) > 0:

            current_node = open_list[0]
            current_index = 0
            for index, item in enumerate(open_list):
                if item.f < current_node.f:
                    current_node = item
                    current_index = index

            open_list.pop(current_index)
            closed_list.append(current_node)

            if current_node == end_node:
                path = []
                current = current_node
                while current is not None:
                    path.append(current.position)
                    current = current.parent
                return path[::-1]

            children = []
            for new_position in v:

                node_position = (current_node.position[0] + new_position[0], current_node.position[1] + new_position[1])

                if node_position[0] < (len(self.Map.surface)) and node_position[0] > 0 and node_position[1] < (len(self.Map.surface[len(self.Map.surface)-1])) and node_position[1] > 0:
                    if self.Map.surface[node_position[0]][node_position[1]] == 0:
                        new_node = Node(current_node, node_position)
                        children.append(new_node)

            for child in children:

                if not child in closed_list:
                    child.setG(current_node.getG() + 1)
                    child.setH(FUNCTIONS[OPTION](child.position[0], child.position[1], end_node.position[0], end_node.position[1]))
                    child.setF(child.getG() + child.getH())

                    if not child in open_list:
                        open_list.append(child)
        return False

    def searchGreedy(self, initialX, initialY, finalX, finalY, OPTION):
        start_node = Node(None, (initialX, initialY))
        end_node = Node(None, (finalX, finalY))

        visited = [ ]
        unvisited = [ ]

        unvisited.append(start_node)

        while (len(unvisited) > 0):

            current_node = unvisited[0]
            current_index = 0

            for index, item in enumerate(unvisited):
                if item.h < current_node.h:
                    current_node = item
                    current_index = index

            unvisited.pop(current_index)
            visited.append(current_node)

            if (current_node == end_node):
                path = []
                current = current_node
                while current is not None:
                    path.append(current.position)
                    current = current.parent
                return path[::-1]

            children = [ ]
            for new_position in v:

                node_position = (current_node.position[0] + new_position[0], current_node.position[1] + new_position[1])

                if node_position[0] < (len(self.Map.surface)) and node_position[0] > 0 and node_position[1] < (
                len(self.Map.surface[len(self.Map.surface) - 1])) and node_position[1] > 0:
                    if self.Map.surface[node_position[0]][node_position[1]] == 0:
                        new_node = Node(current_node, node_position)
                        children.append(new_node)
            for child in children:

                if not child in visited:
                    child.setH(FUNCTIONS[OPTION](child.position[0], child.position[1], end_node.position[0], end_node.position[1]))
                    if not child in unvisited:
                        unvisited.append(child)
        return False


    def dummysearch(self):
        # example of some path in test1.map from [5,7] to [7,11]
        return [[5, 7], [5, 8], [5, 9], [5, 10], [5, 11], [6, 11], [7, 11]]

    def displayWithPath(self, image, path):
        mark = pygame.Surface((20, 20))
        mark.fill(GREEN)
        for move in path:
            image.blit(mark, (move[1] * 20, move[0] * 20))

        return image
