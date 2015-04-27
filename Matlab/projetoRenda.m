%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Exercicio 4 - Naive Bayes
%
%  Instrucoes
%  ----------
%
%  Este arquivo contem o codigo que auxiliara no desenvolvimento do
%  exercicio. Voce precisara completar as seguintes funcoes:
%
%     calculaProbabilidade.m
%     classificacao.m
%
%  Voce nao podera criar nenhuma outra funcao. Apenas altere as rotinas
%  fornecidas.
%

%% Inicializacao
clear ; close all; clc

%% Carrega os dados
fprintf('Carregando os dados...\n\n');
load('ex04Dados.mat');

%% ================= Parte 1: Calcular as probabilidades ====================
%  Nesta etapa, voce precisara implementar a funcao calcularProbabilidades.
%  Esta funcao retornara os vetores com as probabilidades de cada atributo para as classes.
%  Complete o codigo em calcularProbabilidades.m
%

%  Probabilidade das Classes
pVitoria = sum(Y==1)/size(Y,1); 
pDerrota = sum(Y==0)/size(Y,1);

%  Probabilidade dos Atributos
[pAtrVitoria, pAtrDerrota] = calcularProbabilidades(X,Y);

fprintf('\n\nA probabilidade esperada para P(PrimeiroAbate=1|Classe=1) = %.2f\n', 52.96);
fprintf('Essa mesma probabilidade calculada no seu codigo foi = %.2f\n', pAtrVitoria(1:1)*100);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;

%% ================= Parte 2: Classificacao da propria base  =================
%  Nesta etapa, voce precisara utilizar as probabilidades encontradas anteriormente
%  para calcular a probabilidade das amostras pertencerem às classes positivas e negativas.
%  Complete o codigo em classificacao.m

resultados = zeros(size(X,1),1);

for i = 1:size(X, 1)
	resultados(i,1) = classificacao(X(i,:)',pVitoria,pDerrota,pAtrVitoria,pAtrDerrota);
end

fprintf('\n\nAcuracia esperada para essa base = %.2f\n', 76.60);
fprintf('Acuracia obtida pelo seu classificador foi = %.2f\n', sum(resultados==Y)/size(Y,1)*100);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;

%% ================= Parte 3: Predizendo a classe de novos dados ==============

fprintf('\n\nPredizendo a classe de novos dados...\n\n')

x1_novo = input('Insira 1 para classificar novos dados ou -1 para SAIR: ');

while (x1_novo ~= -1)
    
	fprintf('\nResponda com 1 (Sim) ou 0 (Nao) para as seguintes perguntas:\n');
	
	x1_novo = input('O time de Rodonildo fez o primeiro abate do jogo? ');
    x2_novo = input('O time de Rodonildo derrubou a primeira torre do jogo? ');
    x3_novo = input('O time de Rodonildo derrubou o primeiro inibidor do jogo? ');
    x4_novo = input('O time de Rodonildo derrotou o primeiro Dragao do jogo? ');
    x5_novo = input('O time de Rodonildo derrotou o primeiro Baron do jogo? ');

	[classe, probVitoria, probDerrota] = classificacao([x1_novo x2_novo x3_novo x4_novo x5_novo]',pVitoria,pDerrota,pAtrVitoria,pAtrDerrota);
    
    if (classe)
        fprintf('\n>>> Predicao = Vitoria!');        
    else
        fprintf('\n>>> Predicao = Derrota!');
    end
    
    fprintf('\n>>>>>> Prob. vitoria = %6.6f!',probVitoria);
    fprintf('\n>>>>>> Prob. derrota = %6.6f!\n\n',probDerrota);
    x1_novo = input('Insira 1 para classificar novos dados ou -1 para SAIR: ');
end

%% Finalizacao
clear; close all;