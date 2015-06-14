function [  indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica ] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, atributo )

%Concatena o atributo numerico aos outros dados
dadosPreprocessados = horzcat(dadosPreprocessados, atributo);

%Define o tamanho dessa caracteristica como 1
tamanhoCaracteristica(indiceAtributoAtual) = 1;

%Atualiza o indice do atributo atual
indiceAtributoAtual = indiceAtributoAtual + 1;
end