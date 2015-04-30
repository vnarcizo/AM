ofunction [y, ind_viz] = knn(x, X, Y, K)
%KNN método do K-vizinhos mais proximos para predizer a classe de um novo
%   dado.
%   [y, ind_viz] = KNN (x, X, Y, K) retorna o rotulo de x em y e os indices
%       ind_viz dos K-vizinhos mais proximos em X.
%
%       Parametros de entrada:
%       -> x (1xn): amostra a ser classificada
%       -> X (mxn): base de dados de treinamento
%       -> Y (mx1): rotulo de cada amostra de X
%       -> K (1x1): quantidade de vizinhos mais proximos
%
%       Parametros de saida:
%       -> y (1x1): predicao (0 ou 1) do rotulo de x
%       -> ind_viz (Kx1): indice das K amostras mais proximas de x
%                         encontradas em X (da mais proxima a menos
%                         proxima)
%

%  Inicializa a variavel de retorno e algumas variaveis uteis
y = 0;                % Inicializa rotulo como classe negativa
ind_viz = ones(K,1);  % Inicializa indices (linhas) em X das K amostras mais 
                      % proximas de x.


% ====================== ESCREVA O SEU CODIGO AQUI ========================
% Instrucoes: Implemente o método dos K-vizinhos mais proximos. Primeiro, 
%             eh preciso calcular a distancia entre x e cada amostra de X. 
%             Depois, encontre os K-vizinhos mais proximos e use voto
%             majoritario para definir o rotulo de x. 
%
% Obs: primeiro eh necessario implementar a funcao de similaridade
%      (distancia).
%

%  Calcula a distancia entre a amostra de teste x e cada amostra de X. Voce
%  devera completar essa funcao.
D = distancia(x, X);

%Obtem o numero de amostras
m = size(X,1); 

%Concatena o atributo-alvo e o indice
concat = horzcat(D, Y, (1:m)');

%Ordena pela distancia
sorted = sortrows(concat, 1);

%Seleciona os K vizinhos mais proximos
selected = sorted(1:K,:);

%Largura da matriz
lar = size(selected, 2);

%Resposta é a moda da penultima coluna
y = mode(selected(:,lar - 1));

%Indices dos vizinhos mais proximos sao a ultima coluna
ind_viz = selected(:,lar); 












% =========================================================================

end