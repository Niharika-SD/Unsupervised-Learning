function [image_matrix,m,n] = read_images(individual, type)
%Given the individual no, creates a matrix of aggregated individuals and
%the size of the images, splits into testing and training sets depending on
%the value of type(==1, test and train)

if type == 0
    fprintf('\n Reading images for individual %d ,Please wait. \n',individual)
    fprintf('.')
     image_matrix= [];
    for k =1:10
        fprintf('.')
        img =loadimage(individual,k);
        img = imresize(img,0.5);
        [m,n] =size(img);
        image_matrix =horzcat(image_matrix,img(:));
    end
elseif type == 1
    train_image_matrix =[];
    test_image_matrix =[];
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
    image_matrix.train = train_image_matrix;
    image_matrix.test = test_image_matrix;   
    
end
end