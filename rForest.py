from __future__ import division
import numpy
import random

class RandomForest:

    def __init__(self, size, kSubset, maxD):

        self.size = size            # number of trees in forest
        self.k = kSubset            # size of random subset of features
        self.maxD = maxD            # max depth
        self.forest = []            # array containing trees in forest
        self.OOB = None             # m x t matrix where m = size of train set; t = size of forest
                                    # keeps track of predicted label for every time a sample was OOB

    def buildForest(self, passed, failed):

        numPass = passed.shape[0]       # number of bills in train set passed
        numFail = failed.shape[0]       # number of bills in train set failed
        total = numPass + numFail       # total number of bills in train set
        f = passed.shape[1]             # number of features

        self.OOB = numpy.zeros((total, self.size))
        self.OOB.fill(numpy.nan)

        caseSet = numpy.vstack((passed, failed))    # pass-fail training set combined 

        for i in range(self.size):      # build all trees in forest

            trainPset = numpy.zeros((total, f))     # pass bag
            trainFset = numpy.zeros((total, f))     # fail bag

            np = 0
            nf = 0

            randSet = []        # set of random indices making up our bag

            for j in range(total):      # draw bag of size of original training set

                rand = numpy.random.randint(0, total)       # "draw" random sample with replacement
                randSet.append(rand)                        # append to index set

                if (rand < numPass):        # if index in pass range

                    trainPset[np] = caseSet[rand]   # add to pass bag
                    np += 1

                else:

                    trainFset[nf] = caseSet[rand]   # add to fail bag
                    nf += 1

            trainPset = trainPset[:np]          # trim pass/fail bags to size
            trainFset = trainFset[:nf]

            randSet = numpy.unique(randSet)     # remove duplicates

            test = []       # set of indices of oob "test" samples
            k = 0

            # go through entire training set
            # adding indices of oob samples to test
            for s in range(total):

                if (k == len(randSet)):

                    test.append(s)

                elif (s != randSet[k]):

                    test.append(s)

                else:

                    k += 1

            # create, add, and build new tree in forest
            self.forest.append(DecisionTree(trainPset.shape[0], trainFset.shape[0], 0, i))
            self.forest[i].buildDTree(self.k, self.maxD, trainPset, trainFset)

            # use tree to classify OOB samples
            self.OOBclassify(i, caseSet, test, numPass)

    def classError(self, pTest, fTest):

        pSize = pTest.shape[0]
        fSize = fTest.shape[0]

        correct = 0

        # for each passed test sample
        for s in range(pSize):

            passed = 0

            for tree in self.forest:

                # tally up each tree's vote for "pass"
                if (tree.classify(pTest[s]) == 1):

                    passed += 1

            # if majority vote is "pass", increment correct label tally
            if (passed > self.size - passed):

                correct += 1

        # for each failed test sample
        for s in range(fSize):

            failed = 0

            # tally up each tree's vote for "fail"
            for tree in self.forest:

                if (tree.classify(fTest[s]) == 0):

                    failed += 1

            # if majority vote is "fail", increment correct label tally
            if (failed > self.size - failed):

                correct += 1

        # return error = 1 - correct
        return 1 - (correct / (pSize + fSize))

    # method that classifies out-of-bag samples
    def OOBclassify(self, tree, samples, testIndices, numPass):

        for i in testIndices:

            # record classification
            self.OOB[i][tree] = self.forest[tree].classify(samples[i])

    # get OOB classification error
    def OOBestimate(self, numPass, numFail):

        total = numPass + numFail
        OOBvalues = numpy.nansum(self.OOB, axis = 1)    # sum "pass" votes across row
        error = 0

        for i in range(self.OOB.shape[0]):

            # if the ith value was ever an oob case
            if not (numpy.isnan(OOBvalues[i])):

                # number of times sample was OOB
                OOBcase = self.size - numpy.isnan(self.OOB[i]).sum()
                
                if (i < numPass):

                    # if failed is greater than passed
                    # i.e. if incorrectly labeled 'failed'
                    if (OOBvalues[i] < OOBcase - OOBvalues[i]):

                        error += 1

                else:

                    # if passed is greater than failed
                    # i.e. if incorrectly labeled 'passed'
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

    def highLowTally(self, samples, f, split):

        # tally number of samples above and below the 
        # given threshold for the given feature
        above = (samples[:,f] > split).sum()
        below = samples.shape[0] - above

        return (above, below)

    def makePassFail(self, samples):

        high = samples[:,self.feat] > self.thresh

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
        return -1 * ((c1 / total) * numpy.log2((c1 / total) + numpy.spacing(1)) + \
               (c2 / total) * numpy.log2((c2 / total) + numpy.spacing(1)))

    def infoGain(self, f, split, passed, failed):

        total = self.numPass + self.numFail

        # tally new pass fail partitions
        (highPass, lowPass) = self.highLowTally(passed, f, split)
        (highFail, lowFail) = self.highLowTally(failed, f, split)

        # calculate entropies
        entWhole = self.entropy(self.numPass, self.numFail)
        entHigh = self.entropy(highPass, highFail) * ((highPass + highFail) / total)
        entLow = self.entropy(lowPass, lowFail) * ((lowPass + lowFail) / total)

        gain = entWhole - entHigh - entLow

        return gain

    def splitBinary(self, fsubset, passed, failed):

        m = self.numPass + self.numFail
        n = len(fsubset)

        maxGain = numpy.zeros((n, 2))       # [max feature gain][thresh]
        fArray = numpy.zeros((m, 2))        # [sample feature value][sample label]

        # for each feature
        # find threshold that yields max gain for each feature
        for i in range(n):

            # index of feature
            f = fsubset[i];

            # sort by feature value
            fArray[0:self.numPass,[0]] = passed[:,[f]]
            fArray[self.numPass:, [0]] = failed[:,[f]]
            fArray[0:self.numPass,[1]] = numpy.ones((self.numPass, 1))

            fArray = fArray[numpy.lexsort((fArray[:,0], ))]

            # look through entire feature specific matrix
            for s in range(m - 1):

                # if neighboring feature values have differing class labels
                if (fArray[s][1] != fArray[s + 1][1]):

                    # choose threshold to be midpoint
                    # calculate information gain for that threshold
                    split = (fArray[s][0] + fArray[s + 1][0]) / 2
                    gain = self.infoGain(f, split, passed, failed)

                    if (gain > maxGain[i][0]):

                        maxGain[i][0] = gain
                        maxGain[i][1] = split

        idx = numpy.argmax(maxGain[:,0])    # index of highest gain

        self.feat = fsubset[idx]            # feature index of highest gain
        self.thresh = maxGain[idx][1]       # corresponding threshold yielding highest gain

    def buildDTree(self, k, maxD, passed, failed):

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
            above = DecisionTree(highPass.shape[0], highFail.shape[0], self.depth + 1, None)
            below = DecisionTree(lowPass.shape[0], lowFail.shape[0], self.depth + 1, None)

            self.addChildren(above, below)

            # build trees at children
            above.buildDTree(k, maxD, highPass, highFail)
            below.buildDTree(k, maxD, lowPass, lowFail)

