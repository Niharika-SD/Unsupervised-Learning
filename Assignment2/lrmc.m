function A=lrmc(X,tau,W)
%Finds the low-rank approximation of a matrix X with incomplete entries as 
%specified in W using the low-rank matrix completion algorithm based on the 
%augmented Lagrangian method.
[m,n] = size(X);
Z = zeros(m,n);
maxIter =1000;
thresh = 0.0001;
l_param = 1.2*m*n/sum(sum(W)); %learning parameter for proximal gradient
A= Z;
for i = 1:maxIter
    fprintf('Iteration number: %d || error  = %f \n',i, norm(X-A ,'fro'));
    Z_dash = Z.*W;
    [U,S,V] =svd(Z_dash);
    S =sign(S).*(max(abs(S)-tau,0));
    Z_prev =Z;
    A = U*S*V';
    Z = Z + l_param*(W.*X -W.*A);
    if (norm((Z_prev-Z),'fro')<thresh)
        break;
    end
end
end