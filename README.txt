CONGRESSIONAL BILL OUTCOME PREDICTION

README

Environment Requirements:
 - MATLAB
 - Python
 - nltk (and wordnet)
 - numpy
 - scipy
 - scikit-learn

WARNING:

If the warning " '/Applications/MATLAB_R2014b.app/bin/matlab' is not a file " appears
	- You probably have a different version of Matlab!
	- Simply modify lines 8 and 10 of ./buildLDA.py to be the correct paths to your version of MATLAB

NOTES:
 - The data sets provided are significantly smaller than what we've been using for testing. Results may vary.
 - The folder may contain several empty directories, i.e. ./labels, ./test_features, ./train_features, but files will be read to them by the scripts
 - ./pass_training, ./fail_training, ./pass_test, and ./fail_test contain the training/test bills by classification

####TESTING####
RUN [SIMPLE CLASSIFICATION]: in the command line
 1. For LDA for k topics: python ./buildLDA.py
	- script will prompt you for a value of k
	- produces 'perplexity.fig' - graph of the perplexity from LDA
 2. For classification: ./test_sklearn_forest.sh
	- prints classification errors from 
		- scikit-learn random forest
		- scikit-learn logistic regression
		- our random forest
	- writes results to a file that can be used for visualization - 'benchmarks.txt'
	- script simply calls test_sklearn_forest.py but throws out warnings from scikit-learn
 3. Graph classification results (optional)
	- run ./plot_RF_and_benchmarks.m file in MATLAB with results file 'benchmarks.txt' in same directory
		- produces 'benchmark.fig'

RUN [CROSS-VALIDATION]: in the command line
 1. For LDA for k topics: python ./buildLDA.py
	- script will prompt you for a value of k
 2. For cross-validation: python ./cross_validation.py
	- cross-validates on a range of topic sizes, maximum depth values, and split (random feature subset) sizes
	- writes cross-validation results to three separate files
		- c_v_depth.txt
		- c_v_K.txt
		- c_v_split.txt
	- WARNING: will run for a long time!
	- can be modified by going into ./cross_validation.py and changing 
		(line 114) k_range
		(line 115) d_range	for different values of each
		(line 116) s_range
 3. Graphing cross-validation results (optional)
	- place output files from ./cross_validation.py into a directory with the file graph_cv.m
	- we have done this already in the ./cv_files/k5, ./cv_files/k8, ./cv_files/k10, ./cv_files/k15, and ./cv_files/k20 directories
	- change into one of those directories (i.e. cv_files/k15)
		- running graph_cv(true) in Matlab produces graphs with error bars
		- running graph_cv(false) produces graphs without error bars
	- we have added a ./graph_cv.sh script in the ./cv_files/ directory that produces all graphs in each of the children subdirectories (k5, k8, k10, k15, k20) for you
	- graph_cv_K.m matlab file produces another cross-validation graph

ADDITIONAL GRAPHS (hard coded, but there for reference): in the command line
   For numbers of trees:
	1. for errors vs number of trees: python ./numTreesVsError_K15.txt
	2. to produce graph of computed error: graph_errors_vs_trees.m
		- produces ./errorsvstrees.fig
   PCA visualization (after running LDA):
	1. dimensionality reduction: python ./pca_dimred.py
	2. run pca_visualization.m in MATLAB to graph the data