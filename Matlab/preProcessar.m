function [ dadosPreprocessados ] = preProcessar(dadosOriginais, dadosOriginaisTeste)
dadosOriginaisAgrupados = vertcat(dadosOriginais, dadosOriginaisTeste);

workclass      = pivotMatrizBinaria(dadosOriginaisAgrupados.workclass);
maritalstatus  = pivotMatrizBinaria(dadosOriginaisAgrupados.marital_status);
occupation     = pivotMatrizBinaria(dadosOriginaisAgrupados.occupation);
relationship   = pivotMatrizBinaria(dadosOriginaisAgrupados.relationship);
race           = pivotMatrizBinaria(dadosOriginaisAgrupados.race);
sex            = pivotMatrizBinaria(dadosOriginaisAgrupados.sex);
native_country = pivotMatrizBinaria(dadosOriginaisAgrupados.native_country);
target         = pivotMatrizBinaria(dadosOriginaisAgrupados.target);

dadosPreprocessados = horzcat(workclass, maritalstatus, occupation, relationship, race, sex, native_country, target);

%size(dadosPreprocessados);

end

