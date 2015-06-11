function [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao, modeloCarregadoSVM )
       fprintf('\nInício Partição #%d\n', numeroParticao);
              
       if (isnumeric(modeloCarregadoSVM))
            tic;
            %Melhor linear -t 0 -c 0.01
            %Melhor radial -t 2 -c 0.01 -g 0.01
            modeloSVM =  svmtrain(rotulosTreinamento, atributosTreinamento, '-t 2 -c 0.01 -g 0.01');
            fprintf('Tempo treinamento: %d\n', toc);
       else
           modeloSVM = modeloCarregadoSVM;
       end
       
       [valorPrevisto, ~, ~] = svmpredict(rotulosTreinamento, atributosTreinamento, modeloSVM);
       
       fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

       [valorPrevistoTeste, ~, ~] = svmpredict(rotulosTeste, atributosTeste, modeloSVM);
       
       fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevistoTeste == rotulosTeste)) * 100);
       
       [avaliacao] = avaliar(valorPrevistoTeste, rotulosTeste);
       
       fprintf('\Fim Partição #%d\n', numeroParticao);
end

