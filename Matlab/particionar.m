function [ dadosParticionados, dadosNaiveBayesParticionados ] = particionar(dados, dadosNaiveBayes, numeroParticoes)
   limiteIndices = idivide(size(dados,1), int32(numeroParticoes)) * numeroParticoes;
   indices = randperm(limiteIndices);
   dadosParticionados = reshape(dados(indices, :), numeroParticoes, [], size(dados, 2));
   dadosNaiveBayesParticionados = reshape(dadosNaiveBayes(indices,:), numeroParticoes, [], size(dadosNaiveBayes, 2));
end

