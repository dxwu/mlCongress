import os
import re
import sys
from heapq import nlargest
from array import *
import numpy as np

#
# Usage: python graph_word_dist.py | cat > plotmultiworddist.m
# 		then in matlab, run script
# use matlab to plot top 50 word probabilities (over all topics) for each topic
# outputs x (word number) and y (probability) arrays for each topic
#

# print words in format that matlab likes them
def printTop50 (top50words):
	print "[",
	for word in top50words:
		print '\'',
		for i in range(0,maxlen-len(words[word])):
			print '',
		print words[word],
		print ' \';'
	print "];"

if __name__=='__main__':
	numwords = int(re.sub('[^0-9a-zA-Z]+', '', open('./vocab_length.txt').read()))
	total_probability_for_word = np.zeros(numwords)
	num_lines = 0

	for line in open('./word_dist.txt'):
		probabilities = line.split(',')
		count = 0;
		for p in probabilities:
			total_probability_for_word[count] = float(p) + total_probability_for_word[count]
			count = count + 1

	# get ids for top 50 words
	top50words = np.argsort(total_probability_for_word)[::-1][:50]

	# read in vocab, map ids to words
	words = [None]*numwords
	for line in open('./vocab.txt'):
		id_to_word = line.split(':')
		words[int(id_to_word[0]) - 1] = id_to_word[1].strip() #words[id] = word

	# find longest word length (matlab matrix that contains words and labels
	# expects the words to be of equal length)
	maxlen = 0
	for wordindex in top50words:
		if len(words[wordindex]) > maxlen:
			maxlen = len(words[wordindex])

	# generate a graph for each topic
	topicCount = 0
	for line in open('./word_dist.txt'):
		probabilities = line.split(',')
		print "figure"
		print "x = 1:1:50;"
		print "y = [",
		for word in top50words:
			print probabilities[word],
		print "];"
		print "h = bar(x,y, 'r');"
		print "title('Topic " + str(topicCount) + "');"
		print "xlabels = ", 
		printTop50(top50words)
		print "ylabel('Probability(Word | Topic " + str(topicCount) + ")')"
		topicCount = topicCount + 1
		
		# insert template via http://www.mathworks.com/matlabcentral/answers/103026-how-can-i-rotate-my-x-axis-tick-labels-and-place-an-x-label-on-my-plot
		f = open('word_dist_graph_template.m', 'r')
		print f.read()

		print "\n"


