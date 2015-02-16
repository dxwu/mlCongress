import os
import re
import sys
from heapq import nlargest
from array import *
import numpy as np

# only run for first 50 bills
# get top 2 topics for each bill

if __name__=='__main__':
	print "%topic distributions for 50 bills\n"
	print "y = [",
	count = 0
	for document in open('./topic_dist.txt'):
		if (count % 10 != 0):
			count = count + 1
			continue;

		topic_probabilities = document.split(',')

		# get bill title based on file

		for topic in topic_probabilities:
			print str(topic).replace('\n', ''),

		print ";",
		count = count + 1

	
	print "];"
	print "bar(y, 'group', 'BarWidth', 1)"
	print "title('Topic Distributions for 50 bills');"
	print "xlabel('Bill Number');"
	print "axis([0,51,0,1.01])"
	print "ylabel('Probability(Topic | Document)');"
	print "legend('Topic 0', 'Topic 1', 'Topic 2', 'Topic 3', 'Topic 4');"
			