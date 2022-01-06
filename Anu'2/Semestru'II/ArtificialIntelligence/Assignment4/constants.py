# Creating some colors
BLUE = (0, 0, 255)
GRAYBLUE = (50, 120, 120)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)

# define directions
UP = 0
DOWN = 2
LEFT = 1
RIGHT = 3
SIZE = 50


# define indexes variations
directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]


def manhattanDistance(x1, y1, x2, y2):
    return abs(x1 - x2) + abs(y1 - y2)

#define constants for ACO
NO_ANTS = 500
ALPHA = 2
BETA = 1
RHO = 0.01
Q0 = 0.5
SENSORS = [(5, 3), (4, 9), (7, 15), (8, 5), (14, 3), (9, 16), (16, 12), (9, 12)]

undefined = 20