function [ dadosPreprocessados, rotulos, colunasAusentes, tamanhoCaracteristica, indiceNumericos ] = preProcessar(dadosOriginais, dadosOriginaisTeste)

%Concatena os dados da base original com a base de teste
dadosOriginaisAgrupados = vertcat(dadosOriginais, dadosOriginaisTeste);

fprintf('Total de amostras iniciais: %d \n\n', size(dadosOriginaisAgrupados, 1))

%Remove possíveis amostras duplicadas
dadosOriginaisAgrupados = unique(dadosOriginaisAgrupados);

fprintf('Total de amostras únicas: %d \n\n', size(dadosOriginaisAgrupados, 1))

%Remove amostras que tenham os mesmos atributos, com atributos alvos
%distintos
[~, ia] = unique(dadosOriginaisAgrupados(:, 1:end-1));

dadosOriginaisAgrupados = dadosOriginaisAgrupados(ia, :);

fprintf('Total de amostras a serem alvos distintos: %d \n\n', size(dadosOriginaisAgrupados, 1))

% dadosOriginaisAgrupados.native_country = categorical(dadosOriginaisAgrupados.native_country);
% summary(dadosOriginaisAgrupados)

%age, workclass, fnlwgt, education, education-num, marital-status, occupation, 
%relationship, race, sex, capital-gain, capital-loss, hours-per-week, native-country, target

%Vetor para representar quantas colunas cada atributo original
%(característica) ocupara na matriz final
tamanhoCaracteristica = ones(size(dadosOriginaisAgrupados, 2) - 1, 1); % 15

%Indice para determinar qual atributo original (caracteristica) está sendo
%processado agora
indiceAtributoAtual = 1;

%Vetor com os indices das colunas que representam a ausência de informacao para
% um atributo original (caracterisitica)
colunasAusentes = [];

%Matriz final apos o pré-processamento
dadosPreprocessados = [];


%% Age
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.age);

indiceNumericos = 1;

%% Workclass
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.workclass);

%% Fnlwgt
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.fnlwgt);

indiceNumericos(end+1) = indiceAtributoAtual;

%% Education
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.education);

%% Education_num
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.education_num);

indiceNumericos(end+1) = indiceAtributoAtual;

%% Marital Status
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.marital_status);

%% Ocupation
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.occupation);

%% Relationship
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.relationship);

%% Race
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.race);

%% Sex
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.sex);

%% Capital_gain
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.capital_gain);

indiceNumericos(end+1) = indiceAtributoAtual;

%% Capital_loss
[indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.capital_loss);

indiceNumericos(end+1) = indiceAtributoAtual;

%% Native_country
[indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, ~] = ...
    agregarAtributosBinarios(indiceAtributoAtual, colunasAusentes, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.native_country);

%% Hours_per_week
[~, dadosPreprocessados, tamanhoCaracteristica] = ...
    agregarAtributoNumerico(indiceAtributoAtual, dadosPreprocessados, tamanhoCaracteristica, dadosOriginaisAgrupados.hours_per_week);

indiceNumericos(end+1) = indiceAtributoAtual;

%% Rotulos
rotulos = zeros(size(dadosOriginaisAgrupados, 1), 1);

indices = cellfun(@(x) strcmpi(x, '>50k') | strcmpi(x, '>50k.'), dadosOriginaisAgrupados.target);

rotulos(indices) = 1;

end

