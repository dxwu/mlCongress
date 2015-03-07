import re
import numpy
import os
import sys
import nltk
import shutil
import os.path


def features(f_doc,k):
	f_name = f_doc + '_k' + k + '.txt'
	nr_of_lines = sum(1 for line in f_name)
	feats = numpy.zeros(shape=(nr_of_lines,k))
	
	for line in open(f_doc + '_k' + k + '.txt'):
		
def cross_validate(k, depth, split):

def pick_best_combo():
	for k in range(5,10):
		for depth in range(5,30):
			for split in range(1,min(k,30)):

class HyperParams:
    def __init__(self, pass_test, fail_test, excluds_stopwords=False):
		
if __name__=='__main__':
	#features('doc_topic_word_count',k)
	[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices
	curr_depth = prev_depth = 10
	curr_k = prev_k = 5
	curr_split = prev_split = 3
	start = True
	while not start and (prev_depth != curr_depth or prev_k != curr_k or curr_split != prev_split):

	for depth in range(3,30):
		#make sure to import
		for split in range(1,min(k,30)):
			error = rf(train_pass,train_fail,test_pass,test_fail,depth,split)