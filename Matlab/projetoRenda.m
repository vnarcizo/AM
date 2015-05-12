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

[dadosPreprocessados, rotulos, colunasAusentes, tamanhoCaracteristica] = preProcessar(dadosOriginais, dadosOriginaisTeste);


%% Normalização
tipoNormalizacao = input('Deseja normalizar por Escala ou Padronização? (E/P) \n', 's');

if(strcmpi(tipoNormalizacao, 'E'))
    fprintf('Normalização por escala iniciada...\n\n');
    [dadosNormalizados] = normalizarEscala(dadosPreprocessados);
    [rotulosNormalizados] = normalizarEscala(rotulos);
else
    fprintf('Normalização por padronização iniciada...\n\n');
    [dadosNormalizados] = normalizarPadronizacao(dadosPreprocessados);
    [rotulosNormalizados] = normalizarPadronizacao(rotulos);
end
   
%% Tratamento dos ausentes
manterAusentes = input('Deseja remover ou completar os dados ausentes? (R/C) \n', 's');

if (strcmpi(manterAusentes,'R'))
    fprintf('Removendo dados ausentes...\n\n') %Remove 3620 linhas
    linhasAusentes = any(dadosPreprocessados(:, colunasAusentes), 2);
    dadosNormalizados(linhasAusentes, :) = [];
    rotulosNormalizados(linhasAusentes, :) = [];
else
    fprintf('Completando dados ausentes... \n\n')
    %TODO: Bag Usar os dados normalizados
end

%% Partição 
fprintf('Partição iniciada...\n\n');

[dadosParticionados] = particionar(dadosPreprocessados, numeroParticoes);



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