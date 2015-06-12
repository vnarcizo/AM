function [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao, modeloCarregadoSVM )
       fprintf('\nInício Partição #%d\n', numeroParticao);
       tic;
       
       if (isnumeric(modeloCarregadoSVM))
            %Melhor linear -t 0 -c 0.01
            %Melhor radial -t 2 -c 0.01 -g 0.01
            modeloSVM =  svmtrain(rotulosTreinamento, atributosTreinamento, '-t 2 -c 1 -g 0.01 -q');
       else
           modeloSVM = modeloCarregadoSVM;
       end
       
       [valorPrevisto, ~, ~] = svmpredict(rotulosTreinamento, atributosTreinamento, modeloSVM);
       
       fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

       [valorPrevistoTeste, ~, ~] = svmpredict(rotulosTeste, atributosTeste, modeloSVM);
       
       fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevistoTeste == rotulosTeste)) * 100);
       
       tempo = toc;
       
       fprintf('Tempo treinamento e validação: %d\n', tempo);
       
       [avaliacao] = avaliar(valorPrevistoTeste, rotulosTeste, tempo);
       
       fprintf('\Fim Partição #%d\n', numeroParticao);
end

