function [ saida ] = redeNeuralClassificar(entrada, theta )

    a0 = [];
    a1 = [];
    ns = size(theta{size(theta,1)},2);
    saida = zeros(size(entrada,1),ns);
    for i = 1:size(entrada,1)
        a0 = [1, entrada(i,:)];
        for j = 1:size(theta,1)
            t = a0*theta{j};
            a1 = sigmf(t,[1 0]);
            a0 = [1, a1];
        end
        saida(i,:)=a1;
    end
    saida(saida>=0.5)=1;
    saida(saida<0.5)=0;
end