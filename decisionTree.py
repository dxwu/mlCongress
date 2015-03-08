from __future__ import division
import numpy

class RandomForest:

    def __init__(self, size, kSubset, maxD):

        self.size = size
        self.k = kSubset
        self.maxD = maxD
        self.forest = []

    def buildForest(self, passed, failed):

        numPass = passed.shape[0]
        numFail = failed.shape[0]

        for i in range(self.size):

            self.forest.append(DecisionTree(numPass, numFail, 0)) ### or 1?
            self.forest[i].buildDTree(self.k, self.maxD, passed, failed)

    def classError(self, pTest, fTest):

        pSize = pTest.shape[0]
        fSize = fTest.shape[0]

        good = 0

        for s in range(pSize):

            for tree in self.forest:

                if (tree.classify(pTest[s]) == 1):

                    good +=1

        for s in range(fSize):

            for tree in self.forest:

                if (tree.classify(fTest[s]) == 0):

                    good += 1


        return good / (self.size * (pSize + fSize))

    def predict(self, testDocs):

        m = testDocs.shape[0]
        predictions = zeros((m, 1))

        for s in range(m):

            passes = 0

            for tree in self.forest:

                passes += tree.classify(testDocs[s])

            if ((passes / self.size) > 0.5):

                predictions[s] = 1




class DecisionTree:

    def __init__(self, numPass, numFail, depth):

        self.left = null            # child node below threshold
        self.right = null            # child node above threshold
        self.numPass = numPass        # number passed
        self.numFail = numFail        # number failed
        self.depth = depth
        self.thresh = null             # splitting threshold
        self.feat = null             # splitting feature index
        self.decision = null
        self.postProb = null        # posterior probability = pass / total

    def addChildren(self, above, below):

        self.left = below
        self.right = above

    def calculatePostProb(self):

        self.postProb = self.numPass / (self.numPass + self.numFail)

    def makeDecision(self):

        if (self.numPass != 0 and self.numFail != 0):

            # choose class with higher posterior probability
            self.calculatePostProb()

            if (self.postProb > 1 - self.postProb):

                self.decision = 1

            else:

                self.decision = 0

        ##### if both are 0---disregard?

    def classify(self, test):

        node = self

        while (node.decision == null):

            if (test[node.feat] > node.thresh):

                node = node.right

            else:

                node = node.left

        return node.decision



    def highLowTally(self, samples, f, split):

        # tally number of samples above and below the 
        # given threshold for the given feature
        above = (samples[:,f] > split).sum()
        below = samples.shape[0] - high

        return (above, below)

    def makePassFail(self, samples):

        high = samples[:,self.feat] > self.thresh

        # generate new lists for samples above and 
        # below the threshold
        above = samples[high]
        below = samples[~high]

        return (above, below)

    def entropy(self, c1, c2):

        total = c1 + c2
        return (c1 / total) * numpy.log2(c1 / total) + \
               (c2 / total) * numpy.log2(c2 / total)

    def infoGain(self, f, split, passed, failed):

        total = self.numPass + self.numFail

        # tally new pass fail partitions
        (highPass, lowPass) = self.highLowTally(passed, f, split)
        (highFail, lowFail) = self.highLowTally(failed, f, split)

        # calculate entropies
        entWhole = entropy(self.numPass, self.numFail)
        entHigh = entropy(highPass, highFail) * ((highPass + highFail) / total)
        entLow = entropy(lowPass, lowFail) * ((lowPass + lowFail) / total)

        gain = entWhole - entHigh - entLow

        return gain

    def splitBinary(self, fsubset, passed, failed):

        m = self.numPass + self.numFail
        n = len(fsubset)

        maxGain = numpy.zeros((n, 2))    # [max feature gain][thresh]
        fArray = numpy.zeros((m, 2))    # [sample feature value][sample label]

        # for each feature
        # find threshold that yields max gain for each feature
        for i in range(n):

            # index of feature
            f = fsubset[i];

            # sort by feature value
            fArray[0:self.numPass,[0]] = passed[:,[f]]
            fArray[self.numPass + 1:self.numFail, [0]] = failed[:,[f]]
            fArray[0:self.numPass,[1]] = numpy.ones((self.numPass, 1))
            fArray = fArray[numpy.lexsort((fArray[:,0], ))]

            # look through entire feature specific matrix
            for s in range(m - 1):

                # if neighboring feature values have differing class labels
                if (fArray[s][1] != fArray[s + 1][1]):

                    # choose threshold to be midpoint
                    # calculate information gain for that threshold
                    split = (fArray[s][0] + fArray[s + 1][0]) / 2
                    gain = infoGain(f, split, passed, failed)

                    if (gain > maxGain[i][0]):

                        maxGain[i][0] = gain
                        maxGain[i][1] = thresh

        idx = numpy.argmax(maxGain[:,0])    # index of highest gain

        self.feat = fsubset[idx]        # feature index of highest gain
        self.thresh = maxGain[idx][1]    # corresponding threshold yielding highest gain

    def buildDTree(self, k, maxD, passed, failed):

        ###### EDIT HERE ######
        if (self.numPass == 0 or self.numFail == 0 or self.depth >= maxD):

            self.makeDecision()

        else:

            n = passed.shape[1]

            # generate random subset of features to split on
            # get threshold with highest information gain and the feature
            # to split on
            fsubset = random.sample(numpy.arange(n), k)
            self.splitBinary(fsubset, passed, failed)

            # generate new set of pass and fail lists
            (highPass, lowPass) = self.makePassFail(passed)
            (highFail, lowFail) = self.makePassFail(failed)

            # create children nodes at next depth
            above = DecisionTree(highPass.shape[0], highFail.shape[0], self.depth - 1)
            below = DecisionTree(lowPass.shape[0], lowFail.shape[0], self.depth - 1)

            self.addChildren(above, below)

            # build trees at children
            above.buildDTree(kSubset, highPass, highFail)
            below.buildDTree(kSubset, lowPass, lowFail)
