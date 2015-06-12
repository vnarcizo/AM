%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Grupo 1:
%
%  Integrantes :
%
%  Leandro Luciani Tavares
%  Luiz Benedito Aidar Gavioli
%  Victor Narcizo de Oliveira Neto
%
%  Projeto - Predicao de renda anual
%

%% Inicializacao
clear ; close all; format shortG; format loose; clc

%Numero de particoes;
numeroParticoes = 10;

%% ================= Parte 1: Carregando a base de dados ====================
%  
fprintf('Carregamento dos dados iniciados...\n\n');

dadosOriginais = readtable('adult_data');
dadosOriginaisTeste = readtable('adult_test');

%% ================= Parte 2: Efetuando o Pré-Processamento dos dados =======
% Para trabalhar com a base de dados dada, foi necessário realizar
% algumas adequações no modelo de dados, pois existiam inconsistencias
% tanto na sua formatação quanto atributos faltantes
%
% Foi realizado 2 pré-processamentos, um para os métodos (Knn,Regressão
% Logistica, Redes Neurais Artificiais, SVM) e outro para o NaiveBayes pela
% suas caracteristicas
fprintf('Pré-processando iniciado...\n\n');

[dadosPreprocessados, rotulos, colunasAusentes, tamanhoCaracteristica, indiceNumericos] = preProcessar(dadosOriginais, dadosOriginaisTeste);

[dadosNaiveBayes] = preProcessarNaiveBayes(dadosPreprocessados, indiceNumericos);

%% ================= Parte 3: Normalização dos dados ====================
fprintf('Normalização por padronização iniciada...\n\n');
[dadosNormalizados] = normalizarPadronizacao(dadosPreprocessados);

rotulosNormalizados = rotulos;

fprintf('Removendo dados ausentes...\n\n') %Remove p linhas

%Obtendo as amostras com todos os atributos preenchidos

linhasAusentes = any(dadosPreprocessados(:, colunasAusentes), 2);
dadosNormalizados(linhasAusentes, :) = [];
rotulosNormalizados(linhasAusentes, :) = [];

dadosNormalizados(:, colunasAusentes) = [];

plotar = input('Deseja visualizar o espalhamento dos dados (dimensão reduzida)? (S/N)\n', 's');

if strcmpi(plotar, 'S')
    Z = reduzir_atributos(dadosNormalizados, 3);

    pos = find(rotulosNormalizados == 1);
    neg = find(rotulosNormalizados == 0);
    figure; hold on;
    namostras = 5000;
    scatter3(Z(pos(1:namostras), 1), Z(pos(1:namostras), 2), Z(pos(1:namostras), 3), 'b+');
    scatter3(Z(neg(1:namostras), 1), Z(neg(1:namostras), 2), Z(neg(1:namostras), 3), 'ro');
    legend('>=50k','<50k');

    %plot(Z(neg(1:10000), 1), Z(neg(1:10000), 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
    %plot(Z(pos(1:10000), 1), Z(pos(1:10000), 2), 'b+','LineWidth', 2, 'MarkerSize', 7);
    title('Plot 3D da base de dados');
    hold off;
    pause;
end
dadosNaiveBayes(linhasAusentes, :) = [];
dadosNaiveBayes(:, union(colunasAusentes, indiceNumericos)) = [];

validacao_cruzada(dadosNormalizados, dadosNaiveBayes, rotulosNormalizados);

%% Finalizacao
%clear; %Descomentar na versao final
%close all;