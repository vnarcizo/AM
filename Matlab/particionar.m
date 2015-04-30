function [ dadosParticionados ] = particionar(dados, numeroParticoes)
   limiteIndices = idivide(size(dados,1), int32(numeroParticoes)) * numeroParticoes;
   indices = randperm(limiteIndices);
   dadosParticionados = reshape(dados(indices, :), numeroParticoes, [], size(dados, 2));
end

