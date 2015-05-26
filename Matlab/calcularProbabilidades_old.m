function [pAtrVitoria, pAtrDerrota] = calcularProbabilidades(X, Y)
%CALCULARPROBABILIDADES Computa a probabilidade de ocorrencia de cada 
%atributo por rotulo possivel. A funcao retorna dois vetores de tamanho n
%(qtde de atributos), um para cada classe.
%   [pAtrVitoria, pAtrDerrota] = CALCULARPROBABILIDADES(X, Y) calcula a 
%   probabilidade de ocorrencia de cada atributo em cada classe. 
%   Cada vetor de saida tem dimensao (n x 1), sendo n a quantidade de 
%   atributos por amostra.

% inicializa os vetores de probabilidades
pAtrVitoria = zeros(size(X,2),1);
pAtrDerrota = zeros(size(X,2),1);

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Complete o codigo para encontrar a probabilidade de
%               ocorrencia de um atributo para uma determinada classe.
%               Ex.: para a classe 1 (vitoria), devera ser computada um
%               vetor pAtrVitoria (n x 1) contendo n valores:
%               P(Atributo1=1|Classe=1), ..., P(Atributo5=1|Classe=1), e o
%               mesmo para a classe 0 (derrota):
%               P(Atributo1=1|Classe=0), ..., P(Atributo5=1|Classe=0).
%

auxiliar = [X Y];

c1 = auxiliar(:,6) == 1;
c2 = auxiliar(:,6) == 0;

for i = 1:size(X,2)
   
    pAtrVitoria(i) = sum(auxiliar(c1,i))/sum(Y==1);
    pAtrDerrota(i) = sum(auxiliar(c2,i))/sum(Y==0);
    
end



% =========================================================================

end