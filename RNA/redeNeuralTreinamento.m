function [ theta ] = redeNeuralTreinamento( entrada, saida, nCamadas, nNeuronios )
    
    theta = cell(nCamadas);
    theta{1} = randn(size(entrada,2)+1, size(entrada,2));
    for i = 2:nCamadas-1
        theta{i} = randn(nNeuronios+1, nNeuronios);
    end
    theta{nCamadas} = randn(nNeuronios+1, size(saida,2));
end