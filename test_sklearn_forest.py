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
from sklearn import tree
from decisionTree import RandomForest
from sklearn.linear_model import LogisticRegression

class HyperParams:
    def __init__(self, K, depth, split, err):
    	self.K = K
    	self.depth = depth
    	self.split = split
    	self.err = err

    def __lt__ (self, other):
        return self.err < other.err

    def __gt__ (self, other):
        return other.__lt__(self)

    def __eq__ (self, other):
        return self.err == other.err

    def __ne__ (self, other):
        return not self.__eq__(other)

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

def sci_kit_error(k_arr,hyperparams):

	errors = numpy.zeros(shape=(1,len(k_arr))) #error values using sci-kit learn's random forest
	errors_finetuned = numpy.zeros(shape=(1,len(k_arr))) #error values using our own implementation of random forest, with optimal hyperparameters
	std = numpy.zeros(shape=(1,len(k_arr)))
	std_finetuned = numpy.zeros(shape=(1,len(k_arr)))
	index = 0
	for k in k_arr:
		
		[passed, failed] = format.getTopicDistributions(k, True)

		[train_pass, train_fail, test_pass, test_fail] = partition(passed, failed)

		#[test_pass, test_fail] = format.getTopicDistributions(k, False) #call David's function to get the four matrices
		N=5
		error_vals = numpy.zeros(shape=(1,N)) 
		error_vals_finetuned = numpy.zeros(shape=(1,N)) 

		######## if you want to run sci-kit learn's random forest on training set (with cross validation) instead of the entire training/testing set
		"""
		train_pass = numpy.random.permutation(train_pass)
		train_fail = numpy.random.permutation(train_fail)

		mP=len(train_pass)
		mF=len(train_fail)

		for j in range(0, N):
			train_pass_cv = numpy.concatenate((train_pass[0:math.floor(mP / N * j), :], \
			train_pass[math.floor(mP / N * (j + 1)):mP, :]),axis=0)

			train_fail_cv = numpy.concatenate((train_fail[0:math.floor(mF / N * j), :], \
			train_fail[math.floor(mF / N * (j + 1)):mF, :]),axis=0)

			valid_pass_cv = train_pass[math.floor(mP / N * j) : math.floor(mP / N * (j + 1)), :];

			valid_fail_cv = train_fail[math.floor(mF / N * j) : math.floor(mF / N * (j + 1)), :];

			train_pass = train_pass_cv
			train_fail = train_fail_cv
			test_pass = valid_pass_cv
			test_fail = valid_fail_cv
			error_vals[0,j] = forest.classError(valid_pass_cv, valid_fail_cv)
		errors[index] = numpy.mean(error_vals)
		"""
		########

		num_p = len(train_pass)
		num_f = len(train_fail)

		train_x = numpy.concatenate((train_pass,train_fail),axis=0)
		train_y = numpy.concatenate((numpy.ones(shape=(num_p,1)), numpy.zeros(shape=(num_f,1)) ), axis=0)
		trueVals = numpy.concatenate((\
				numpy.ones(shape=(1,len(test_pass))),\
				numpy.zeros(shape=(1,len(test_fail)))),axis=1)

		for j in range(0, N):
		#Run sci-kit learn's decision tree
			clf = tree.DecisionTreeClassifier()
			clf = clf.fit(train_x,train_y)

			predictions = clf.predict(numpy.concatenate((test_pass,test_fail),axis=0))
			
			error_vals[0,j] = sum(abs(predictions-trueVals)[0])/len(predictions)
		errors[index] = numpy.mean(error_vals)
		std[index] = numpy.std(error_vals)
		print str(errors[index]) + '; ' + str(std[index])
		
		#########
		for j in range(0, N):
			forest = RandomForest(100, hyperparams[1][0], hyperparams[1][1])
			forest.buildForest(train_pass, train_fail)
			error_vals_finetuned[0,j] = forest.classError(test_pass, test_fail)
		errors_finetuned[index] = numpy.mean(error_vals_finetuned)
		std_finetuned[index] = numpy.std(error_vals_finetuned)
		print str(errors_finetuned[index]) + '; ' + str(std_finetuned[index])
		#########
		index = index+1
		#error = rf(train_pass,train_fail,test_pass,test_fail,depth,split)
		#print str(error)
		#print str(error) #number between 0 and 1
		#hyperparams.append(HyperParams(k, depth, split, error))
	#hyperparams.sort()
	return [errors, std, errors_finetuned, std_finetuned]


if __name__=='__main__':
	#features('doc_topic_word_count',k)
	#[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices
	random.seed(0)

	k_range = range(8,9)
	hyperparams = [[4,10],[2,12],[8,12],[8,11],[5,14]]#fill in k=15
	[err,std,err_ft,std_ft] = sci_kit_error(k_range,hyperparams)
	print err
	print std
	"""curr_depth = prev_depth = best_combo[0].depth
	curr_k = prev_k = best_combo[0].K
	curr_split = prev_split = best_combo[0].split
	start = True

	while not start and (prev_depth != curr_depth or prev_k != curr_k or curr_split != prev_split):
		prev_k = curr_k
		prev_depth = curr_depth
		prev_split = curr_split
		hyperparams = pick_best_combo([curr_k],[curr_depth],s_range)
		curr_split = hyperparams[0].split
		hyperparams = pick_best_combo(k_range,[curr_depth],[curr_split])
		curr_k = hyperparams[0].K
		hyperparams = pick_best_combo([curr_k],d_range,[curr_split])
		curr_depth = hyperparams[0].depth
		start = False

	print 'Best set of parameters:'
	print 'depth: ' + str(curr_depth)
	print 'K: ' + str(curr_k)
	print 'split: ' + str(curr_split)"""

