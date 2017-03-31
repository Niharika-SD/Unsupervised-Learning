close all
clear all
clc; 

%loading images
fprintf('generating the training and testing sets.... \n')
[image_matrix1,m,n] = read_images(1, 0);
[image_matrix2,~,~] = read_images(2, 0);
[image_matrix3,~,~] = read_images(3, 0);

image_matrix = horzcat(image_matrix1,image_matrix2,image_matrix3);
fprintf('\n')
error = zeros(1,5);

no_out = 5;
X = image_matrix;
fprintf('\n Reading images for outlier set ,Please wait. \n')
fprintf('.')
 for j =1:no_out
     fprintf('.')
     img =loadimage(4,j);
     img = imresize(img,[m,n]);
     X =horzcat(X,img(:));
 end
fprintf('\n')  

tau =(numel(X))*0.5/norm(X,1);

[L,E]=rpca_admm(X,tau,'outliers');
 
A = L+E;
[mean_face,U,~] = my_pca(L,3);
 
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
 

for j = 1:size(image_matrix,2)+no_out
     figure ;subplot(1,2,1)
     imshow(reshape(L(:,j),[m,n]),[])
     title('Low Rank Image')
     subplot(1,2,2)
     imshow(reshape(E(:,j),[m,n]),[])
     title('Outlier Image')
end
fprintf('Determining the percentage outliers correctly detected with varying threshold \n')

Lcolnorm=sqrt(sum(L.^2,1));
Ecolnorm=sqrt(sum(E.^2,1));
S_norm  = Lcolnorm./Ecolnorm ;

count =1;
for thresh= 300:2:800
    a = (S_norm(1,size(image_matrix,2)+1:end)<thresh);
    b = (S_norm(1,1:size(image_matrix,2))<thresh);  
    TPR(count) = sum(a);
    FPR(count) =sum(b);
    count = count+1;
end

figure; subplot(1,3,1)
plot(300:2:800,TPR/5)
title('true postives (outliers)')
 
subplot(1,3,2)
plot(300:2:800,FPR/size(image_matrix,2))
title('false postives (outliers)')

subplot(1,3,3)
plot(TPR/5,FPR/size(image_matrix,2))
title('ROC curve')