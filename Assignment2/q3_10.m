clear all
close all
clc

fprintf('generating the training matrix.... \n')
load('image_matrix.mat')

X = image_matrix;
[m,n] = size(image_matrix); 

fprintf('\n RPCA-ADMM for gross_errors \n')
method = 'gross_errors';
tau = (m*n)/norm(X,1);

[L1,E1]=rpca_admm(X,tau,method);

figure; subplot(1,3,1)
imshow(reshape(X(:,1),[96,84]),[])
title('Input example, tau = 0.2')

subplot(1,3,2)
imshow(reshape(L1(:,1),[96,84]),[])
title('Low rank: tau = 0.2')

subplot(1,3,3)
imshow(reshape(E1(:,1),[96,84]),[])
title('sparse: tau = 0.2')

W_1 = rand(m,n);
W = ones(m,n);
%percentage corruption
p = 0.10;
d = find(W_1< p/2);
W(d) = 0;
X(d) =0;

fprintf('\n RPCA-ADMM for outliers \n')
method = 'outliers';
tau = 10e-05;
[L,E]=rpca_admm(X,tau,method);

figure; subplot(1,3,1)
imshow(reshape(X(:,1),[96,84]),[])
title('Input example with corrupted entries, tau = 10e-05')

subplot(1,3,2)
imshow(reshape(L(:,1),[96,84]),[])
title('Low rank, tau = 10e-05')

subplot(1,3,3)
imshow(reshape(E(:,1),[96,84]),[])
title('outliers, tau = 10e-05')