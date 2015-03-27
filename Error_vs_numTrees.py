"""
Error_vs_numTrees.py
Compute the error for various number of decision trees in random forest for given K, number of topics.
Writes to:
	./numTreesError_Bigdataset_K{5,10,15,20}.txt
"""

import re
import numpy
import os
import sys
import nltk
import shutil
import os.path
import random
import format_lda_to_python as format
import math
from decisionTree import RandomForest


def partition(passed, failed):
	passed = numpy.random.permutation(passed)
	failed = numpy.random.permutation(failed)

	N=3
	mP=len(passed)
	mF=len(failed)
	j = 0

	train_pass = numpy.concatenate((passed[0:math.floor(mP / N * j), :], \
	passed[math.floor(mP / N * (j + 1)):mP, :]),axis=0)

	train_fail = numpy.concatenate((failed[0:math.floor(mF / N * j), :], \
	failed[math.floor(mF / N * (j + 1)):mF, :]),axis=0)

	test_pass = passed[math.floor(mP / N * j) : math.floor(mP / N * (j + 1)), :];

	test_fail = failed[math.floor(mF / N * j) : math.floor(mF / N * (j + 1)), :];
	return [train_pass, train_fail, test_pass, test_fail]

def RF_error(k,hyperparams):

	errors = numpy.zeros(10)
	
	"""
	#Partition train_features/ directory bills into training and testing set instead of using the actual testing set in test_features/ directory
	[passed, failed] = format.getTopicDistributions(k, True)
	[train_pass, train_fail, test_pass, test_fail] = partition(passed, failed)
	"""

	[train_pass, train_fail] = format.getTopicDistributions(k, True)
	[test_pass, test_fail] = format.getTopicDistributions(k, False)

	index = 0
	for num in range(1,11):
		
		forest = RandomForest(10*num, hyperparams[0], hyperparams[1])
		forest.buildForest(train_pass, train_fail)
		errors[num-1] = forest.classError(test_pass, test_fail)
		
		print 'NumTrees: ' + str(10*num) + '; Our Random Forest Error: ' + str(errors[num-1])
		index = index+1
	return errors


if __name__=='__main__':

	k_range = [5,8,10,15,20]
	hyperparams = [[4,10],[2,12],[8,12],[8,11],[5,14]] #these were the optimal hyperparameters for each K, found from cross-validation
	
	#compute error vs number of trees for K=k_range[i]. You can set i according to which K value you prefer
	i = 3
	err = RF_error(k_range[i],hyperparams[i])
	
	f = open('./numTreesVsError_K' + str(k_range[i]) + '.txt', 'w')
	f.write(','.join(map(str, err)) + '\n')
