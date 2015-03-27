"""
cross_validation.py
Reads in feature vectors of passed and failed bills from train_features directory, and 
performs N-cross-validation to determine the optimal K, depth, and split size hyperparameters

K: number of features used to represent each bills
depth: the maximum depth of each decision tree in forest
split size: the number of randomly selected features to be considered at each split

You can modify N in pick_best_combo to control number of "folds" in N-cross-validation
You can modify k_range, d_range, and s_range to be the values of hyperparameters you want to cross-validate on

Outputs to:
	'./c_v_split.txt': K,depth,error,split,standard deviation
	'./c_v_K.txt': split,depth,error,depth,standard deviation
	'./c_v_depth.txt': K,split,error,depth,standard deviation
where each line consists of the hyperparameters, cross-validation error, and standard deviation (for error bars)
"""

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
import subprocess
from sklearn import tree

class HyperParams:
    def __init__(self, K, depth, split, err, sd):
    	self.K = K
    	self.depth = depth
    	self.split = split
    	self.err = err
    	self.sd = sd

    def __lt__ (self, other):
        return self.err < other.err

    def __gt__ (self, other):
        return other.__lt__(self)

    def __eq__ (self, other):
        return self.err == other.err

    def __ne__ (self, other):
        return not self.__eq__(other)

def pick_best_combo(k_arr,d_arr,s_arr):

	hyperparams = []
	for k in k_arr:
		[train_pass, train_fail] = format.getTopicDistributions(k, True)
		for depth in d_arr:
			for split in s_arr:
				if split > k:
					continue
				
				train_pass = numpy.random.permutation(train_pass)
				train_fail = numpy.random.permutation(train_fail)
				
				N=2
				mP=len(train_pass)
				mF=len(train_fail)

				error_vals = numpy.zeros(shape=(1,N))

				for j in range(0, N):

					train_pass_cv = numpy.concatenate((train_pass[0:math.floor(mP / N * j), :], \
					train_pass[math.floor(mP / N * (j + 1)):mP, :]),axis=0)

					train_fail_cv = numpy.concatenate((train_fail[0:math.floor(mF / N * j), :], \
					train_fail[math.floor(mF / N * (j + 1)):mF, :]),axis=0)

					valid_pass_cv = train_pass[math.floor(mP / N * j) : math.floor(mP / N * (j + 1)), :];

					valid_fail_cv = train_fail[math.floor(mF / N * j) : math.floor(mF / N * (j + 1)), :];

					forest = RandomForest(100, split, depth)
					forest.buildForest(train_pass_cv, train_fail_cv)
					error_vals[0,j] = forest.classError(valid_pass_cv, valid_fail_cv)
					
					####sci kit learn, used as comparison for debugging
					"""num_p = len(train_pass_cv)
					num_f = len(train_fail_cv)

					train_x = numpy.concatenate((train_pass_cv,train_fail_cv),axis=0)
					train_y = numpy.concatenate((numpy.ones(shape=(num_p,1)), numpy.zeros(shape=(num_f,1)) ), axis=0)

					clf = tree.DecisionTreeClassifier()
					clf = clf.fit(train_x,train_y)

					predictions = clf.predict(numpy.concatenate((valid_pass_cv,valid_fail_cv),axis=0))
					trueVals = numpy.concatenate((\
					numpy.ones(shape=(1,len(valid_pass_cv))),\
					numpy.zeros(shape=(1,len(valid_fail_cv)))),axis=1)
				
					print 'Error HERE: ' + str(sum(abs(predictions-trueVals)[0])/len(predictions))"""
					####

					print '(k, depth, split): ' + str(k) + ',' + str(depth) + ',' + str(split) + '; iteration: ' + str(j) + ', error:' + str(error_vals[0,j])
					
				hyperparams.append(HyperParams(k, depth, split, numpy.mean(error_vals), numpy.std(error_vals)))
	return hyperparams


if __name__=='__main__':

	k_range = [5,8,10,15,20]
	d_range = [2,4,6,8,10,12,14]
	s_range = [2,4,6,8]
	
	hyperparams = pick_best_combo(k_range,d_range,s_range)
	for obj in hyperparams:
		print 'Error: ' + str(obj.err) + ' k: ' + str(obj.K) + ' depth: ' + str(obj.depth) + ' split: ' + str(obj.split)

	f = open('./c_v_split.txt','w')

	for obj in hyperparams:
		f.write(str(obj.K) + ',' + str(obj.depth) + ',' + str(obj.err) + ',' + str(obj.split) + ',' + str(obj.sd) + '\n')
		
	f.close()

	f = open('./c_v_K.txt','w')
	for obj in hyperparams:
		f.write(str(obj.split) + ',' + str(obj.depth) + ',' + str(obj.err) + ',' + str(obj.K) + ',' + str(obj.sd) + '\n')

	f.close()

	f = open('./c_v_depth.txt','w')
	for obj in hyperparams:
		f.write(str(obj.K) + ',' + str(obj.split) + ',' + str(obj.err) + ',' + str(obj.depth) + ',' + str(obj.sd) + '\n')
		
	f.close()
	subprocess.call(["sort", "./c_v_depth.txt", "-o", "./c_v_depth.txt"])
	subprocess.call(["sort", "./c_v_split.txt", "-o", "./c_v_split.txt"])
	subprocess.call(["sort", "./c_v_K.txt", "-o", "./c_v_K.txt"])
