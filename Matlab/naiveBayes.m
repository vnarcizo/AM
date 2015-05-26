function [avaliacao, modeloNB] = naiveBayes(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao)
[pAtrMaior, pAtrMenor] = NB_calcularProbabilidades(atributosTreinamento, rotulosTreinamento);

pMaior = mean(rotulosTreinamento == 1);
pMenor = mean(rotulosTreinamento == 0);

[valorPrevisto, ~, ~] = NB_classificacao(atributosTreinamento, pMaior, pMenor, pAtrMaior, pAtrMenor);

fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

avaliacao = 0;
modeloNB = 0;

end

