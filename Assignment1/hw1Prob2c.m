
close all
clear all
clc
acc =zeros(1,10);

train_image_matrix = [];
test_image_matrix = [];

fprintf('generating the training and testing sets.... \n')

labels = vertcat(ones(5,1),2*ones(5,1),3*ones(5,1)) ; 

for j =1:3
    %loading images
    fprintf('\n Reading images for individual %d ,Please wait. \n',j)
    fprintf('.')
    for k =1:5
        fprintf('.')
        img =loadimage(j,k);
        train_image_matrix =horzcat(train_image_matrix,img(:));
    end

    for k =6:10
        fprintf('.')
        img =loadimage(j,k);
        test_image_matrix =horzcat(test_image_matrix,img(:));
    end
end

[m,n] =size(img);
[mu,U,Y] = my_pca(train_image_matrix,10);    
for d = 1:10    
    
    %Projecting the testing set
    fprintf('\n Projecting the testing set \n')

    Y_test = U(:,1:d)' *(test_image_matrix - mu * ones(1,size(test_image_matrix,2)));
    Proj_faces_test = U(:,1:d)*Y_test+mu*ones(1,size(test_image_matrix,2));

    Y_train = U(:,1:d)' *(train_image_matrix - mu * ones(1,size(train_image_matrix,2)));
    Proj_faces_train = U(:,1:d)*Y_train+mu*ones(1,size(train_image_matrix,2));
    
    %PCA outputs
    
    if (d ==10)
        fprintf('Plotting outputs, Press a key to continue \n')
        pause; 
    
        figure; imshow(reshape(mu,[m,n]),[]);
        fprintf('Figure1 :mean face \n')
            
        S = svd(train_image_matrix,0);
        figure; plot(S);
        ylabel('singular values')
        xlabel('no of components')
        title('plot of sigular value components');

        for D =1:d 
        
            figure; imshow(reshape(U(:,D),[m,n]),[]);
            fprintf(strcat('\n Eigen vector',num2str(D)))

        end
        for N =1:size(Proj_faces_test,2)
            figure; imshow(reshape(Proj_faces_test(:,N),[m,n]),[]);
            fprintf(strcat('\n Projected face, test image no: ',num2str(N)))
        end

    end
       %Classification
    
    for k = 1:size(test_image_matrix,2)

        test_img_vec = Proj_faces_test(:,k)*ones(1,size(test_image_matrix,2));
        MSE_img = sum((mat2gray(test_img_vec)-mat2gray(Proj_faces_train)).^2,1);
        if(ceil(find(MSE_img == min(MSE_img))/5)==labels(k,1))
            acc(1,d) = acc(1,d)+ 1;
        end
    end

    fprintf('\n Accuracy of classification with %d components is %f \n',d,acc(d)/15)
end

figure;plot(acc/15)
title('Plot of accuracy vs no of components')
xlabel('no of components')
ylabel('accuracy')