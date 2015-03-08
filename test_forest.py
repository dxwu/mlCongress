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
import decisionTree

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
				[test_pass, test_fail] = format.getTopicDistributions(k, False) #call David's function to get the four matrices
				
				testForest = RandomForest(split, k, depth)
				testForest.buildForest(train_pass, train_fail)
				error = testForest.classError(test_pass, test_fail)

				print str(error)
				#print str(error) #number between 0 and 1
				hyperparams.append(HyperParams(k, depth, split, error))
	hyperparams.sort()
	return hyperparams


if __name__=='__main__':
	#features('doc_topic_word_count',k)
	#[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices
	random.seed(0)

	k_range = range(5,6)
	d_range = range(7,8)
	s_range = range(3,4)
	
	best_combo = pick_best_combo(k_range,d_range,s_range)
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

