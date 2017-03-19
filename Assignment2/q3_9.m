clear all
close all
clc

fprintf('generating the training matrix.... \n')
load('image_matrix.mat')

fprintf('\n Corrupting the images.... \n')

X = image_matrix;
[m,n] = size(image_matrix); 
W_1 = rand(m,n);
W = ones(m,n);
%percentage corruption
p = 0.10;
d = find(W_1< p/2);
W(d) = 0;
X(d) =0;

fprintf('\n LRMC  \n')
tau = 5* sqrt(m*n);

A = lrmc(X,tau,W);

figure; subplot(2,1,1)
imshow(reshape(X(:,1),[96,84]),[])
title('Input example: tau = 2*10e03')

subplot(2,1,2)
imshow(reshape(A(:,1),[96,84]),[])
title('output: tau = 2*10e03')
