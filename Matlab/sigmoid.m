function g = sigmoid(z)
%SIGMOID Calcula a funcao sigmoidal
%   G = SIGMOID(z) calcula a sigmoid de z.

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule a sigmoid de cada valor de z (z pode ser uma matriz,
%               vetor ou escalar).s

g =  1 ./ ( 1 + exp(-z));

% =======================================================================

end
