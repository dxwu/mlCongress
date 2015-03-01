# mlCongress
Using topic models to predict congressional bill results
Barry Chen, Vivian Hu, David Wu

### Overview

Use billStatus.sh to separate bills into ones that passed and ones that did not pass

Use get_texts.sh to get the bill texts for each category

Use extract_words.py to generate a vocabulary for the bills

Use lda.m to generate topics:
1. change matlab working directory to be this one
2. simple usage: k = 10, alpha = 0.1, beta = 0.1, nIter = 100
	
    output: 
		top_word_ids.txt: the top words for each topic 
			(each row is a topic, with the top words for that topic (topwords.py maps these back to words))
		topic_dist: the topic distribution for each document 
			(each row is a document [pass documents first, then fail documents], with each entry the P(topic | document))
		word_dist: for each topic, the probablity that word will be in it 
			(each row is a topic, with each entry the P(word | topic))

### Python Enviornment Setup

pip install numpy, nltk

python

import nltk

nltk.download()

go to Corpora tab, select 'wordnet'