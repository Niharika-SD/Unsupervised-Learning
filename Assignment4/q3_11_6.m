close all
clear all
clc

fprintf('generating the training and testing sets.... \n')

test_labels = vertcat(ones(5,1),2*ones(5,1),3*ones(5,1)) ; 

[image_matrix,m,n] = read_images(1, 1);

X_train = image_matrix.train;
X_test = image_matrix.test;

X = X_train;

no_out= 5;
fprintf('\n Reading images for individual %d ,Please wait. \n',4)
fprintf('.')
for j =1:no_out
   fprintf('.')
   img =loadimage(4,j);
   img = imresize(img,[m,n]);
   X_train =horzcat(X_train,img(:));
end
train_labels = vertcat(ones(5,1),2*ones(5,1),3*ones(5,1),4*ones(no_out,1)) ; 

fprintf('\n')
tau = (numel(X_train))/norm(X_train,1);
[L,E]=rpca_admm(X_train,tau,'outliers');
A_train = L+E;
[mu,U_hat,Y_hat] = my_pca(L,10);
    
figure;hold on
scatter(Y_hat(1,1:5),Y_hat(2,1:5),'MarkerEdgeColor',[1 0 0])
scatter(Y_hat(1,6:10),Y_hat(2,6:10),'MarkerEdgeColor',[0 1 0])
scatter(Y_hat(1,11:15),Y_hat(2,11:15),'MarkerEdgeColor',[0 0 1]) 
legend('class 1','class 2','class 3')
title(strcat('Projected training images in 2D for percentage outliers',num2str(no_out/(no_out+10))))
    
figure;hold on
scatter3(Y_hat(1,1:5),Y_hat(2,1:5),Y_hat(3,1:5),'*','MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75])
scatter3(Y_hat(1,6:10),Y_hat(2,6:10),Y_hat(3,6:10),'o','MarkerEdgeColor','k',...
        'MarkerFaceColor',[.75 0 .75])
scatter3(Y_hat(1,11:15),Y_hat(2,11:15),Y_hat(3,11:15),'x','MarkerEdgeColor','k',...
        'MarkerFaceColor',[.75 .75 0]) 
legend('class 1','class 2','class 3')
title(strcat('Projected training images in 3D for percentage outliers',num2str(no_out/(no_out+10))))
view(40,35)
    
acc = zeros(1,10);
for d = 1:10
  Y_test = U_hat(:,1:d)' *(X_test - mu * ones(1,size(X_test,2)));
  Y_train = U_hat(:,1:d)' *(X_train - mu * ones(1,size(X_train,2)));
    
    
  for k = 1:size(X_test,2)

      test_img_vec = Y_test(:,k)*ones(1,size(Y_train,2));
      MSE_img = sum((mat2gray(test_img_vec)-mat2gray(Y_train)).^2,1);
      if(ceil(find(MSE_img == min(MSE_img))/5)==test_labels(k,1))
         acc(1,d) = acc(1,d)+ 1;
      end
  end
fprintf('\n Accuracy of classification with %d components is %f for %f outliers \n',d,(acc(d)/15),((no_out)/(no_out+10)))
end
    
figure;plot(1:10,acc/15)
title(strcat('Plot of accuracy vs no of components for percentage outliers  ',num2str(no_out/(no_out+10))))
xlabel('no of components')
ylabel('Accuracy')    
   

Lcolnorm=sqrt(sum(L.^2,1));
Ecolnorm=sqrt(sum(E.^2,1));
S_norm  = Lcolnorm./Ecolnorm ;
count =1;

for thresh= 300:2:800
    a = (S_norm(1,size(X,2)+1:end)<thresh);
    b = (S_norm(1,1:size(X,2))<thresh);  
    TPR(count) = sum(a);
    FPR(count) =sum(b);
    count = count+1;
end

figure; subplot(1,3,1)
plot(300:2:800,TPR/5)
title('true postives (outliers)')
 
subplot(1,3,2)
plot(300:2:800,FPR/size(X,2))
title('false postives (outliers)')

subplot(1,3,3)
plot(TPR/5,FPR/size(X,2))
title('ROC curve')
