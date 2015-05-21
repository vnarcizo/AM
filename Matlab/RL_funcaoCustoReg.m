function [J, grad] = RL_funcaoCustoReg(theta, X, y, lambda, utilizarRegularizacao)
%FUNCAOCUSTOREG Calcula o custo da regressao logistica com regularizacao
%   J = FUNCAOCUSTOREG(theta, X, y, lambda) calcula o custo de usar theta 
%   como parametros da regressao logistica para ajustar os dados de X e y 

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule o custo de uma escolha particular de theta.
%             Voce precisa armazenar o valor do custo em J.
%             Calcule as derivadas parciais e encontre o valor do gradiente
%             para o custo com relacao ao parametro theta
%
% Obs: grad deve ter a mesma dimensao de theta
%
%Calcula o tamanho do vetor de atributos
attSize = size(theta); 

%Calcula a hipotese
hip = sigmoid(X * theta);

%Calcula o custo se a classe for positiva
posClasse = y .* log(hip);

%Calcula o custo se a classe for negativa
negClasse = (1 - y) .* log(1 - hip);

%Calcula o custo da regularizacao
reg = lambda / (2 * m) * sum(theta(2:attSize).^2);

%Agrega o calculo dos custos parciais e da regularizacao
J = (-1 / m) * sum(posClasse + negClasse) + reg;

%Calcula o vetor de regularizacoes
regVector = (lambda / m) * theta';

%A regularizacao nao se aplica ao primeiro valor theta
regVector(1) = 0;

%Calcula o gradiente para o theta atual
grad = bsxfun(@plus, (1 / m) * sum(bsxfun(@times, hip - y, X)), regVector);






% =============================================================

end
