function [pAtrVitoria, pAtrDerrota] = NB_calcularProbabilidades(X, Y)
%CALCULARPROBABILIDADES Computa a probabilidade de ocorrencia de cada 
%atributo por rotulo possivel. A funcao retorna dois vetores de tamanho n
%(qtde de atributos), um para cada classe.
%   [pAtrVitoria, pAtrDerrota] = CALCULARPROBABILIDADES(X, Y) calcula a 
%   probabilidade de ocorrencia de cada atributo em cada classe. 
%   Cada vetor de saida tem dimensao (n x 1), sendo n a quantidade de 
%   atributos por amostra.

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Complete o codigo para encontrar a probabilidade de
%               ocorrencia de um atributo para uma determinada classe.
%               Ex.: para a classe 1 (vitoria), devera ser computada um
%               vetor pAtrVitoria (n x 1) contendo n valores:
%               P(Atributo1=1|Classe=1), ..., P(Atributo5=1|Classe=1), e o
%               mesmo para a classe 0 (derrota):
%               P(Atributo1=1|Classe=0), ..., P(Atributo5=1|Classe=0).
%

%Calcula a media (probabilidade) para cada atributo filtrado pela classe
%>=50k
pAtrVitoria = mean(X(Y == 1, :))';

%Calcula a media (probabilidade) para cada atributo filtrado pela classe
%<50k
pAtrDerrota = mean(X(Y == 0, :))';


% =========================================================================

end