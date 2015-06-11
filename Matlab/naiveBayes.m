function [avaliacao, modeloNB] = naiveBayes(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, numeroParticao)
[pAtrMaior, pAtrMenor] = NB_calcularProbabilidades(atributosTreinamento, rotulosTreinamento);

fprintf('\nInício Partição #%d\n', numeroParticao);

tic;

pMaior = mean(rotulosTreinamento == 1);
pMenor = mean(rotulosTreinamento == 0);

valorPrevisto = arrayfun(@(i) NB_classificacao(atributosTreinamento(i,:), pMaior, pMenor, pAtrMaior, pAtrMenor), 1:size(atributosTreinamento, 1))';

fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

valorPrevistoTeste = arrayfun(@(i) NB_classificacao(atributosTeste(i,:), pMaior, pMenor, pAtrMaior, pAtrMenor), 1:size(atributosTeste, 1))';

fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevistoTeste == rotulosTeste)) * 100);
tempo = toc;
fprintf('Tempo processamento: %f\n', tempo);

fprintf('Fim Partição #%d\n\n', numeroParticao);

avaliacao = avaliar(valorPrevistoTeste, rotulosTeste, tempo);
modeloNB = 0;

end

