import os
import re
import sys
from heapq import nlargest
from array import *
import numpy as np

# only run for first 50 bills
# get top 2 topics for each bill

if __name__=='__main__':
	print "Top 2 topics for 50 bills\n"

	count = 0
	for document in open('./topic_dist.txt'):
		if (count % 10 != 0):
			count = count + 1
			continue;

		topic_probabilities = document.split(',')
		top2topics = np.argsort(topic_probabilities)[::-1][:2]

		# get bill title based on file

		print "bill " + str(count) 
		print "\t-topic " + str(top2topics[0]) 
		print "\t-topic " + str(top2topics[1])
		count = count + 1

			