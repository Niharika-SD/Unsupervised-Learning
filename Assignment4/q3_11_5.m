close all
clear all
clc
image_matrix = [];

fprintf('generating the training and testing sets.... \n')

%labels = vertcat(ones(5,1),2*ones(5,1),3*ones(5,1)) ; 

for j =1:3
    %loading images
    fprintf('\n Reading images for individual %d ,Please wait. \n',j)
    fprintf('.')
    for k =1:10
        fprintf('.')
        img =loadimage(j,k);
        img = imresize(img,0.5);
        [m,n] =size(img);
        image_matrix =horzcat(image_matrix,img(:));
    end
end

for j =4:4
    %loading images
    fprintf('\n Reading images for individual %d ,Please wait. \n',j)
    fprintf('.')
    for k =1
        fprintf('.')
        img =loadimage(j,k);
        img = imresize(img,[m,n]);
        image_matrix =horzcat(image_matrix,img(:));
    end
end

fprintf('\n')
X = image_matrix;
tau =(numel(X))/norm(X,1);
error = zeros(1,5);

for i = 1:1
    
 [X_hat,W] = add_corruption(X,0.1*(i-1),1);
 [L,E]=rpca_admm(X,tau,'outliers');
 
 A = L+E;
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
 
 error(i) = norm((X - A),'fro');
end

figure; 
title('Plot of error vs percentage corruption')
plot(0:0.1:0.4,error)