# Bioreactor-data-analysis
Target prediction and feature analysis

Prediction and univariate feature selection notebooks: Microbio_FinalStep_NeuralNets.ipynb, Microbio_FinalStep_SVM.ipynb, Microbio_FinalStep_RandomForests.ipynb

Clustering files: Microbio_Hierarchical_Clustering.ipynb, Microbio_Gaussian_Mixture.ipynb, Dirichlet_YT.R

Conditional univariate feature selection notebooks: conditinal_perm_Dirichlet.R, conditinal_perm_Gaussian.R, conditinal_perm_Hierarch.R

All other accompanying files (i.e. the csv and txt files) are required for the codes to run without error.

Note 1: The raw biochem data can be found in df_waterchem.csv (water chemistry data), df_all.csv (OTU abundances) and YT_bioreactor_data (OTU abundances). The values found in these files are standardized/normalized values.

Note 2: The pre-processing steps used to create the files df_waterchem.csv, netassoc.csv, YT_bioreactor_data, and df_all.csv are not given. They contain propriety information about the bioreactor system, which I am forbidden to disclose by contract.

Note 3: The user is assumed to possess basic proficiency in Python 3.6 (and Anaconda), Jupyter notebooks, Tensorflow, and RStudio 1.1. The packages used in these codes will NOT be kept up-to-date with respect to current versions - it is just impossible to do so given the rate of updates (ex. Tensorflow).
