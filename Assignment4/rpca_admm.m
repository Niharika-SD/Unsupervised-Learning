function [L,E]=rpca_admm(X,tau,method)
%implements robust PCA solution by alternative directions of maximisation
%algorithm
thresh = 0.001;
max_iter =1000;

if (strcmp(method,'gross_errors'))
    E = zeros(size(X));
    L= E;
    lambda_mat = E;
    lambda =0.001;
    tau_inv = 1/tau;
    lam_by_tau = lambda/tau;
    
   for i = 1:max_iter
    
    E_prev = E;
    L_prev = L;
    %updates
    fprintf('Iteration number: %d || error  = %f \n',i, norm(X -L- E,'fro'));
    [U,S,V] =svd(X-E+tau_inv.*lambda_mat);
    S =sign(S).*(max(abs(S)-tau_inv,0));
    L = U*S*V' ;
    temp =(X-L+tau_inv*lambda_mat);
    E = sign(temp).*(max(abs(temp)-lam_by_tau,0));
    lambda_mat = lambda_mat + tau*(X-L-E);
    
    %check for convergence
    %if(norm((E_prev-E),'fro')<=thresh&& norm((L_prev-L),'fro')<=thresh)
    if(norm(X -L- E,'fro')<=thresh) 
        break;
    end
   end
   
elseif((strcmp(method,'outliers')))
        E = zeros(size(X));
        L= E;
        lambda_mat = E;
        lambda =1;
        tau_inv = 1/tau;
        lam_by_tau = lambda/tau;
        for i = 1: max_iter
            fprintf('Iteration number: %d || error  = %f \n',i, norm(X -L- E,'fro'));
            [U,S,V] =svd(X-E+tau_inv.*lambda_mat);
            S =sign(S).*(max(abs(S)-tau_inv,0));
            L_prev = L;
            L = U*S*V' ;
            Z = X -L+lambda_mat*tau_inv;
            z = diag(diag(sqrt(Z'*Z)));
            S_dash = sign(z).*(max(abs(z)-lam_by_tau,0));
            E_prev = E;
            E = (Z*S_dash)/z;
            lambda_mat = lambda_mat + tau*(X-L-E);
            %if(norm((E_prev-E),'fro')<=thresh&& norm((L_prev-L),'fro')<=thresh)
            if(norm(X -L- E,'fro')<=thresh) 
                break;
            end
    
        end
end
end