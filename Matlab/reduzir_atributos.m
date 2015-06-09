function [ Z ] = reduzir_atributos( X, K )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[U, S] = pca(X);
Z = projetarDados(X, U, K);

end

