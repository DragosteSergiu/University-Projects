import copy
from matplotlib import pyplot as plt
from FileRepository import FileRepository
from Cluster import *
from Point import *

MAX_VALUE = 9999

aCluster = Cluster()
bCluster = Cluster()
cCluster = Cluster()
dCluster = Cluster()

def distance(x1, y1, x2, y2):
    return abs(float(x1)-float(x2)) + abs(float(y1)-float(y2))

def equals(list1, list2):
    eq = True
    for point1 in list1:
        type1 = point1.type
        x1 = point1.x
        y1 = point1.y
        isInList = False
        for point2 in list2:
            type2 = point2.type
            x2 = point2.x
            y2 = point2.y
            if (type1 == type2) and (x1 == x2) and (y1 == y2):
                isInList = True
        if isInList == False:
            eq = False

    return eq

class Solver:
    def __init__(self):
        self.repository = FileRepository()
        self.clusterMap = {"A" : aCluster, "B" : bCluster, "C" : cCluster, "D" : dCluster}
        self.pointsMap = { }

    def readFromFile(self):
        i = 0
        self.repository.readFromFile()
        for point in self.repository.points:
            if (point.type in self.clusterMap):
                if i < 500:
                    self.clusterMap["A"].addPoint(point)
                if i >= 500 and i < 1000:
                    self.clusterMap["B"].addPoint(point)
                if i >= 1000 and i < 1500:
                    self.clusterMap["C"].addPoint(point)
                if i >= 1500 and i < 2000:
                    self.clusterMap["D"].addPoint(point)
                i = i + 1

    def clearPointsMap(self):
        self.pointsMap.clear()

    def definePointsMap(self):
        for point in self.repository.points:
            self.pointsMap[point] = {"A" : 0, "B" : 0, "C" : 0, "D" : 0}

    def computePointsMap(self, aCentroid, bCentroid, cCentroid, dCentroid):
        for point in self.pointsMap:
            self.pointsMap[point]["A"] = distance(point.x, point.y, aCentroid[0], aCentroid[1])
            self.pointsMap[point]["B"] = distance(point.x, point.y, bCentroid[0], bCentroid[1])
            self.pointsMap[point]["C"] = distance(point.x, point.y, cCentroid[0], cCentroid[1])
            self.pointsMap[point]["D"] = distance(point.x, point.y, dCentroid[0], dCentroid[1])

    def computeCentroid(self, value):
        return self.clusterMap[value].calculateCentroid()

    def getMinimumPairFromMap(self, map):
        minKey = ""
        minValue = MAX_VALUE
        for key in map:
            if float(map[key]) < minValue:
                minKey = key
                minValue = map[key]
        return (minKey, minValue)

    def printResult(self):
        i = 1
        for cluster in self.clusterMap:
            print("---------")
            print("Cluster " + str(i))
            print("Cluster length: " + str(len(self.clusterMap[cluster].points)))
            result = self.clusterMap[cluster].stats()
            print("Stats: A="+str(result[0]) +"%, B="+str(result[1]) + "%, C="+str(result[2]) +"%, D="+str(result[3])+"%")
            print("Centroid: " + self.computeCentroid(cluster)[0].__str__()+", " + self.computeCentroid(cluster)[1].__str__())
            i += 1

    def computeStats(self):
        clusterStats = {}
        total = 2000*1999/2
        Positives = 0 # P = TP + FP
        Negatives = 0 # N = TN + FN
        truePositive = 0
        trueNegative = 0
        falsePositive = 0
        falseNegative = 0
        for cluster in self.clusterMap:
            clusterStats[cluster] = self.clusterMap[cluster].stats()
            number = len(self.clusterMap[cluster].points)
            Positives += number * (number-1) / 2
        for cluster in clusterStats:
            for i in range(0, len(clusterStats[cluster])):
                if (clusterStats[cluster][i] > 0):
                    truePositive += clusterStats[cluster][i] * (clusterStats[cluster][i] - 1) / 2
        Negatives = total - Positives
        falsePositive = Positives - truePositive
        #falseNegative = 16 * 476 + 10 * 466
        for i in range(0, 4):
            for j in ['A', 'B', 'C']:
                if j == 'A':
                    falseNegative += clusterStats['A'][i] * (clusterStats['B'][i] + clusterStats['C'][i] + clusterStats['D'][i])
                if j == 'B':
                    falseNegative += clusterStats['B'][i] * (clusterStats['C'][i] + clusterStats['D'][i])
                if j == 'C':
                    falseNegative += clusterStats['C'][i] * clusterStats['D'][i]
        trueNegative = Negatives - falseNegative
        print("Accuracy: " + str((truePositive + trueNegative)/total))
        print("Precision: " + str(truePositive / (truePositive + falsePositive)))
        print("Rappel: " + str(truePositive / (truePositive + falseNegative)))
        print("Score: " + str(truePositive / (truePositive + falsePositive + falseNegative)))

    def plot(self):
        colors = {
            'A': "red",
            'B': "blue",
            'C': "green",
            'D': "yellow"
        }

        #for i in range(1, 5):
            #for element in classes[i]:
                #plt.scatter(element[1], element[2], c=colors[i], marker='.')
            #plt.scatter(centersList[i - 1][0], centersList[i - 1][1], c="black", marker='x')
        for cluster in self.clusterMap:
            for point in self.clusterMap[cluster].points:
                #print(point.type, point.x, point.y)
                plt.scatter(float(point.x), float(point.y), c=colors[point.type], marker='.')
            plt.scatter(self.clusterMap[cluster].calculateCentroid()[0], self.clusterMap[cluster].calculateCentroid()[1], c="black", marker='x')
        plt.plot()
        plt.savefig("plot.png")
        plt.show()

    def run(self):
        self.readFromFile()
        global aCluster, bCluster, cCluster, dCluster
        i = 0
        continueExecution = True
        while continueExecution:
            self.definePointsMap()
            print("iteration: " + str(i))
            i = i+1
            aCentroid = self.computeCentroid("A")
            bCentroid = self.computeCentroid("B")
            cCentroid = self.computeCentroid("C")
            dCentroid = self.computeCentroid("D")
            newACluster = Cluster()
            newBCluster = Cluster()
            newCCluster = Cluster()
            newDCluster = Cluster()
            newClusterMap = {"A" : newACluster, "B" : newBCluster, "C" : newCCluster, "D" : newDCluster}
            self.computePointsMap(aCentroid, bCentroid, cCentroid, dCentroid)
            for point in self.pointsMap:
                pair = self.getMinimumPairFromMap(self.pointsMap[point])
                newClusterMap[pair[0]].addPoint(point)
            if (equals(newACluster.points, aCluster.points) == True) \
                    and (equals(newBCluster.points, bCluster.points) == True) \
                    and (equals(newCCluster.points, cCluster.points) == True) \
                    and (equals(newDCluster.points, dCluster.points) == True):
                continueExecution = False
            else:
                aCluster.points = copy.deepcopy(newACluster.points)
                bCluster.points = copy.deepcopy(newBCluster.points)
                cCluster.points = copy.deepcopy(newCCluster.points)
                dCluster.points = copy.deepcopy(newDCluster.points)


if __name__ == "__main__":
    solver = Solver()
    solver.run()
    #solver.printResult()
    solver.computeStats()
    solver.plot()