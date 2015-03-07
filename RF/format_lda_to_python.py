import os
import re
import sys
from array import *
import numpy as np

# arguments: generate_labels.py labels.txt topic_dist.txt

# for topic distribution:
# one matrix that has p(topic | document) for all pass documents (training)
# one matrix that has p(topic | document) for all fail documents (training)
# one matrix that has p(topic | document) for all pass documents (testing)
# one matrix that has p(topic | document) for all fail documents (testing)

# todo : OO classes for python
# auto finds text files instead of getting passed command line (based on k)

def getTopicDistributions(k, isTraining):
	# find labels file

	for line in open(sys.argv[1], 'r'):
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
		topicDistributionFile = 
	else:
		numPass = numTestingPass
		numFail = numTestingFail
		topicDistributionFile = 

	topicDistributionPass = np.zeros(shape=(numPass, k))
	topicDistributionFail = np.zeros(shape=(numFail, k))
	documentNumber = 0
	lookingAtFail = False

	for topicDist_i in open(sys.argv[2], 'r'):
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

	
	for i in topicDistributionFail:
		for t in range(0,k):
			print i[t],
		print


if __name__=='__main__':
	getTopicDistributions(5, true) 











