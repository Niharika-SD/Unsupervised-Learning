Instructions:

1. Unzip the folder
2. Run the script q_3_11_a.m for part a, i.e a = 1 for part 1
3. Pre- computed figures are stored in the results folders(separate folders titled qa_results/ where a is part no, eg. q1_results for part 1 results)

Results Organisation and Discussions:

Part 1: 
Separate subfolders for runs with images of each individual(1 to 3)
In each subfolder corresponding to an Individual, the corresponding plot of Error vs percentage missing entries is present along with subfolder titled by the percentage corruption (0-0.4)
In each of these subfolders (0-0.4), figures1 -10 are of the original vs reconstrcuted image obtained from the algorithm, and figure11 depicts the mean and first 3 eigen faces

eg Individual 1/0.1/figure1.fig is the reconstructed and original image of the first individual with 0 percent missing entries

Discussion: As evident from the error plot, as the percentage of missing entries increase, the error between the original and reconstructed images increases. Consequently the performance of lrmc degrades with increasing missing entries.A comparison with the quality of the mean face and the eigen faces with the ones obtained from PCA without any missing entries clearly indicates their locations which become more evident as their percentage increases, however the structural information is preserved so long as the percentage of missing entries is low.


Part 2:
The figures 1,4,7,10,13 correspond to the accuracy as a function of the number of components retained in the low rank representation for different levels of corruption, figures 2,5,8,11,14 are the projected images in 3D ad 3,6,8,12,15 are the projected images in 2D for different levels of corruption.

Discussion: From the projections, there seem to be some inherent clusters captured, however, they aren't class separated, and are distinctive based on the lighting condition in the original image indicative of the top principal components roughly capturing illumination variance in the facial images.The accuracy from each condition is displayed as the code is run.


Part 3: 
Separate subfolders for runs with images of each individual(1 to 3)
In each subfolder corresponding to an Individual, the corresponding plot of Error vs percentage corrupted entries is present along with subfolder titled by the percentage corruption (0-0.4)
In each of these subfolders (0-0.4), figures1 -10 are of the original vs reconstrcuted image obtained from the algorithm, and figure11 depicts the mean and first 3 eigen faces

eg Individual 1/0.1/figure1.fig is the reconstructed and original image of the first individual with 0 percent corrupted entries

Discussion: As evident from the error plot, as the percentage of corrupted entries increase, the error between the original and reconstructed images increases. Consequently the performance of PCP degrades with increasing percentage of corrupted entries, but it still fruitfully captures a meaningful low rank approximation with a loss of information around a few facial features, this can be viewed by plotting the low rank and sparse images side by side, some information near contours (eyes, nose) is lost. In part 4, some of these images have been included in the results for reference.A comparison with the quality of the mean face and the eigen faces with the ones obtained from PCA without any corrupted entries doesn't show a significant difference because the low rank representation seems to faithfully capture most of the information contained in the faces dataset, however, performance could degrade as the percentage corrupted entries gets very high.


Part 4:
The figures 1,4,7,10,13 correspond to the accuracy as a function of the number of components retained in the low rank representation for different levels of corruption, figures 2,5,8,11,14 are the projected images in 3D and 3,6,8,12,15 are the projected images in 2D for different levels of corruption.

Discussion: From the projections, there seem to be some inherent clusters captured, however, they aren't class separated, and are distinctive based on the lighting condition in the original image indicative of the top principal components roughly capturing illumination variance in the facial images.The accuracy from each condition is displayed as the code is run.


Part 5:
Figures 2-36 are the reconstructed images from the low rank and E matrices for each image in the database(individuals 1-3, 10 lighting conditions + 5 outliers). Figure 37 shows the mean and eigen faces and image 1 captures the True Positive, false Positive rates as the outlier detection threshold is varied and the ROC curve obtained from the runs.

Discussion:
A quick comparison of the mean and eigen face images with those from PCA without outliers clearly indicates the presence of outliers in the set, which appear as shadows in the background. While ideally, the outliers need to be completely captured in the E matrix, due to the limitations in the number of face images available vs percentage of outliers, the entire separation isn't faithfully captured as can be seen from the plots of the reconstructed L, and E matrices(figures 2-36). In order to determine the number of outliers, a thresholding is done on the relative ratios of the l2 norms of the L and E matrix columns and the perfomance in terms of the true positive , false positive rate as a function of the threshold is determined along with the ROC curve.  


Part 6:
Figure 2 captures the True Positive, false Positive rates as the outlier detection threshold is varied and the ROC curve obtained from the runs. figure 3 is the projected images in 3D and figure 4 is the projected images in 2D. Figure 1 gives the classification accuracy as a function of the number of components used 

Discussion:
From the projections, there seem to be some inherent clusters captured, however, they aren't class separated, and are distinctive based on the lighting condition in the original image indicative of the top principal components roughly capturing illumination variance in the facial images.The accuracy from each condition is displayed as the code is run. In order to determine the number of outliers, a thresholding is done on the relative ratios of the l2 norms of the L and E matrix columns and the perfomance in terms of the true positive , false positive rate as a function of the threshold is determined along with the ROC curve.
 

Functions used:

function [X_hat,W] = add_corruption(X,p,cs)
corrupts the entries of X by a percentage specified by p and returns the matrix with missing entries X_hat along with the locations of the corruptions W if cs==0, if cs ==1, corrupted entries are generated
uniformly from [0,255]

function [mu,U,Y] = my_pca(X,d)
finds the d principal components of a set of points from the Singular Value Decomposition of the data matrix X 

function [image_matrix,m,n] = read_images(individual, type)
Given the individual no, creates a matrix of aggregated individuals and the size of the images, splits into testing and training sets depending on the value of type(==1, test and train)

function [L,E]=rpca_admm(X,tau,method)
implements robust PCA solution by alternating direction method of multipliers algorithm where method can be 'outliers' or 'gross_errors' with tau as the parameter

function A=lrmc(X,tau,W)
Finds the low-rank approximation of a matrix X with incomplete entries as specified in W using the low-rank matrix completion algorithm based on the augmented Lagrangian method.




