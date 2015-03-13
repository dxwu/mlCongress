import os
import re
import sys
from array import *
import numpy as np

# 
# getTopicDistributions(k, isTraining)
#	params: 
#		k - int number of topics
#		isTraining - boolean flag determines which topic distribution matrix to return
#	return: (pass, fail)
#		pass - (mp x k) matrix where mp is the number of pass documents.
#			Each row contains the topic distributions for each of k topics
#		fail - (mf x k) matrix where mf is the number of fail documents. 		
#			Each row contains the topic distributions for each of k topics
#   assumes: 
#		this file is located in 						mlCongress/RF
# 		labels.txt is located in 					   	mlCongress/labels
# 		topic_dist.txt for training data is located in 	mlCongress/train_features
#		topic_dist.txt for testing data is located in  	mlCongress/test_features
#
def getTopicDistributions(k, isTraining):
	labelsFile = "./labels/labels_k" + str(k) + ".txt"

	for line in open(labelsFile, 'r'):
		# training pass \ training fail \ test pass \ test fail
		numbers = line.split(',')
		if (len(numbers) != 4):
			print "check labels.txt file!"
			exit(1)

		numTrainingPass = int(numbers[0])
		numTrainingFail = int(numbers[1])
		numTestingPass = int(numbers[2])
		numTestingFail = int(numbers[3])

	# get text files based on training or testing
	# size of file based on training or testing
	if isTraining:
		numPass = numTrainingPass
		numFail = numTrainingFail
		topicDistributionFile = "./train_features/topic_dist_k" + str(k) + ".txt"
	else:
		numPass = numTestingPass
		numFail = numTestingFail
		topicDistributionFile = "./test_features/topic_dist_test_k" + str(k) + ".txt"

	topicDistributionPass = np.zeros(shape=(numPass, k))
	topicDistributionFail = np.zeros(shape=(numFail+10, k))
	documentNumber = 0
	lookingAtFail = False

	for topicDist_i in open(topicDistributionFile, 'r'):
		if ((documentNumber >= numPass) and (lookingAtFail == False)):
			documentNumber = 0 
			lookingAtFail = True

		individualTopics = topicDist_i.split(',')
		if (len(individualTopics) > k):
			print "given " + str(k) + " topics, but topic_dist.txt has " +len(individualTopics) + " topics!"
			exit(1)

		topicCount = 0
		for topicProbability in individualTopics:
			if (lookingAtFail == False):
				topicDistributionPass[documentNumber][topicCount] = topicProbability
			else:
				topicDistributionFail[documentNumber][topicCount] = topicProbability

			topicCount = topicCount + 1

		documentNumber = documentNumber + 1

		if (documentNumber > numPass + numFail):
			print "Error: topic_dist.txt file is longer than labels.txt says it is!"
			exit(1)

	return topicDistributionPass, topicDistributionFail


if __name__=='__main__':
	k = 6
	topicDistributionPass , topicDistributionFail = getTopicDistributions(k, False) 

	for i in topicDistributionPass:
		for t in range(0,k):
			print i[t],
		print
	"""
	print "----"
	for i in topicDistributionFail:
		for t in range(0,k):
			print i[t],
		print
	"""








