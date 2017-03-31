close all
clear all
clc

individual =3 ;

fprintf('generating the training and testing sets.... \n')

%loading images
fprintf('generating the training and testing sets.... \n')
[image_matrix,m,n] = read_images(individual, 0);


fprintf('\n')
X = image_matrix;
tau = (numel(X))/norm(X,1);
error = zeros(1,5);

for i = 1:5
 
 fprintf('Run for corrupted entries level %f : \n',(i-1)*0.1)
 [X_hat,W] = add_corruption(X,0.1*(i-1),1);
 [L,E]=rpca_admm(X,tau,'gross_errors');
 
 A = L;
 [mean_face,U,~] = my_pca(A,3);
 
 figure; subplot(1,4,1)
 imshow(reshape(mean_face,[m,n]),[])
 title('mean face')
 
 subplot(1,4,2)
 imshow(reshape(U(:,1),[m,n]),[])
 title('eigen face 1')
 
 subplot(1,4,3)
 imshow(reshape(U(:,2),[m,n]),[])
 title('eigen face 2')
 
 subplot(1,4,4)
 imshow(reshape(U(:,3),[m,n]),[])
 title('eigen face 3')
 

 for j = 1:10
     figure ;subplot(1,2,1)
     imshow(reshape(A(:,j),[m,n]),[])
     title('Reconstructed image')
     subplot(1,2,2)
     imshow(reshape(X(:,j),[m,n]),[])
     title('original image')
 end
 
 error(i) = norm((X - L),'fro');
end

figure; 
title('Plot of error vs percentage Missing Entries')
plot(0:0.1:0.4,error)