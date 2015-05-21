function [ acuraciaRegressao, fMedidaMediaRegressao, precisaoMediaRegressao, revocacaoMediaRegressao ] = ...
    regressaoLogistica( dadosTreinamento, dadosTeste, hipoteseRegressao, utilizarRegularizacao, lambda ) 

rotulo = dadosTreinamento(:,end);
atributos = dadosTreinamento(:,1:end-1);

size(rotulo)
size(atributos)

switch hipoteseRegressao
    case 1
        atributosExpandidos = atributos;
    case 2
        atributosExpandidos = RL_expandeAtributosPolinomial(atributos);
    case 3
        atributosExpandidos = RL_expandeAtributosPolinomialLogEx(atributos);
end

thetaInicial = zeros(size(atributosExpandidos, 2), 1);

% Configura opções
opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

fprintf('Minimizando função de custo...');

tic;
% Otimiza o gradiente
[theta, J, exit_flag] = ...
	fminunc(@(t)(RL_funcaoCustoReg(t, atributosExpandidos, rotulo, lambda, utilizarRegularizacao)), thetaInicial, opcoes);
fprintf('Tempo minimização: %d\n', toc);

fprintf('Mínimo encontrado: %f\n', J);

valorPrevisto = RL_predicao(theta, atributosExpandidos);

fprintf('Acuracia na base de treinamento: %f\n', mean(double(valorPrevisto == rotulo)) * 100);


end

