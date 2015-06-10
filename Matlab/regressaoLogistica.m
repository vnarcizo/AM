function [ avaliacao,  theta ] = ...
    regressaoLogistica( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, ...
                        hipoteseRegressao, utilizarRegularizacao, lambda, numeroParticao, melhorHipoteseRegressao ) 
                    
%% Efetua a Regressão logistica
%  [ avaliacao,  theta ] = ...
%  regressaoLogistica( atributosTreinamento, rotulosTreinamento, atributosTeste, rotulosTeste, ...
%  hipoteseRegressao, utilizarRegularizacao, lambda, numeroParticao, melhorHipoteseRegressao )                   

fprintf('\nInício Partição #%d\n', numeroParticao);

%Verifica qual o tipo da hipotese para gerar atributos caracteristicos.
switch hipoteseRegressao
    case 1
        atributosExpandidos = atributosTreinamento;
        atributosTesteExpandidos = atributosTeste;
    case 2
        atributosExpandidos = RL_expandeAtributosPolinomial(atributosTreinamento, 2);
        atributosTesteExpandidos = RL_expandeAtributosPolinomial(atributosTeste, 2);
    case 3
        atributosExpandidos = RL_expandeAtributosPolinomial(atributosTreinamento, 3);
        atributosTesteExpandidos = RL_expandeAtributosPolinomial(atributosTeste, 3);
end

thetaInicial = zeros(size(atributosExpandidos, 2), 1);

% Configura opções
opcoes = optimset('GradObj', 'on', 'MaxIter', 400, 'Display', 'off');

fprintf('Minimizando função de custo...\n');

tic;
% Otimiza o gradiente
[theta, J, exit_flag] = ...
	fminunc(@(t)(RL_funcaoCustoReg(t, atributosExpandidos, rotulosTreinamento, lambda, utilizarRegularizacao)), thetaInicial, opcoes);
fprintf('Tempo minimização: %f\n', toc);

%Mostra o custo mínimo obtido através da fminunc
fprintf('Custo mínimo encontrado: %f\n', J);

%Efetua a prediçao da base de treinamento
valorPrevisto = RL_predicao(theta, atributosExpandidos);

%Mostra a acuracia do método na base de treinamento
fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulosTreinamento)) * 100);

%Efetua a prediçao da base de Teste
valorPrevistoTeste = RL_predicao(theta, atributosTesteExpandidos);

%Mostra a acuracia do método na base de Teste
fprintf('Acuracia na base de teste: %f\n', mean(double(valorPrevistoTeste == rotulosTeste)) * 100);

%Efetua a avaliação do método da Regressão Logistica
[avaliacao] = avaliar(valorPrevistoTeste, rotulosTeste);

fprintf('Fim Partição #%d\n\n', numeroParticao);

end

