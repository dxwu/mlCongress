import re
import numpy
import os
import sys
import shutil
import os.path
import random
import format_lda_to_python as format
import math
from rForest import *

def classify(k, depth, split):
	
	[train_pass, train_fail] = format.getTopicDistributions(k, True)
	train_pass = numpy.random.permutation(train_pass)
	train_fail = numpy.random.permutation(train_fail)
	caseSet = numpy.vstack((train_pass, train_fail))

	print "# topics: " + str(len(train_fail[0]))
	print "# pass: " + str(len(train_pass))
	print "# fail: " + str(len(train_fail))
				
	[test_pass, test_fail] = format.getTopicDistributions(k, False)

	forest = RandomForest(100, split, depth)
	forest.buildForest(train_pass, train_fail)
	ooberror = forest.OOBestimate(train_pass.shape[0], train_fail.shape[0])
	
	error = forest.classError(test_pass, test_fail)

	print "Classification error: " + str(error)
	print "OOB error: " + str(ooberror)

	forest.varImportance(caseSet, k, train_pass.shape[0])
	forest.printVarImpt()


###### TESTED HYPERPARAMTER COMBOS ######
# classify(5, 10, 2)
# classify(5, 3, 3)

classify(8, 3, 3)
