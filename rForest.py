from __future__ import division
import numpy
import random

class RandomForest:

    def __init__(self, size, kSubset, maxD):

        self.size = size
        self.k = kSubset
        self.maxD = maxD
        self.forest = []
        self.OOB = None
        self.OOBpredict = None      # [OOB correct for a given tree]
        self.varImpt = None         # [tree][feature]

    def buildForest(self, passed, failed):

        numPass = passed.shape[0]
        numFail = failed.shape[0]
        total = numPass + numFail
        f = passed.shape[1]
        split = (total * 2) // 3

        self.OOB = numpy.zeros((total, self.size))
        self.OOB.fill(numpy.nan)
        self.OOBpredict = numpy.zeros((self.size, 1))
        # self.OOB = numpy.zeros((total, 2))   # [# of times OOB case][predict passed]
        # print self.OOB

        caseSet = numpy.vstack((passed, failed))

        for i in range(self.size):

            randSet = numpy.arange(total)
            numpy.random.shuffle(randSet)

            train = randSet[:split]     # random indices of train samples
            test = randSet[split:]      # random indices for OOB samples

            train.sort()                # order indices, so we know how to divide
            test.sort()                 # samples into pass and fail

            trainSet = caseSet[train]   # bootstrap sample
            passFailThresh = sum(i < numPass for i in train)

            # split bootstrap sample into pass and fail
            trainPset = trainSet[:passFailThresh]
            trainFset = trainSet[passFailThresh:]

            self.forest.append(DecisionTree(trainPset.shape[0], trainFset.shape[0], 0, i)) ### or 1?
            self.forest[i].buildDTree(self.k, self.maxD, trainPset, trainFset)

            # testSet = caseSet[test]     # OOB sample
            # print testSet

            # testPset = testSet[test < numPass]
            # testFset = testSet[test >= numPass]

            # use tree to classify OOB samples
            self.OOBclassify(i, caseSet, test, numPass)
            # print "---OOBpredict"
            # print OOBpredict
            # self.OOB[:,0][test] += 1         # increment # times sample has been OOB

            # increment by pass prediction
            # for i in range(test.shape[0]):

                # print "test[i] " + str(test[i])
                # print "in bounds? " + str(self.OOB[0][1])
                # print "in bounds? " + str(self.OOB[1][1])
                # self.OOB[test[i]][1] += OOBpredict[i]

    def classError(self, pTest, fTest):

        pSize = pTest.shape[0]
        fSize = fTest.shape[0]

        correct = 0

        for s in range(pSize):

            passed = 0

            for tree in self.forest:

                if (tree.classify(pTest[s]) == 1):

                    passed += 1

            if (passed > self.size - passed):

                correct += 1

        for s in range(fSize):

            failed = 0

            for tree in self.forest:

                if (tree.classify(fTest[s]) == 0):

                    failed += 1

            if (failed > self.size - failed):

                correct += 1


        return 1 - (correct / (pSize + fSize))

    def varImportance(self, samples, features, numPass):

        total = samples.shape[0]
        self.varImpt = numpy.zeros((self.size + 1, features))   # [tree][feature]

        for n in range(features):

            for i in self.forest:

                nonNaN = numpy.arange(total)
                nonNaN = nonNaN[~numpy.isnan(self.OOB[:,i.id])]
                original = samples[:,n][nonNaN]

                permed = samples[:,n][nonNaN]
                numpy.random.shuffle(permed)
                samples[:,n][nonNaN] = permed

                for m in nonNaN:

                    if (m < numPass and i.classify(samples[m]) == 1):

                        self.varImpt[i.id][n] -= 1

                    elif (m >= numPass and i.classify(samples[m]) == 0):

                        self.varImpt[i.id][n] -= 1

                self.varImpt[i.id][n] += self.OOBpredict[i.id]

                samples[:,n][nonNaN] = original

            self.varImpt[self.size][n] = numpy.mean(self.varImpt[:self.size][n])

        # print "----OOB"
        # print self.OOB[:5]
        # print "----varImpt"
        # print self.varImpt

    def printVarImpt(self):

        for i in range(self.varImpt.shape[1]):

            print "F", i, ": ", self.varImpt[self.size][i]

    def OOBclassify(self, tree, samples, testIndices, numPass):

        for i in testIndices:

            self.OOB[i][tree] = self.forest[tree].classify(samples[i])

            # tally number correctly classified for a given tree
            # in an out of bag set
            if (i < numPass and self.OOB[i][tree] == 1):

                self.OOBpredict[tree] += 1

            elif (i >= numPass and self.OOB[i][tree] == 0):

                self.OOBpredict[tree] += 1


    def OOBestimate(self, numPass, numFail):

        total = numPass + numFail
        OOBvalues = numpy.nansum(self.OOB, axis = 1)
        error = 0

        for i in range(self.OOB.shape[0]):

            # if the ith value was ever an oob case
            if not (numpy.isnan(OOBvalues[i])):

                if (i < numPass):

                    # if failed is greater than passed
                    # i.e. if incorrectly labeled 'failed'
                    OOBcase = self.size - numpy.isnan(self.OOB[i]).sum()
                    if (OOBvalues[i] < OOBcase - OOBvalues[i]):

                        error += 1

                else:

                    # if passed is greater than failed
                    # i.e. if incorrectly labeled 'passed'
                    OOBcase = self.size - numpy.isnan(self.OOB[i]).sum()
                    if (OOBvalues[i] > OOBcase - OOBvalues[i]):

                        error += 1

            # otherwise, subtract from oob total
            else:

                total -= 1


        return error / total

    def predictNoLabels(self, testDocs):

        m = testDocs.shape[0]
        predictions = zeros((m, 1))

        for s in range(m):

            passes = 0

            for tree in self.forest:

                passes += tree.classify(testDocs[s])

            if ((passes / self.size) > 0.5):

                predictions[s] = 1

        return predictions




class DecisionTree:

    def __init__(self, numPass, numFail, depth, id):

        self.left = None            # child node below threshold
        self.right = None           # child node above threshold
        self.numPass = numPass      # number passed
        self.numFail = numFail      # number failed
        self.depth = depth
        self.thresh = None          # splitting threshold
        self.feat = None            # splitting feature index
        self.decision = None
        self.postProb = None        # posterior probability = pass / total
        self.id = id

    def addChildren(self, above, below):

        self.left = below
        self.right = above

    def calculatePostProb(self):

        self.postProb = self.numPass / (self.numPass + self.numFail)

    def makeDecision(self):

        if (self.numPass + self.numFail != 0):

            # choose class with higher posterior probability
            self.calculatePostProb()

            if (self.postProb > 1 - self.postProb):

                self.decision = 1

            else:

                self.decision = 0

        ##### if both are 0---disregard?

    def classify(self, test):

        node = self

        # traverse tree from current node until 
        # a leaf/decision node is found
        while (node.decision == None):

            if (test[node.feat] > node.thresh):

                node = node.right

            else:

                node = node.left

        return node.decision

    # def OOBclassify(self, forest, samples, testIndices):

    #     for i in testIndices:

    #         self.OOB[]

    #     m = samples.shape[0]
    #     predictions = numpy.zeros((m, 1))

    #     for i in range(m):

    #         predictions[i] = self.classify(samples[i])

    #     return predictions

    def highLowTally(self, samples, f, split):

        # tally number of samples above and below the 
        # given threshold for the given feature
        above = (samples[:,f] > split).sum()
        below = samples.shape[0] - above

        return (above, below)

    def makePassFail(self, samples):

        high = samples[:,self.feat] > self.thresh
        # print "----sum"
        # print high.sum()

        # generate new lists for samples above and 
        # below the threshold
        above = samples[high]
        below = samples[~high]

        return (above, below)

    def gini(self, c1, c2):

        total = c1 + c2
        return 1 - ((c1**2 - c2**2) / ((total + numpy.spacing(1))**2))

    def entropy(self, c1, c2):

        total = c1 + c2
        # print(c2 / total)
        # print(c1 / total)
        return -1 * ((c1 / total) * numpy.log2((c1 / total) + numpy.spacing(1)) + \
               (c2 / total) * numpy.log2((c2 / total) + numpy.spacing(1)))

    def infoGain(self, f, split, passed, failed):

        total = self.numPass + self.numFail

        # tally new pass fail partitions
        (highPass, lowPass) = self.highLowTally(passed, f, split)
        (highFail, lowFail) = self.highLowTally(failed, f, split)

        # print "---high", str(highPass), str(highFail)
        # print "---low", str(lowPass), str(lowFail)

        # print "----total", self.entropy(self.numPass, self.numFail)
        # print "----high", self.entropy(highPass, highFail)
        # print "----low", self.entropy(lowPass, lowFail)

        # calculate entropies
        entWhole = self.entropy(self.numPass, self.numFail)
        entHigh = self.entropy(highPass, highFail) * ((highPass + highFail) / total)
        entLow = self.entrop(lowPass, lowFail) * ((lowPass + lowFail) / total)

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
            # print "---FEATURE: " + str(f)

            # sort by feature value
            fArray[0:self.numPass,[0]] = passed[:,[f]]
            fArray[self.numPass:, [0]] = failed[:,[f]]
            fArray[0:self.numPass,[1]] = numpy.ones((self.numPass, 1))

            # print "---fArray Presort"
            # print fArray

            fArray = fArray[numpy.lexsort((fArray[:,0], ))]

            # print "---fArray Post"
            # print fArray

            # print fArray[:,[1]]

            # print "-----farray"
            # print fArray
            # print "----end farray"

            # look through entire feature specific matrix
            for s in range(m - 1):

                # if neighboring feature values have differing class labels
                if (fArray[s][1] != fArray[s + 1][1]):

                    # choose threshold to be midpoint
                    # calculate information gain for that threshold
                    split = (fArray[s][0] + fArray[s + 1][0]) / 2
                    # print "----split: ", split
                    gain = self.infoGain(f, split, passed, failed)

                    # print "----gain: ", gain

                    if (gain > maxGain[i][0]):

                        maxGain[i][0] = gain
                        maxGain[i][1] = split

        idx = numpy.argmax(maxGain[:,0])    # index of highest gain

        self.feat = fsubset[idx]        # feature index of highest gain
        self.thresh = maxGain[idx][1]    # corresponding threshold yielding highest gain

        # print self.feat, self.thresh

    def buildDTree(self, k, maxD, passed, failed):

        ###### EDIT HERE ######
        # print "numPass: ", self.numPass
        # print "numFail: ", self.numFail
        # print "depth: ", self.depth
        if (self.numPass == 0 or self.numFail == 0 or self.depth >= maxD):

            self.makeDecision()
            # print "----"
            # print "made decision: ", self.decision
            # print "at depth: ", self.depth
            # print "----"

        else:

            n = passed.shape[1]

            # generate random subset of features to split on
            # get threshold with highest information gain and the feature
            # to split on
            fsubset = random.sample(numpy.arange(n), k)
            self.splitBinary(fsubset, passed, failed)

            # print "-----thresh/feature"
            # print self.thresh, self.feat
            # generate new set of pass and fail lists
            (highPass, lowPass) = self.makePassFail(passed)
            (highFail, lowFail) = self.makePassFail(failed)


            # print "---thresh", self.thresh
            # print "---feat", self.feat
            # print "---high"
            # print highPass
            # print "-"
            # print highFail
            # print "---low"
            # print lowPass
            # print "-"
            # print lowFail

            # create children nodes at next depth
            above = DecisionTree(highPass.shape[0], highFail.shape[0], self.depth + 1, None)
            below = DecisionTree(lowPass.shape[0], lowFail.shape[0], self.depth + 1, None)

            # print "----children----"
            # print "above", above.numPass, above.numFail, above.depth
            # print "below", below.numPass, below.numFail, above.depth

            self.addChildren(above, below)

            # build trees at children
            above.buildDTree(k, maxD, highPass, highFail)
            below.buildDTree(k, maxD, lowPass, lowFail)

            # print "---depth", self.depth


# dTree = DecisionTree(2, 3, 0)
# rF = RandomForest(2, 2, 2)
# passed = numpy.array([[0.15, 0.23, 0.29, 0.33], [0.10, 0.07, 0.45, 0.48]])
# failed = numpy.array([[0.27, 0.32, 0.13, 0.28], [0.17, 0.29, 0.37, 0.17], [0.43, 0.18, 0.06, 0.33]])
# fsub = random.sample(numpy.arange(4), 2)
# dTree.buildDTree(2, 2, passed, failed)

