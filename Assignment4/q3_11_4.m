close all
clear all
clc
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
        img = imresize(img,0.5);
        [m,n] =size(img);
        train_image_matrix =horzcat(train_image_matrix,img(:));
    end
    
    for k =6:10
        fprintf('.')
        img =loadimage(j,k);
        img = imresize(img,0.5);
        [m,n] =size(img);
        test_image_matrix =horzcat(test_image_matrix,img(:));
    end
end

X_train = train_image_matrix;
X_test = test_image_matrix;

tau = (numel(X))/norm(X_train,1);

for i = 1:1
    [X_hat,W] = add_corruption(X_train,0.1*(i-1),1);
    [L,E]=rpca_admm(X,tau,'gross_errors');
    A_train = L+E;
    [mu,U_hat,Y_hat] = my_pca(A_train,10);
    
    figure;hold on
    scatter(Y_hat(1,1:5),Y_hat(2,1:5),'MarkerEdgeColor',[1 0 0])
    scatter(Y_hat(1,6:10),Y_hat(2,6:10),'MarkerEdgeColor',[0 1 0])
    scatter(Y_hat(1,11:15),Y_hat(2,11:15),'MarkerEdgeColor',[0 0 1]) 
    legend('class 1','class 2','class 3')
    title('Projected training images')
    
    figure;hold on
    scatter3(Y_hat(1,1:5),Y_hat(2,1:5),Y_hat(3,1:5),'*')
    scatter3(Y_hat(1,6:10),Y_hat(2,6:10),Y_hat(3,6:10),'o')
    scatter3(Y_hat(1,11:15),Y_hat(2,11:15),Y_hat(3,11:15),'x') 
    legend('class 1','class 2','class 3')
    title('Projected training images')
    view(40,35)
    
    acc = zeros(1,10);
    for d = 1:10
    Y_test = U_hat(:,1:d)' *(test_image_matrix - mu * ones(1,size(test_image_matrix,2)));
    Y_train = U_hat(:,1:d)' *(train_image_matrix - mu * ones(1,size(train_image_matrix,2)));
    
    
    for k = 1:size(test_image_matrix,2)

        test_img_vec = Y_test(:,k)*ones(1,size(Y_test,2));
        MSE_img = sum((mat2gray(test_img_vec)-mat2gray(Y_train)).^2,1);
        if(ceil(find(MSE_img == min(MSE_img))/5)==labels(k,1))
            acc(1,d) = acc(1,d)+ 1;
        end
    end
    fprintf('\n Accuracy of classification with %d components is %f for %f corruption \n',d,acc(d)/15,(i-1)*0.1)
    end
    
    figure;plot(1:10,acc)
    title('Plot of accuracy vs no of components')
    xlabel('no of components')
    ylabel('Accuracy')
    
end
