function [ avaliacao, valorPrevisto ] = knn(atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, k, numeroParticao)
    
    %% Efetua o calculo da distancia de todos os dados para todos os dados
    %
    %   [ avaliacao ] = knn(atributosTreinamento, rotulosTreinamento, 
    %   atributosTeste, rotulosTeste, k, numeroParticao)
    %   Obtem a avaliação passando como parametro os atributos/Rotulos de
    %   Treinamento, e Atributos/Rotulos de Teste, alem da quantidade de
    %   visinhos que deseja calcular e qual partição esta dentro da
    %   validação cruzada

    fprintf('\nInício Partição #%d\n', numeroParticao);
    
    tic;
    
    %Realizando o calculo das distancias
    fprintf('Calculando distancias...\n');
    
    D = pdist2(atributosTreinamento, atributosTeste);
    
    fprintf('Distancias calculadas\n');
    
    m = size(atributosTeste, 1);
    
    fprintf('Ordenando matriz de distancias...\n');
    
    %Efetua a ordenação da matriz de distancias calculadas
    [ ~, ind ] = sort(D, 2);
    
    fprintf('Matriz ordenada\n');
    
    fprintf('Encontrando vizinhos...\n');
    
    %Encontra o valor do k vizinhos e mostra o seu rotulo para cada amostra
    %da base de treinamento
    valorPrevisto = arrayfun(@(i) mode(rotulosTreinamento(ind(i, 1:k))), 1:m)';
    
    fprintf('Vizinhos encontrados\n');
    
    tempo = toc;
    
    fprintf('Tempo treinamento: %f\n', tempo);
    
    %Mostra a acuracia da base de teste
    fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevisto == rotulosTeste)) * 100);
    
    fprintf('Fim Partição #%d\n\n', numeroParticao);
    
    %Efetua a avaliação
    avaliacao = avaliar(valorPrevisto, rotulosTeste, tempo);
end