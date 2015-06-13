function [ ] = curva_aprendizado( dadosNormalizados, dadosNaiveBayes, rotulosNormalizados )
%Numero de particoes;
numeroParticoes = 10;
%% ================= Parte 4: Particionamento das Amostras ====================
% Foi realizado o particionamento das amostras utilizando o método de
% Validação cruzada com 10 partições
fprintf('Curvas de aprendizado\n\n');
fprintf('Partição iniciada...\n\n');
 
dadosAparticionar = horzcat(dadosNormalizados, rotulosNormalizados);

dadosAparticionarNaiveBayes =  horzcat(dadosNaiveBayes, rotulosNormalizados);

[dadosParticionados, dadosNaiveBayesParticionados] = particionar(dadosAparticionar, dadosAparticionarNaiveBayes, numeroParticoes);

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

    avaliacoes = [];
       
    modelosSVM = cell(numeroParticoes);
    hipotesesRegressao = cell(numeroParticoes);
    hipoteseCarregada = [];

    modelosNB = cell(numeroParticoes);


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

        lambda = 0;

        utilizarRegularizacao = input('Utilizar regularização? (S/N)\n', 's');

        if (strcmpi(utilizarRegularizacao,'S'))
            lambda = input('Qual o valor do parâmetro de regularização?\n');
        end
    end

    %Para RNA devemos escolher com quantos neuronios iremos treinar a rede
    if metodoClassificacao == 0 || metodoClassificacao == 3 

       qtdNeuronios = 50;

       alterarQtdNeuronios = input('Deseja alterar o valor padrão de 50 neurônios para treinamento? (S/N)\n', 's');

       if (strcmpi(alterarQtdNeuronios,'S'))
          qtdNeuronios = input('Quantos neurônios deseja utilizar na RNA?\n');
       end
    end

    %% ================= Parte 6: Treinamento e Classificação ====================
    % Os metodos serão executados para cada partição das 10 previamente
    % separadas
    for i = 1:numeroParticoes-1
        %efetuando a separação dos dados/rotulos de treinamento e de
        %teste
        indicesTreinamento = 1:i;
        %indicesTreinamento = indicesTreinamento(indicesTreinamento~=i);

        dadosTreinamento = dadosParticionados(indicesTreinamento,:,:);
        dadosTreinamento = reshape(dadosTreinamento, size(dadosTreinamento, 1)*size(dadosTreinamento, 2), size(dadosTreinamento, 3));
        dadosTeste = dadosParticionados(numeroParticoes,:,:);
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
            avaliacoes = vertcat(avaliacoes, avaliacaoKnn);
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
               avaliacoes = vertcat(avaliacoes, avaliacao);
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
             avaliacoes = vertcat(avaliacoes, avaliacao);
        end
        
        % SVM - Executar a obtenção do Modelo e efetuar a  
        % avaliação dos dados de treinamento
        if metodoClassificacao == 0 || metodoClassificacao == 4
            [avaliacao, modelosSVM{i}] = svm(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, i,melhorModeloSVM);
            avaliacoes = vertcat(avaliacoes, avaliacao);
        end
                
        
        % Naive Bayes - Executar a obtenção das probabilidades e efetuar 
        % avaliação dos dados de treinamento
        if metodoClassificacao == 0 || metodoClassificacao == 5
              dadosTreinamentoNB = dadosNaiveBayesParticionados(indicesTreinamento,:,:);
              dadosTreinamentoNB = reshape(dadosTreinamentoNB, size(dadosTreinamentoNB, 1)*size(dadosTreinamentoNB, 2), size(dadosTreinamentoNB, 3));

              dadosTesteNB = squeeze(dadosNaiveBayesParticionados(numeroParticoes,:,:));

              rotulosTreinamentoNB = dadosTreinamentoNB(:,end);
              atributosTreinamentoNB = dadosTreinamentoNB(:,1:end-1);

              rotulosTesteNB = dadosTesteNB(:, end);
              atributosTesteNB = dadosTesteNB(:, 1:end-1);

             [avaliacao, modelosNB{i}] = naiveBayes(atributosTreinamentoNB, rotulosTreinamentoNB, atributosTesteNB, rotulosTesteNB, i);
            
              avaliacoes = vertcat(avaliacoes, avaliacao);
            
        end

    end
    
 %% ================= Parte 7: Resultados ====================
    % Aqui mostrará os resultados obtidos pelos métodos selecionados no
    % menu
    
    %Resultado - KNN
    fprintf('Resultados\n');
    avaliarFinal(avaliacoes);

    %Resultado - Regressão Logistica
    if metodoClassificacao == 0 || metodoClassificacao == 2
        fprintf('Resultados regressão logística\n');
        indiceMelhorHipotese = avaliarFinal(avaliacoesRegressao);

        exportarRegresao = input('Deseja exportar a melhor hipotese? (S/N)\n', 's');
        if (strcmpi(exportarRegresao,'S'))
            melhorHipoteseRegressao = hipotesesRegressao{indiceMelhorHipotese};
            save(strcat('HipoteseRegressao_', num2str(hipoteseRegressao), ' .mat'), 'melhorHipoteseRegressao','hipoteseRegressao');
        end   
    end

    %Resultado - RNA
    if metodoClassificacao == 0 || metodoClassificacao == 3
        fprintf('Resultados RNA \n');
        avaliarFinal(avaliacoesRNA);
    end
    
    %Resultado - SVM
    if metodoClassificacao == 0 || metodoClassificacao == 4
        fprintf('Resultados SVM \n');
        indiceMelhorModelo = avaliarFinal(avaliacoesSVM);

        exportarSVM = input('Deseja exportar o modelo do SVM? (S/N)\n', 's');

        if (strcmpi(exportarSVM,'S'))
            melhorModeloSVM = modelosSVM{indiceMelhorModelo};
            save('ModeloSVM.mat', 'melhorModeloSVM');
        end   
    end
    
    
     %Resultado - Naive Bayes
    if metodoClassificacao == 0 || metodoClassificacao == 5
        fprintf('Resultados Naive Bayes \n');
        indiceMelhorModelo = avaliarFinal(avaliacoesNaiveBayes);

        exportarNaive = input('Deseja exportar o modelo do NaiveBayes? (S/N)\n', 's');

        if (strcmpi(exportarNaive,'S'))
            melhorModeloNaive = modelosNB{indiceMelhorModelo};
            save('ModeloNaiveBayes.mat', 'melhorModeloNaive');
        end   
    end
end


end