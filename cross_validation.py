import re
import numpy
import os
import sys
import nltk
import shutil
import os.path
import random


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

def pick_best_combo(k1,k2,d1,d2,s1,s2):

	hyperparams = []
	for k in range(k1,k2):
		for depth in range(d1,d2):
			for split in range(s1,min(k,s2)):
				[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices
				error = rf(train_pass,train_fail,test_pass,test_fail,depth,split)
				hyperparams.append(HyperParams(k, depth, split, error))
	hyperparams.sort()
	return hyperparams


if __name__=='__main__':
	#features('doc_topic_word_count',k)
	#[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices
	random.seed(0)
	
	best_combo = pick_best_combo(5,10,5,30,1,30)
	curr_depth = prev_depth = best_combo[0].depth
	curr_k = prev_k = best_combo[0].K
	curr_split = prev_split = best_combo[0].split
	start = True

	while not start and (prev_depth != curr_depth or prev_k != curr_k or curr_split != prev_split):
		prev_k = curr_k
		prev_depth = curr_depth
		prev_split = curr_split
		hyperparams = pick_best_combo(curr_k,curr_k+1,curr_depth,curr_depth+1,1,30)
		curr_split = hyperparams[0].split
		hyperparams = pick_best_combo(5,10,curr_depth,curr_depth+1,curr_split,curr_split+1)
		curr_k = hyperparams[0].K
		hyperparams = pick_best_combo(curr_k,curr_k+1,5,30,curr_split,curr_split+1)
		curr_depth = hyperparams[0].depth
		start = False

	print 'Best set of parameters:'
	print 'depth: ' + str(curr_depth)
	print 'K: ' + str(curr_k)
	print 'split: ' + str(curr_split)

	"""for depth in range(3,30):
		#make sure to import
		for split in range(1,min(k,30)):
			error = rf(train_pass,train_fail,test_pass,test_fail,depth,split)"""