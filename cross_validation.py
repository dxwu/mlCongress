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

def features(k):
	#f_name = f_doc + '_k' + k + '.txt'
	#nr_of_lines = sum(1 for line in f_name)
	#feats = numpy.zeros(shape=(nr_of_lines,k))
	
	#for line in open(f_doc + '_k' + k + '.txt'):
	a = numpy.matrix('0.25, 0.7, 0.05, 0; 0.3,0.6,0.05,0.05')
	b = numpy.matrix('0.1,0.1,0.7,0.1; 0.4,0.1,0.5,0')
	c = numpy.matrix('0.25, 0.7, 0.05, 0; 0.3,0.6,0.05,0.05')
	d = numpy.matrix('0.1,0.1,0.7,0.1; 0.4,0.1,0.5,0')

	return [a,b,c,d]

def rf(a,b,c,d,e,f):
	return random.random()

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

def pick_best_combo(k_arr,d_arr,s_arr):

	hyperparams = []
	for k in k_arr:
		for depth in d_arr:
			for split in s_arr:
				if split > k:
					continue
				[train_pass, train_fail] = format.getTopicDistributions(k, True)
				#[test_pass, test_fail] = format.getTopicDistributions(k, False) #call David's function to get the four matrices
				N=5
				mP=len(train_pass)
				mF=len(train_fail)

				error = 0

				for j in range(0, N):
					#print str(len(train_pass))
					#print str(len(train_fail))

					train_pass_cv = numpy.concatenate((train_pass[0:math.floor(mP / N * j), :], \
					train_pass[math.floor(mP / N * (j + 1)):mP, :]),axis=0)

					train_fail_cv = numpy.concatenate((train_fail[0:math.floor(mF / N * j), :], \
					train_fail[math.floor(mF / N * (j + 1)):mF, :]),axis=0)

					valid_pass_cv = train_pass[math.floor(mP / N * j) : math.floor(mP / N * (j + 1)), :];

					valid_fail_cv = train_fail[math.floor(mF / N * j) : math.floor(mF / N * (j + 1)), :];

					forest = RandomForest(100, split, depth)
					forest.buildForest(train_pass_cv, train_fail_cv)
					error = error + forest.classError(valid_pass_cv, valid_fail_cv)

					#error = error + rf(train_pass_cv,train_fail_cv,valid_pass_cv,valid_fail_cv,depth,split)

					#print str(len(train_pass_cv)+len(valid_pass_cv))
					#print str(len(train_fail_cv)+len(valid_fail_cv))
					#print '----'

				error = error/N
				#print str(error) #number between 0 and 1
				hyperparams.append(HyperParams(k, depth, split, error))
	hyperparams.sort()
	return hyperparams


if __name__=='__main__':
	#features('doc_topic_word_count',k)
	#[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices
	random.seed(0)

	k_range = range(5,10)
	d_range = range(5,30)
	s_range = range(1,30)
	
	hyperparams = pick_best_combo(k_range,d_range,s_range)
	for obj in hyperparams:
		print 'Error: ' + str(hyperparams.err) + ' k: ' + str(hyperparams.K) + ' depth: ' + str(hyperparams.depth) + ' split: ' + str(hyperparams.split)

	"""best_combo = pick_best_combo(k_range,d_range,s_range)
	curr_depth = prev_depth = best_combo[0].depth
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
		start = False"""

	"""print 'Best set of parameters:'
	print 'depth: ' + str(curr_depth)
	print 'K: ' + str(curr_k)
	print 'split: ' + str(curr_split)"""
