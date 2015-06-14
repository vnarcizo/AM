function X_rec = reconstruirDados(Z, U, K)
%RECONSTRUIRDADOS Calcula uma aproximacao do dado original usando o dado 
%projetado 
%   X_rec = RECONSTRUIRDADOS(Z, U, K) computa uma aproximacao do dado
%   original que foi reduzido para K dimensoes. A funcao retorna a
%   reconstrucao aproximada em X_rec
%

% Incializa variavel de retorno.
%X_rec = zeros(size(Z, 1), size(U, 1));

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes:   Computa a aproximacao do dado pela projecao reversa no 
%               espaco original usando os K primeiros autovetores em U.
%               
X_rec = Z*U(:,1:K)';







% =============================================================

end
