"""
pca_dimred.py

Performs PCA dimensionality reduction on feature vectors, and writes compressed versions of feature vectors
to ./k{5,8,10,15,20}_pca_passed.txt for each k
"""

import numpy as np
from sklearn.decomposition import PCA
import format_lda_to_python as format

for k in [5,8,10,15,20]:
	[passed, failed] = format.getTopicDistributions(k, True)
	pca = PCA(n_components=3)
	total = np.concatenate((passed,failed),axis=0)
	pca.fit(total)
	f = open('./k'+str(k)+'_pca_passed.txt','w')
	pass_dim_red = pca.fit_transform(passed, y=None)
	for item in pass_dim_red:
		f.write(','.join(map(str, item)) + '\n')
	f.close()
	f = open('./k'+str(k)+'_pca_failed.txt','w')
	fail_dim_red = pca.fit_transform(failed, y=None)
	for item in fail_dim_red:
		f.write(','.join(map(str, item)) + '\n')
	f.close()