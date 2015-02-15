import re
import numpy
import vocabulary
import os
import sys
import nltk
import shutil

if __name__=='__main__':
	x = int(re.sub('[^0-9a-zA-Z]+', '', open('./vocab_length.txt').read()))
	w_ids = [None]*x
	for line in open('./vocab.txt'):
		word_to_id = line.split(':')
		w_ids[int(word_to_id[0]) - 1] = word_to_id[1].strip()
	for i, line in enumerate(open('./top_word_ids.txt')):
		print('Topic ' + str(i))
		for num in line.split(','):
			print(w_ids[int(num) - 1])
		print('------')