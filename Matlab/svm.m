function [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao, modeloCarregadoSVM )

%SVM Treinamento e Classificação do Método SVM
%  [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento
%  , atributosTeste, rotulosTeste, numeroParticao, modeloCarregadoSVM )


       fprintf('\nInício Partição #%d\n', numeroParticao);
              
       %Verifica se já foi calculado anteriormente o processo de
       %treinamento, caso contenha zero no modeloCarregado SVM, diz que não
       %foi previamente carregado, necessitando assim efetuar o treinamento
       if (isnumeric(modeloCarregadoSVM))
            tic;
            modeloSVM =  svmtrain(rotulosTreinamento, atributosTreinamento, '-c 1 -t 1 ');
            fprintf('Tempo treinamento: %d\n', toc);
       else
           modeloSVM = modeloCarregadoSVM;
       end
       
       
       %Efetuar a classificação da base de treinamento
       [valorPrevisto, ~, ~] = svmpredict(rotulosTreinamento, atributosTreinamento, modeloSVM);
       
       %Mostra a acuracia na base de treinamento
       fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

       %Efetuar a classificação da base de teste
       [valorPrevistoTeste, ~, ~] = svmpredict(rotulosTeste, atributosTeste, modeloSVM);
       
       %Mostra a acuracia na base de teste
       fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevistoTeste == rotulosTeste)) * 100);
       
       %Efetua a Avaliação do Método SVM
       [avaliacao] = avaliar(valorPrevistoTeste, rotulosTeste);
       
       fprintf('\Fim Partição #%d\n', numeroParticao);
end

