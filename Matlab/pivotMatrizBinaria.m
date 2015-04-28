function [ matrizBinaria, categorias ] = pivotMatrizBinaria( atributo )
tic;
%   Categoriza os valores do atributo fornecido
atributoCategorizado = categorical(atributo);

%Obtem as categorias presentes no atributo fornecido
categorias = categories(atributoCategorizado);

%Cria uma matriz da expansao das categorias possiveis do atributo para
%binario contendo uma linha para cada atributo de entrada e uma coluna para
%cada valor que o atributo possa assumir
matrizBinaria = zeros(size(atributo, 1), size(categorias, 1));

% Para cada uma das categorias verifica checa se o atributo
%Verificando uma maneira melhor, por enquanto fica assim mesmo
for i = 1: size(categorias,1)
    matrizBinaria(:,i) = ismember(atributoCategorizado, categorias(i));
end

toc;
end

