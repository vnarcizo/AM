function [ dadosPreprocessados, rotulos, indicesAusentes, tamanhoCaracteristica ] = preProcessar(dadosOriginais, dadosOriginaisTeste)

%Concatena os dados da base original com a base de teste
dadosOriginaisAgrupados = vertcat(dadosOriginais, dadosOriginaisTeste);

%age, workclass, fnlwgt, education, education-num, marital-status, occupation, 
%relationship, race, sex, capital-gain, capital-loss, hours-per-week, native-country, target

%Vetor para representar quantas colunas cada atributo original
%(característica) ocupara na matriz final
tamanhoCaracteristica = ones(1, size(dadosOriginaisAgrupados, 2)); % 15

%Indice para determinar qual atributo original (caracteristica) está sendo
%processado agora
indiceAtributoAtual = 1;

%Vetor com os indices das colunas que representam a ausência de informacao para
% um atributo original (caracterisitica)
indicesAusentes = [];

%Matriz final apos o pré-processamento
dadosPreprocessados = [];

%% Age
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.age);

%% Workclass
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.workclass);

%% Fnlwgt
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.fnlwgt);

%% Education
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.education);

%% Education_num
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.education_num);

%% Marital Status
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.marital_status);

%% Ocupation
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.occupation);

%% Relationship
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.relationship);

%% Race
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.race);

%% Sex
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.sex);

%% Capital_gain
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.capital_gain);

%% Capital_loss
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.capital_loss);

%% Native_country
[indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, indicesAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.native_country);

%% Hours_per_week
[~, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.hours_per_week);

%% Rotulos
rotulos = zeros(size(dadosOriginaisAgrupados,1));

indices = cellfun(@(x) strcmpi(x, '>50k') | strcmpi(x, '>50k.'), dadosOriginaisAgrupados.target);

rotulos(indices) = 1;

end

