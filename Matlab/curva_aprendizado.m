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
        curvaRNA = [];
        curvaKNN = [];
        curvaNaive = [];
        curvaRL = [];
        curvaSVM = [];

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

            fprintf('\nInício Partição #%d - BaseTreinamento: #%d\n', i,size(dadosTreinamento,1));
            
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

                [ ~, hipotesesRegressao] = ...
                regressaoLogistica(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste,...
                hipoteseRegressao, utilizarRegularizacao, lambda, i, 0 );   

                switch hipoteseRegressao
                    case 1
                        atributosTesteExpandidos = atributosTeste;
                        atributosTreinamentoExpandidos = atributosTreinamento;
                    case 2
                        atributosTesteExpandidos = RL_expandeAtributosPolinomial(atributosTeste, 2);
                        atributosTreinamentoExpandidos =  RL_expandeAtributosPolinomial(atributosTreinamento, 2);
                    case 3
                        atributosTesteExpandidos = RL_expandeAtributosPolinomial(atributosTeste, 3);
                        atributosTreinamentoExpandidos =  RL_expandeAtributosPolinomial(atributosTreinamento, 3);
                end

                %Efetua a predição para os atributos de teste
                valorPrevistoTreinamento = RL_predicao(hipotesesRegressao, atributosTreinamento);
                
                %Efetua a predição para os atributos de teste
                valorPrevistoTeste = RL_predicao(hipotesesRegressao, atributosTesteExpandidos);
                
                erroTreinamentoRL= (sum(valorPrevistoTreinamento ~= rotulosTreinamento)/size(rotulosTreinamento,1))*100;
                erroTesteRL = (sum(valorPrevistoTeste ~= rotulosTeste)/size(rotulosTeste,1))*100;
                    
                 curvaRL = vertcat(curvaRL, [erroTreinamentoRL erroTesteRL]);
               
            end

            % RNA - Executar a obtenção dos Thetas e efetua a 
            % avaliação dos dados de treinamento
            if metodoClassificacao == 0 || metodoClassificacao == 3

                 [mTheta1, mTheta2, avaliacao] = RNA_treinamento(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste,i,qtdNeuronios,100);
             
                  %Obtendo os rótulos da base de treinamento para comparar com os rótulos
                    %reais
         
                    for k = 1 : size(atributosTreinamento,1)
                          predicaoTreinamentoRNA(k) =  RNA_forward(atributosTreinamento(k,:),mTheta1, mTheta2);
                    end
                    
                    for k = 1 : size(atributosTeste,1)
                        predicaoTesteRNA(k) =  RNA_forward(atributosTeste(k,:),mTheta1, mTheta2);
                    end
                    
                    erroTreinamentoRNA = (sum(predicaoTreinamentoRNA' ~= rotulosTreinamento)/size(rotulosTreinamento,1))*100;
                    erroTesteRNA = (sum(predicaoTesteRNA' ~= rotulosTeste)/size(rotulosTeste,1))*100;
                    
                   curvaRNA = vertcat(curvaRNA, [erroTreinamentoRNA erroTesteRNA]);
                 
            end

            % SVM - Executar a obtenção do Modelo e efetuar a  
            % avaliação dos dados de treinamento
            if metodoClassificacao == 0 || metodoClassificacao == 4
                 melhorModeloSVM = 0;
                [avaliacao, modeloSVM] = svm(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, i,melhorModeloSVM);
                
                [valorPrevisto, ~, ~] = svmpredict(rotulosTreinamento, atributosTreinamento, modeloSVM);
                
                [valorPrevistoTeste, ~, ~] = svmpredict(rotulosTeste, atributosTeste, modeloSVM);
                
                 erroTreinamentoSVM = (sum(valorPrevisto ~= rotulosTreinamento)/size(rotulosTreinamento,1))*100;
                 erroTesteSVM = (sum(valorPrevistoTeste ~= rotulosTeste)/size(rotulosTeste,1))*100;
                    
                 curvaSVM = vertcat(curvaSVM, [erroTreinamentoSVM erroTesteSVM]);
                
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

                 [avaliacao, pMaior, pMenor, pAtrMaior, pAtrMenor] = naiveBayes(atributosTreinamentoNB, rotulosTreinamentoNB, atributosTesteNB, rotulosTesteNB, i);
  
                 predicaoTreinamentoNaive = arrayfun(@(i) NB_classificacao(atributosTreinamentoNB(i,:), pMaior, pMenor, pAtrMaior, pAtrMenor), 1:size(atributosTreinamentoNB, 1))';
                 predicaoTesteNaive = arrayfun(@(i) NB_classificacao(atributosTesteNB(i,:), pMaior, pMenor, pAtrMaior, pAtrMenor), 1:size(atributosTesteNB, 1))';
                 
                 erroTreinamentoNaive = (sum(predicaoTreinamentoNaive ~= rotulosTreinamentoNB)/size(rotulosTreinamentoNB,1))*100;
                 erroTesteNaive = (sum(predicaoTesteNaive ~= rotulosTesteNB)/size(rotulosTesteNB,1))*100;
                    
                 curvaNaive = vertcat(curvaNaive, [erroTreinamentoNaive erroTesteNaive]);
        
            end

        end

     %% ================= Parte 7: Resultados ====================
        % Aqui mostrará as curvas obtidas pelos métodos selecioinados

        
         % KNN - Executar o método de avaliação
            if metodoClassificacao == 0 || metodoClassificacao == 1
                figure;
                 plot(curvaKNN);
                 axis([1, 9, 0, 30]);
                 
                 title('Cruva de Aprendizagem - KNN');
            end


            % Regressão Logistica - Executar a obtenção da Hipotese e a
            % avaliação dos dados de treinamento
            if metodoClassificacao == 0 || metodoClassificacao == 2
                figure;
                 plot(curvaRL);
                 axis([1, 9, 0, 30]);
          
                 title('Cruva de Aprendizagem - Regressão Logistica');
            end

            % RNA - Executar a obtenção dos Thetas e efetua a 
            % avaliação dos dados de treinamento
            if metodoClassificacao == 0 || metodoClassificacao == 3

                figure;
                 plot(curvaRNA);
                 axis([1, 9, 0, 30]);
                 
                 title('Cruva de Aprendizagem - RNA');
                
            end

            % SVM - Executar a obtenção do Modelo e efetuar a  
            % avaliação dos dados de treinamento
            if metodoClassificacao == 0 || metodoClassificacao == 4
            
                 figure;
                 plot(curvaSVM);
                 axis([1, 9, 0, 30]);
                
                title('Cruva de Aprendizagem - SVM');
            end

            % Naive Bayes - Executar a obtenção das probabilidades e efetuar 
            % avaliação dos dados de treinamento
            if metodoClassificacao == 0 || metodoClassificacao == 5
             
                 figure;
                 plot(curvaNaive);
                 axis([1, 9, 0, 30]);
                 title('Cruva de Aprendizagem - Naive');
            end
            
            
            legend('Base de Treinamento','Base de Teste');
            xlabel('Quantidade de partições utilizadas no treinamento');
            ylabel('Porcentagem de Erro na Predição');
       
    end
end