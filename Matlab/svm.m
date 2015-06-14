function [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao, modeloCarregadoSVM, kernel, custo, gama )

%SVM Treinamento e Classificação do Método SVM
%  [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento
%  , atributosTeste, rotulosTeste, numeroParticao, modeloCarregadoSVM )


       fprintf('\nInício Partição #%d\n', numeroParticao);

              
       %Verifica se já foi calculado anteriormente o processo de
       %treinamento, caso contenha zero no modeloCarregado SVM, diz que não
       %foi previamente carregado, necessitando assim efetuar o treinamento

       tic;
       parametros = '';
       
       if kernel == 0
           parametros = strcat({'-t '},num2str(kernel),{' -c '},num2str(custo),{' -q'});
       else
           parametros = strcat({'-t '},num2str(kernel),{' -c '},num2str(custo),{' -g '},num2str(gama),{' -q'});
       end
       

       if (isnumeric(modeloCarregadoSVM))
            %Melhor linear -t 0 -c 0.01
            %Melhor radial -t 2 -c 0.01 -g 0.01
            modeloSVM =  svmtrain(rotulosTreinamento, atributosTreinamento, parametros);
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
       tempo = toc;
       
       fprintf('Tempo treinamento e validação: %d\n', tempo);
       
       [avaliacao] = avaliar(valorPrevistoTeste, rotulosTeste, tempo);
       
       fprintf('\nFim Partição #%d\n', numeroParticao);
end

