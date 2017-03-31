function [X_hat,W] = add_corruption(X,p,cs)
%corrupts the entries of X by a percentage specified by p and returns the
%matrix with missing entries X_hat along with the locations of the
%corruptions W if cs==0, if cs ==1, corrupted entries are generated
%uniformly from [0,255]

W_1 = rand(size(X));
W = ones(size(X));
d = find(W_1< p/2);

if cs ==0
    W(d) = 0;
    X(d) =0;
else 
    X(d) = randi([0 255],1,size(d,1));
end
X_hat = X;
end