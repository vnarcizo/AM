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
clear ; close all; format shortG; clc

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
    %[rotulosNormalizados] = normalizarEscala(rotulos);
else
    fprintf('Normalização por padronização iniciada...\n\n');
    [dadosNormalizados] = normalizarPadronizacao(dadosPreprocessados);
    %[rotulosNormalizados] = normalizarPadronizacao(rotulos);
end

%TODO: melhorar isso
rotulosNormalizados = rotulos;
   
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

dadosAparticionar = horzcat(dadosNormalizados, rotulosNormalizados);

[dadosParticionados] = particionar(dadosAparticionar, numeroParticoes);

%% Seleção do métodos

fprintf('0 - Todos\n')
fprintf('1 - KNN\n')
fprintf('2 - Regressão logística\n')
fprintf('3 - Redes Neurais Artificiais\n')
fprintf('4 - SVM\n')

metodoClassificacao = input('Selecione o método que deseja executar\n');

acuraciaRegressao = zeros(numeroParticoes);
fMedidaMediaRegressao = zeros(numeroParticoes);
precisaoMediaRegressao = zeros(numeroParticoes);
revocacaoMediaRegressao = zeros(numeroParticoes);
hipotesesRegressao = cell(numeroParticoes);

%% Selecoes de parametros adicionais para Regressao Logistica
if metodoClassificacao == 0 || metodoClassificacao == 2
    fprintf('1 - Hipótese linear\n')
    fprintf('2 - Hipótese quadrática\n')
    fprintf('3 - Hipótese cúbica\n')
    hipoteseRegressao = input('Selecione a hipótese desejada\n');
    
    utilizarRegularizacao = input('Utilizar regularização? (S/N)\n', 's');
    
    if (strcmpi(utilizarRegularizacao,'S'))
        lambda = input('Qual o valor do parâmetro de regularização?\n');
    else
        lambda = 0;
    end
end

%% Classificação
for i = 1:numeroParticoes
    indicesTreinamento = 1:numeroParticoes;
    indicesTreinamento = indicesTreinamento(indicesTreinamento~=i);
    
    dadosTreinamento = dadosParticionados(indicesTreinamento,:,:);
    dadosTreinamento = reshape(dadosTreinamento, size(dadosTreinamento, 1)*size(dadosTreinamento, 2), size(dadosTreinamento, 3));
    dadosTeste = dadosParticionados(i,:,:);
    dadosTeste = squeeze(dadosTeste);
    % pause;
    
    if metodoClassificacao == 0 || metodoClassificacao == 1
            % TODO:BAG
            % KNN
            % [acuraciaKnn] = knn(dadosTreinamento, dadosTeste);
    end
    % Regressão Logística
    if metodoClassificacao == 0 || metodoClassificacao == 2
       [ acuraciaRegressao(i), fMedidaMediaRegressao(i), precisaoMediaRegressao(i), revocacaoMediaRegressao(i), hipotesesRegressao{i}] = ...
           regressaoLogistica(dadosTreinamento, dadosTeste, hipoteseRegressao, utilizarRegularizacao, lambda, i );      
    end
    if metodoClassificacao == 0 || metodoClassificacao == 3
           %TODO Victor
            % Redes Neurais
    end
    if metodoClassificacao == 0 || metodoClassificacao == 4
            %TODO Leandro
            % SVM
    end
   
end


%% Finalizacao
%clear; %Descomentar na versao final
%close all;