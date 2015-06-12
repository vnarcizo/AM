function [ atributosNormalizados ] = normalizarEscala( atributos )

%% Normalização por Escala 
%   [ atributosNormalizados ] = normalizarEscala( atributos )


%Calcula os minimos
minimos = min(atributos);

%Calcula os maximos
maximos = max(atributos);

%Calcula os intervalos
intervalos = maximos - minimos;

%Calcula X_norm = (x_i - min) (Numerador)
atributosNormalizados = bsxfun(@minus, atributos, minimos);

%Calcula X_norm = X_norm / max - min (Denominador)
atributosNormalizados = bsxfun(@rdivide, atributosNormalizados, intervalos);

end


