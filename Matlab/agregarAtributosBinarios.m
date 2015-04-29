function [ indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, categorias] = ...
    agregarAtributosBinarios( indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, atributos)

%Atributos dispostos de forma binaria, conjunto de valores possiveis que o
%atributo pode assumir, indice da categoria desconhecida '?' se houver
[atributosBinarios, categorias, indiceAusenteCategoria] = pivotMatrizBinaria(atributos);

%Indices das colunas que representam informacoes desconhecidas '?'
if not(isempty(indiceAusenteCategoria))
    indicesAusentes(end + 1) = (size(dadosPreprocessados, 2) + indiceAusenteCategoria);
end

%Número de valores que o atributo pode assumir a.k.a. colunas ocupadas pelo atributo na forma binaria
tamanhoCaracteristica(indiceAtributoAtual, 1) = size(atributosBinarios, 2);

%Dados processados e agregados
dadosPreprocessados = horzcat(dadosPreprocessados, atributosBinarios);

%Indice do atributo atual incrementado
indiceAtributoAtual =  indiceAtributoAtual + 1;
end

