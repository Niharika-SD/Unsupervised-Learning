Instructions:

1. add the folder to path
2. run q3_9.m for lrmc
3. run q3_10.m for rpca_admm

Functions used:

function [L,E]=rpca_admm(X,tau,method)
implements robust PCA solution by alternative directions of maximisation algorithm for both gross errors as well as outliers
Outputs the low rank approximation L and the sparse matrix E for method  ='gross errors' and the low rank matrix L and outlier matrix E for
method = 'outliers'

function A=lrmc(X,tau,W)
Finds the low-rank approximation of a matrix X with incomplete entries as specified in W using the low-rank matrix completion algorithm based on the 
augmented Lagrangian method with optimal solution A.

Results:

Stored in the Results folder
1. Results_lrmc.jpg, Results_lrmc_2.jpg,Results_lrmc_3.jpg, are for the lrmc method on three different tau initialisations for 10 percent corrupted entries
2. Results_rpca_admm_GE_1.jpg, Results_rpca_admm_GE_2.jpg,Results_rpca_admm_GE_3.jpg, are for the rpca admm for gross errors method 
on three different tau initialisations of the faces dataset
3. Result_rpca_admm_out_1.jpg is the result from the rpca_admm for the outliers method, input is a the face database with randomly corrupted entries as in 
lrmc.

(For the outliers case, the implementation follows Robust PCA via Outlier Pursuit, Xu et al.)
