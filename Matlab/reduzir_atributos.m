function [ Z ] = reduzir_atributos( X, K )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[U, S] = pca(X);
tot = sum(sum(S));
cv = 1;
if K == -1
    K = size(S,1)+1;
    while cv >= 0.95
        K = K - 1;
        cv = sum(sum(S(1:K,1:K)))/tot;
    end
end
Z = projetarDados(X, U, K);

end

