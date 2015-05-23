function [ theta ] = redeNeuralTreinamento( entrada, saida, nCamadas, nNeuronios )
    
    theta = cell(nCamadas);
    theta{1} = randn(size(entrada,2)+1, nNeuronios);
    for i = 2:nCamadas-1
        theta{i} = randn(nNeuronios+1, nNeuronios);
    end
    theta{nCamadas} = randn(nNeuronios+1, size(saida,2));
    
    for i = 1:size(entrada,1)
        x = entrada(i,:);
        y = redeNeuralClassificar(x, theta);
        dl = saida(i,:)-y);
        for j = 1:nCamadas
            l = nCamadas-j;
            dl = 
        end
    end
end