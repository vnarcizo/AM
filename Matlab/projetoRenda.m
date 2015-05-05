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
clear ; close all; clc

%Numero de particoes;
numeroParticoes = 10;

%% Carregamento dos dados
fprintf('Carregamento dos dados iniciados...\n\n');
%load('projetoDados.mat');

dadosOriginais = readtable('adult_data');
dadosOriginaisTeste = readtable('adult_test');

%% Pré-processamento
fprintf('Pré-processando iniciado...\n\n');

[dadosPreprocessados, rotulos, indicesAusentes, tamanhoCaracteristica] = preProcessar(dadosOriginais, dadosOriginaisTeste);

%% Partição 
fprintf('Partição iniciada...\n\n');

[dadosParticionados] = particionar(dadosPreprocessados, numeroParticoes);

%% Normalização
fprintf('Normalização iniciada...\n\n');

[dadosNormalizados] = normalizar(dadosPreprocessados);

pause;

%% Classificação
for i = 1:numeroParticoes
    indicesTreinamento = 1:numeroParticoes;
    indicesTreinamento = indicesTreinamento(indicesTreinamento~=i);
    
    dadosTreinamento = dadosParticionados(indicesTreinamento,:,:);
    dadosTreinamento = reshape(dadosTreinamento, size(dadosTreinamento, 1)*size(dadosTreinamento, 2), size(dadosTreinamento, 3));
    dadosTeste = dadosParticionados(i,:,:);
    dadosTeste = squeeze(dadosTeste);
    % pause;
    
    % KNN
    % [acuraciaKnn] = knn(dadosTreinamento, dadosTeste);
    
    % Regressão Logística
end


%% Finalizacao
%clear; %Descomentar na versao final
close all;