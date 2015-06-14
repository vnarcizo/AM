function [U, S] = pca(X)
%PCA Executa a analise de componentes principais na base de dados X
%   [U, S] = pca(X) computa os autovetores da matriz de covariancia de X
%   Retorna os autovetores U e os autovalores (diagonal) em S.
%

% Dimensao de X
m = size(X, 1);

% Valores de retorno
%U = zeros(n);
%S = zeros(n);

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Voce precisara encontrar a matriz de covariancia e,
%             posteriormente, usar a fucao svd para calcular os autovetores
%             e autovalores da matriz encontrada.
%
% Obs: ao computar a matriz de covariancia, certifique-se de dividi-la por
% m (quantidade de amostras).
%
sigma = (1/m).*X'*X;
[U, S] = svd(sigma);







% =========================================================================

end
