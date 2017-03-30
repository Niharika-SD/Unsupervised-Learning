function [mu,U,Y] = my_pca(X,d)
%%finds the d principal components of a set of points from the Singular
%%Value Decomposition of the data matrix X
   [D,N] =size(X);
   %mean computation and subtraction
   mu = sum(X,2)/N ;
   X =X -mu * ones(1,N);
   [U,S,V] =svd(X);
   U= U(:,1:d);
   Y =U' *X;
end