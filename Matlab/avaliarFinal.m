function [indiceMelhorHipotese] = avaliarFinal( tabelaAvaliacao )

    %% avaliarFinal Obtem a melhor avaliação através da FMedida
    %
    %   [indiceMelhorHipotese] = avaliarFinal( tabelaAvaliacao )
    %   Obtem a melhor avaliação passando como parametro o Tabela de
    %   avaliações geradas por todos as partições e retorna o indice do
    %   melhor resultado obtido

  
    tabelaAvaliacao
    media = table(mean(tabelaAvaliacao.acuracia), ...
            mean(tabelaAvaliacao.fMedidaMedia), ...
            mean(tabelaAvaliacao.precisaoMedia), ...
            mean(tabelaAvaliacao.revocacaoMedia), ...
            'VariableNames', {'acuracia', 'fMedidaMedia', 'precisaoMedia', 'revocacaoMedia'});
           % mean(tabelaAvaliacao.tempo),...
           %'VariableNames', {'acuracia', 'fMedidaMedia', 'precisaoMedia', 'revocacaoMedia', 'tempo'});
            
    media
    [~,indiceMelhorHipotese] = max(tabelaAvaliacao.fMedidaMedia);
    
end

