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
from rForest import *
from sklearn.linear_model import LogisticRegression

def sci_kit_error(k_arr,hyperparams):

	errors = numpy.zeros(len(k_arr)) #error values using sci-kit learn's random forest
	errors_finetuned = numpy.zeros(len(k_arr)) #error values using our own implementation of random forest, with optimal hyperparameters
	std = numpy.zeros(len(k_arr))
	std_finetuned = numpy.zeros(len(k_arr))
	errors_LR = numpy.zeros(len(k_arr))
	std_LR = numpy.zeros(len(k_arr))

	index = 0
	for k in k_arr:
		[train_pass, train_fail] = format.getTopicDistributions(k, True)
		[test_pass, test_fail] = format.getTopicDistributions(k, False)

		#[passed, failed] = format.getTopicDistributions(k, True)
		#[train_pass, train_fail, test_pass, test_fail] = partition(passed, failed)

		#[test_pass, test_fail] = format.getTopicDistributions(k, False) #call David's function to get the four matrices
		N=2
		error_vals = numpy.zeros(shape=(1,N)) 
		error_vals_finetuned = numpy.zeros(shape=(1,N)) 
		error_vals_LR = numpy.zeros(shape=(1,N)) 

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
		
		errors[index] = numpy.mean(error_vals[0])
		std[index] = numpy.std(error_vals[0])
		print 'SKLearn\'s Random Forest error: ' + str(errors[index]) + '; Standard deviation of each run: ' + str(std[index])

		for j in range(0, N):
		#Run sci-kit learn's logistic regression
			LR_Model = LogisticRegression()
			LR_Model = LR_Model.fit(train_x,train_y)

			predictions = LR_Model.predict(numpy.concatenate((test_pass,test_fail),axis=0))
			error_vals_LR[0,j] = sum(abs(predictions-trueVals)[0])/len(predictions)

		errors_LR[index] = numpy.mean(error_vals_LR[0])
		std_LR[index] = numpy.std(error_vals_LR[0])
		print 'Logistic Regression error: ' + str(errors_LR[index]) + '; Standard deviation of each run: ' + str(std_LR[index])
		
		#########
		for j in range(0, N):
			forest = RandomForest(100, hyperparams[index][0], hyperparams[index][1])
			forest.buildForest(train_pass, train_fail)
			ooberror = forest.OOBestimate(num_p, num_f)
			error_vals_finetuned[0,j] = forest.classError(test_pass, test_fail)
		errors_finetuned[index] = numpy.mean(error_vals_finetuned[0])
		std_finetuned[index] = numpy.std(error_vals_finetuned[0])
		print 'Our Random Forest error: ' + str(errors_finetuned[index]) + '; Standard deviation of each run: ' + str(std_finetuned[index])
		print 'Our OOB error: ' + str(ooberror)
		#########
		index = index+1
		#error = rf(train_pass,train_fail,test_pass,test_fail,depth,split)
		#print str(error)
		#print str(error) #number between 0 and 1
		#hyperparams.append(HyperParams(k, depth, split, error))
	#hyperparams.sort()
	return [errors, std, errors_LR, std_LR, errors_finetuned, std_finetuned]


if __name__=='__main__':
	#features('doc_topic_word_count',k)
	#[train_pass, train_fail, test_pass, test_fail] = features(k) #call David's function to get the four matrices

	k_range = [5]
	hyperparams = [[4,10]]#fill in k=15
	[err,std,errors_LR,std_LR,err_ft,std_ft] = sci_kit_error(k_range,hyperparams)
	
	f = open('./benchmarks.txt', 'w')
	f.write(','.join(map(str, err)) + '\n')
	f.write(','.join(map(str, std))+ '\n')
	f.write(','.join(map(str, errors_LR)) + '\n')
	f.write(','.join(map(str, std_LR)) + '\n')
	f.write(','.join(map(str, err_ft)) + '\n')
	f.write(','.join(map(str, std_ft)) + '\n')
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

