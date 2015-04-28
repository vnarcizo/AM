function [ dadosPreprocessados, rotulos, indicesAusentes ] = preProcessar(dadosOriginais, dadosOriginaisTeste)
dadosOriginaisAgrupados = vertcat(dadosOriginais, dadosOriginaisTeste);

%age, workclass, fnlwgt, education, education-num, marital-status, occupation, 
%relationship, race, sex, capital-gain, capital-loss, hours-per-week, native-country, target

age            = dadosOriginaisAgrupados.age;
[workclass, ~, iaWorkclass] = pivotMatrizBinaria(dadosOriginaisAgrupados.workclass);
fnwgt          = dadosOriginaisAgrupados.fnlwgt;
education      = pivotMatrizBinaria(dadosOriginaisAgrupados.education);
education_num  = dadosOriginaisAgrupados.education_num;
maritalstatus  = pivotMatrizBinaria(dadosOriginaisAgrupados.marital_status);
occupation     = pivotMatrizBinaria(dadosOriginaisAgrupados.occupation);
relationship   = pivotMatrizBinaria(dadosOriginaisAgrupados.relationship);
race           = pivotMatrizBinaria(dadosOriginaisAgrupados.race);
sex            = pivotMatrizBinaria(dadosOriginaisAgrupados.sex);
capital_gain   = dadosOriginaisAgrupados.capital_gain;
capital_loss   = dadosOriginaisAgrupados.capital_loss;
native_country = pivotMatrizBinaria(dadosOriginaisAgrupados.native_country);
hours_per_week = dadosOriginaisAgrupados.hours_per_week;

indicesAusentes = 0;

dadosPreprocessados = horzcat(age, workclass, fnwgt, education, education_num, maritalstatus, occupation,...
                              relationship, race, sex, capital_gain, capital_loss, hours_per_week, native_country);

rotulos = zeros(size(dadosOriginaisAgrupados,1));

indices = cellfun(@(x) strcmpi(x, '>50k') | strcmpi(x, '>50k.'), dadosOriginaisAgrupados.target);

rotulos(indices) = 1;


end

