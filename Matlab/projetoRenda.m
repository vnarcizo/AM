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
% O programa solicita qual normalização deseja efetuar, se por Escala ou
% Padronização

tipoNormalizacao = input('Deseja normalizar por Escala ou Padronização? (E/P) \n', 's');

if(strcmpi(tipoNormalizacao, 'E'))
    fprintf('Normalização por escala iniciada...\n\n');
    [dadosNormalizados] = normalizarEscala(dadosPreprocessados);
else
    fprintf('Normalização por padronização iniciada...\n\n');
    [dadosNormalizados] = normalizarPadronizacao(dadosPreprocessados);
end

rotulosNormalizados = rotulos;

fprintf('Removendo dados ausentes...\n\n') %Remove p linhas

%Obtendo as amostras com todos os atributos preenchidos

linhasAusentes = any(dadosPreprocessados(:, colunasAusentes), 2);
dadosNormalizados(linhasAusentes, :) = [];
rotulosNormalizados(linhasAusentes, :) = [];

dadosNormalizados(:, colunasAusentes) = [];

Z = reduzir_atributos(dadosNormalizados, 3);

pos = find(rotulosNormalizados == 1);
neg = find(rotulosNormalizados == 0);
figure; hold on;

scatter3(Z(pos(1:10000), 1), Z(pos(1:10000), 2), Z(pos(1:10000), 3), 'b+');
scatter3(Z(neg(1:10000), 1), Z(neg(1:10000), 2), Z(neg(1:10000), 3), 'ro');

%plot(Z(neg(1:10000), 1), Z(neg(1:10000), 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
%plot(Z(pos(1:10000), 1), Z(pos(1:10000), 2), 'b+','LineWidth', 2, 'MarkerSize', 7);
title('Plot 3D da base de dados');
hold off;
dadosNaiveBayes(linhasAusentes, :) = [];
dadosNaiveBayes(:, union(colunasAusentes, indiceNumericos)) = [];

%% ================= Parte 4: Particionamento das Amostras ====================
% Foi realizado o particionamento das amostras utilizando o método de
% Validação cruzada com 10 partições
fprintf('Partição iniciada...\n\n');
 
dadosAparticionar = horzcat(dadosNormalizados, rotulosNormalizados);

dadosAparticionarNaiveBayes =  horzcat(dadosNaiveBayes, rotulosNormalizados);

[dadosParticionados, dadosNaiveBayesParticionados] = particionar(dadosAparticionar, dadosNaiveBayes, numeroParticoes);

% size(dadosParticionados)
% size(dadosNaiveBayesParticionados)
metodoClassificacao = 0;


%% ================= Parte 5: Escolha do método a ser aplicado ====================
% Foi criado um menu para a escolha do método que será realizado o
% procedimento, 0 para executar todos os métodos de uma unica vez.

while metodoClassificacao ~= 6
    fprintf('0 - Todos\n')
    fprintf('1 - KNN\n')
    fprintf('2 - Regressão logística\n')
    fprintf('3 - Redes Neurais Artificiais\n')
    fprintf('4 - SVM\n')
    fprintf('5 - Naive Bayes\n')
    fprintf('6 - Sair\n')

    metodoClassificacao = input('Selecione o método que deseja executar\n');
    if metodoClassificacao == 6
        break
    end

    hipotesesRegressao = cell(numeroParticoes);
    avaliacoesRegressao = [];
    avaliacoesRNA = [];
    hipoteseCarregada = [];

    modelosSVM = cell(numeroParticoes);
    avaliacoesSVM = [];

    avaliacoesKnn = [];

    modelosNB = cell(numeroParticoes);
    avaliacoesNaiveBayes = [];

    %Cada método tem sua particularidade na escolha de parametros
    
    %Para o Knn devemos escolher quantos visinhos serão avaliados pelo
    %método
    if metodoClassificacao == 0 || metodoClassificacao == 1
        k = input('Qual o valor de K? (Número de vizinhos mais próximos): \n');
    end

    %Para a Regressão Logistica devemos escolher qual o tipo da Hipótese
    %que deverá ser aplicado e se desejará efetuar o procedimento com
    %Regularização
    if metodoClassificacao == 0 || metodoClassificacao == 2
        fprintf('1 - Hipótese linear\n')
        fprintf('2 - Hipótese quadrática\n')
        fprintf('3 - Hipótese cúbica\n')
        hipoteseRegressao = input('Selecione a hipótese desejada\n');

        carregarHipotese = input('Carregar hipotese previamente calculada? (S/N)\n', 's');

        lambda = 0;

        if strcmpi(carregarHipotese, 'S')
            load(strcat('HipoteseRegressao_',hipoteseRegressao,'.mat'));
        else
            utilizarRegularizacao = input('Utilizar regularização? (S/N)\n', 's');

            if (strcmpi(utilizarRegularizacao,'S'))
                lambda = input('Qual o valor do parâmetro de regularização?\n');
            end
        end

    end

    %Para RNA devemos escolher com quantos neuronios iremos treinar a rede
    if metodoClassificacao == 0 || metodoClassificacao == 3
        carregarThetas = input('Carregar os Thetas previamente calculados? (S/N)\n', 's');

        qtdNeuronios = 50;
        
        if (strcmpi(carregarThetas,'S'))
                load('thetasRedesNeurais.mat');
        else
          
           alterarQtdNeuronios = input('Deseja alterar o valor padrão de 50 neurônios para treinamento? (S/N)\n', 's');

           if (strcmpi(alterarQtdNeuronios,'S'))
              qtdNeuronios = input('Quantos neurônios deseja utilizar na RNA?\n');
           end
        end
        
    end

    %% ================= Parte 6: Treinamento e Classificação ====================
    % Os metodos serão executados para cada partição das 10 previamente
    % separadas
    for i = 1:numeroParticoes
        
        %efetuando a separação dos dados/rotulos de treinamento e de
        %teste
        indicesTreinamento = 1:numeroParticoes;
        indicesTreinamento = indicesTreinamento(indicesTreinamento~=i);

        dadosTreinamento = dadosParticionados(indicesTreinamento,:,:);
        dadosTreinamento = reshape(dadosTreinamento, size(dadosTreinamento, 1)*size(dadosTreinamento, 2), size(dadosTreinamento, 3));
        dadosTeste = dadosParticionados(i,:,:);
        dadosTeste = squeeze(dadosTeste);

        rotulosTreinamento = dadosTreinamento(:,end);
        atributosTreinamento = dadosTreinamento(:,1:end-1);

        rotulosTeste = dadosTeste(:, end);
        atributosTeste = dadosTeste(:, 1:end-1);

        % KNN - Executar o método de avaliação
        if metodoClassificacao == 0 || metodoClassificacao == 1
            
            %Efetua a predição para os atributos de teste
            avaliacaoKnn = knn(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, k, i);
            %Faz a concatenação das avaliações de todas as partições
            avaliacoesKnn = vertcat(avaliacoesKnn, avaliacaoKnn);
        end
       
        
        % Regressão Logistica - Executar a obtenção da Hipotese e a
        % avaliação dos dados de treinamento
        if metodoClassificacao == 0 || metodoClassificacao == 2

             %Verifica se deseja carregar a hipotese previamente calculada
             if (strcmpi(carregarHipotese,'N'))
                        [ avaliacao, hipotesesRegressao{i}] = ...
                        regressaoLogistica(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste,...
                        hipoteseRegressao, utilizarRegularizacao, lambda, i, 0 );   
             else
                 switch hipoteseRegressao
                        case 1
                            atributosTesteExpandidos = atributosTeste;
                        case 2
                            atributosTesteExpandidos = RL_expandeAtributosPolinomial(atributosTeste, 2);
                        case 3
                            atributosTesteExpandidos = RL_expandeAtributosPolinomial(atributosTeste, 3);
                 end

                    %Efetua a predição para os atributos de teste
                    valorPrevistoTeste = RL_predicao(melhorHipoteseRegressao, atributosTesteExpandidos);
                    
                    %Chama o método Avaliar que faz todo o processo de
                    %geração de indices para avaliação do método
                    avaliacao = avaliar(valorPrevistoTeste,valorPrevistoTeste);
             end

               %Faz a concatenação das avaliações de todas as partições
               avaliacoesRegressao = vertcat(avaliacoesRegressao, avaliacao);
        end
        
        % RNA - Executar a obtenção dos Thetas e efetua a 
        % avaliação dos dados de treinamento
        if metodoClassificacao == 0 || metodoClassificacao == 3

            %Verifica se deseja obter os Thetas previamente calculados
             if (strcmpi(carregarThetas,'N'))
               %Efetua o Treinamento da RNA
               [mTheta1, mTheta2, avaliacao] = RNA_treinamento(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste,i,qtdNeuronios,100);
             else
                 rTesteItem = zeros(size(atributosTeste,1),1);
                 
                  %Para cada amostra de teste é obtido a sua predição
                  for item = 1:size(atributosTeste,1)
                      rTesteItem(item) =  RNA_forward(atributosTeste(item,:),mTheta1, mTheta2);
                  end

                    %Chama o método Avaliar que faz todo o processo de
                    %geração de indices para avaliação do método
                    avaliacao = avaliar(rTesteItem,rotulosTeste);
             end
             %Faz a concatenação das avaliações de todas as partições
             avaliacoesRNA = vertcat(avaliacoesRNA, avaliacao);
        end
        
        % SVM - Executar a obtenção do Modelo e efetuar a  
        % avaliação dos dados de treinamento
        if metodoClassificacao == 0 || metodoClassificacao == 4
            [avaliacao, modelosSVM{i}] = svm(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, i);
        end
                
        
        % Naive Bayes - Executar a obtenção das probabilidades e efetuar 
        % avaliação dos dados de treinamento
        if metodoClassificacao == 0 || metodoClassificacao == 5
              dadosTreinamentoNB = dadosNaiveBayesParticionados(indicesTreinamento,:,:);
              dadosTreinamentoNB = reshape(dadosTreinamentoNB, size(dadosTreinamentoNB, 1)*size(dadosTreinamentoNB, 2), size(dadosTreinamentoNB, 3));

              dadosTesteNB = squeeze(dadosNaiveBayesParticionados(i,:,:));

              rotulosTreinamentoNB = dadosTreinamentoNB(:,end);
              atributosTreinamentoNB = dadosTreinamentoNB(:,1:end-1);

              rotulosTesteNB = dadosTesteNB(:, end);
              atributosTesteNB = dadosTesteNB(:, 1:end-1);

            [avaliacao, modelosNB{i}] = naiveBayes(atributosTreinamentoNB, rotulosTreinamento, atributosTesteNB, rotulosTeste, i);
        end

    end

    if metodoClassificacao == 0 || metodoClassificacao == 1
        fprintf('Resultados KNN\n');
        avaliarFinal(avaliacoesKnn);
    end

    if metodoClassificacao == 0 || metodoClassificacao == 2
        fprintf('Resultados regressão logística\n');
        indiceMelhorHipotese = avaliarFinal(avaliacoesRegressao);

        exportarRegresao = input('Deseja exportar a melhor hipotese? (S/N)\n', 's');
        if (strcmpi(exportarRegresao,'S'))
            melhorHipoteseRegressao = hipotesesRegressao{indiceMelhorHipotese};
            save(strcat('HipoteseRegressao_', num2str(hipoteseRegressao), ' .mat'), 'melhorHipoteseRegressao','hipoteseRegressao');
        end   
    end

    if metodoClassificacao == 0 || metodoClassificacao == 4
        fprintf('Resultados SVM \n');
        indiceMelhorModelo = avaliarFinal(avaliacoesSVM);

        exportarSVM = input('Deseja exportar o modelo do SVM? (S/N)\n', 's');

        if (strcmpi(exportarSVM,'S'))
            melhorModeloSVM = modelosSVM{indiceMelhorHipotese};
            save('ModeloSVM.mat', 'melhorModeloSVM');
        end   
    end
end

%% Finalizacao
%clear; %Descomentar na versao final
%close all;