function [avaliacao] = avaliar(obtidos, esperados, tempo)
    %acuracia, fMedidaMedia, precisaoMedia, revocacaoMedia
    classePositiva = esperados == obtidos;
    verdadeirosPositivos = nnz(classePositiva);
    falsosPositivos = nnz(~classePositiva);
    
    classeNegativa = ~esperados(~obtidos);
    verdadeirosNegativos = nnz(classeNegativa);
    falsosNegativo = nnz(~classeNegativa);
   
    
    acuracia = (verdadeirosPositivos + verdadeirosNegativos) / (verdadeirosPositivos + verdadeirosNegativos + falsosPositivos + falsosNegativo);
    
    %% Precisão
    precisaoPositiva = verdadeirosPositivos / (verdadeirosPositivos + falsosPositivos);
    precisaoNegativa = verdadeirosNegativos / (verdadeirosNegativos + falsosNegativo);
    
    precisaoMedia = (precisaoPositiva + precisaoNegativa) / 2;
    
    %% Revocação
    revocacaoPositiva = verdadeirosPositivos / (verdadeirosPositivos + falsosNegativo);
    revocacaoNegativa = verdadeirosNegativos / (verdadeirosNegativos + falsosPositivos);
    
    revocacaoMedia = (revocacaoPositiva + revocacaoNegativa)/ 2;
    
    %% F-medida
    fMedidaPos = 2 * (precisaoPositiva * revocacaoPositiva) / (precisaoPositiva + revocacaoPositiva);
    fMedidaNeg = 2 * (precisaoNegativa * revocacaoNegativa) / (precisaoNegativa + revocacaoNegativa);
    
    fMedidaMedia = (fMedidaPos + fMedidaNeg) / 2;
    
    avaliacao = table(acuracia, fMedidaMedia, precisaoMedia, revocacaoMedia, tempo);
end

