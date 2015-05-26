function [ avaliacao ] = knn(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, k)
    tic;
    fprintf('Calculando distancias\n');
    D = pdist2(atributosTreinamento, atributosTeste);
    fprintf('Distancias calculadas\n');
    m = size(atributosTeste, 1);
    valorPrevisto = zeros(m);
    fprintf('Ordenando matriz de distancias\n');
    [ D ind ] = sort(D, 2);
    fprintf('Matriz ordenada\n');
    fprintf('Encontrando vizinhos\n');
    for i = 1:m
        valorPrevisto(i) = mode(rotulosTreinamento(ind(i, 1:k)));
    end
    fprintf('Vizinhos encontrados\n');
    avaliacao = avaliar(valorPrevisto, rotulosTeste);
    toc
end