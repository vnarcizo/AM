function [ dadosNaiveBayes ] = preProcessarNaiveBayes(dadosPreprocessados, indiceNumericos )
    numeroCestas = 10;
    dadosNumericos = dadosPreprocessados(:, indiceNumericos);
    [dadosNumericos] = normalizarEscala(dadosNumericos);
    
    dadosNaoNumericos = dadosPreprocessados;
  
    dadosNaiveBayes = [];
    
    for i = 1:size(dadosNumericos, 2)
        dadosNaiveBayes = horzcat(dadosNaiveBayes, expandeMatrizBinariaCestas(dadosNumericos(:, i), numeroCestas));
    end
    
    size(dadosNaiveBayes)

    %Ordem é importante
    dadosNaiveBayes = horzcat(dadosNaoNumericos, dadosNaiveBayes);
    
    
end

