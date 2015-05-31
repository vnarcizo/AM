function [ dadosNaiveBayes ] = preProcessarNaiveBayes(dadosPreprocessados, indiceNumericos )
    numeroCestas = 10;
    dadosNumericos = dadosPreprocessados(:, indiceNumericos);
    
    dadosNaoNumericos = dadosPreprocessados;
    dadosNaoNumericos(:, indiceNumericos) = [];
   
    dadosNaiveBayes = [];
    
    for i = 1:size(dadosNumericos, 2)
        dadosNaiveBayes = horzcat(dadosNaiveBayes, expandeMatrizBinariaCestas(dadosNumericos(:, i), numeroCestas));
    end

    %Ordem é importante
    dadosNaiveBayes = horzcat(dadosNaoNumericos, dadosNaiveBayes);
    
    
end

