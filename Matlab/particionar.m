function [ dadosParticionados, dadosNaiveBayesParticionados ] = particionar(dados, dadosNaiveBayes, numeroParticoes)
   
   limiteIndices = idivide(size(dados,1), int32(numeroParticoes)) * numeroParticoes;
   indices = 0;
   %Faz a randomização dos indices somente uma única vez, dessa forma todos
   %os testes serão executados com a mesma base de dados
   
   if ~(exist('indices.mat', 'file') == 2)
        indices = randperm(limiteIndices);
        save('indices.mat','indices');
   else
        load('indices.mat');
   end
   
   dadosParticionados = reshape(dados(indices, :), numeroParticoes, [], size(dados, 2));
   dadosNaiveBayesParticionados = reshape(dadosNaiveBayes(indices,:), numeroParticoes, [], size(dadosNaiveBayes, 2));
end

