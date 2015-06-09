function [ avaliacao, modeloSVM ] = svm( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao )
       fprintf('\nInício Partição #%d\n', numeroParticao);
       tic;
       
       modeloSVM = svmtrain(rotulosTreinamento, atributosTreinamento, '-c 1 -t 1');
       
       fprintf('Tempo treinamento: %d\n', toc);
       
       [valorPrevisto, ~, ~] = svmpredict(rotulosTreinamento, atributosTreinamento, modeloSVM);
       
       fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

       [valorPrevistoTeste, ~, ~] = svmpredict(rotulosTeste, atributosTeste, modeloSVM);
       
       fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevistoTeste == rotulosTeste)) * 100);
       
       [avaliacao] = avaliar(valorPrevistoTeste, rotulosTeste);
       
       fprintf('\Fim Partição #%d\n', numeroParticao);
end

