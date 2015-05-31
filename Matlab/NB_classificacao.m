function [classe, probMaior, probMenor] = NB_classificacao(atributos,pMaior,...
                                          pMenor,pAtrMaior,pAtrMenor)
%CLASSIFICACAO Classifica se a entrada x pertence a classe 0 ou 1 usando
%as probabilidades extraidas da base de treinamento.
%   [classe, probVitoria, probDerrota] = CLASSIFICACAO(x,pVitoria,pDerrota,
%                                                  pAtrVitoria,pAtrDerrota) 
%   estima a predicao de x atraves da maior probabilidade da amostra  
%   pertencer a classe 1 ou 0. Tambem retorna as probabilidades condicionais
%   de vitoria e derrota, respectivamente. 

% inicializa a classe e as probabilidades condicionais

	
% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Complete o codigo para estimar a classificacao da amostra
%               usando as probabilidades extraidas da base de treinamento.
%               Voce precisara encontrar as probabilidades Bayesianas 
%               probVitoria p(classe=1|x) e probDerrota p(classe=0|x) e
%               selecionar a maior.
%

%Calcula a probabilidade de vitoria baseado na probabilidade a priori
%vezes o produtorio das probabilidades de vitoria dos atributos vitoriosos 
%vezes o produtorio das probabilidade de vitoria do complemento dos atributos nao-vitoriosos

probMaior = pMaior .* prod(pAtrMaior(atributos == 1)) .* prod(1 - pAtrMaior(atributos == 0)); 


%Calcula a proababilidade de derrota baseado na probabilidade a priori
%vezes o produtoqrio das probabilidades de derrota dos atributos vitoriosos 
%vezes o produtorio das probabilidade de derrota do complemento dos atributos nao-vitoriosos
probMenor = pMenor .* prod(pAtrMenor(atributos == 1)) .* prod(1 - pAtrMenor(atributos == 0)); 

%Se a probabilida de vitoria é maior que a de derrota classe = 1 do
%contrario classe = 0
classe = probMaior >= probMenor;

% ========================================================================= 




end