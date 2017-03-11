close all
clear all


for j =1:3

    %loading images 
    image_matrix = [];
    fprintf('Reading images for individual %d ,Please wait. \n',j)
    for k =1:10
        img =loadimage(j,k);
        image_matrix =horzcat(image_matrix,img(:));
    end
    
    %PCA
    fprintf(' Now performing Principal component Analysis,please wait \n ');
    [m,n] =size(img);
   
    
    [mu,U,Y] = my_pca(image_matrix,2);
    fprintf('\n Press any key to continue. Figures will be closed after key press. See display for title \n')
    pause;
    %PCA outputs
    
    figure(), imshow(reshape(mu,[m,n]),[]);
    fprintf('Figure 1: mean face image \n');
      
    figure, imshow(reshape(U(:,1),[m,n]),[]);
    fprintf('Figure 2 :first eigen vector \n');
    
    figure, imshow(reshape(U(:,2),[m,n]),[]);
    fprintf('Figure 3: second eigen vector \n');
    
    fprintf('\n Press any key to continue.')
    pause;
    close all
    
    fprintf('\n illumination scaled eigenvector images being generated \n');
    
    Y1_sig = std(U(:,1)'*image_matrix);
    Y2_sig = std(U(:,2)'*image_matrix);
    Y1_vec = -Y1_sig:0.2*Y1_sig:Y1_sig ;
    Y2_vec = -Y2_sig:0.1*Y2_sig:Y2_sig ;
    
    
    fprintf('\n mu+y1*U1 images \n');
    
    for i =1:length(Y1_vec)

        figure,imshow(reshape(mu + Y1_vec(1,i)*U(:,1),[m,n]),[]);
      
    end
    
    fprintf('\n Press any key to continue.')
    pause;
    
    close all

    fprintf('\n mu+y2*U2 images \n');
    
    for i =1:length(Y2_vec)

        figure,imshow(reshape(mu + Y2_vec(1,i)*U(:,2),[m,n]),[]);
    end
       
    fprintf('\n Press any key to continue. Figures will be closed after key press. \n')

    pause;
    close all
    
    
 
end
