function [ out ] = RL_expandeAtributosPolinomial( input, grau )

%% Efetua a expansão dos atributos polinomiais
%  [ out ] = RL_expandeAtributosPolinomial( input, grau )                   


larguraAtributos = size(input, 2);
out = ones(size(input ,1), (grau * larguraAtributos) + 1);

for i = 1:grau
    index = 2 + (larguraAtributos * (i-1));
    out(:,index:(index + larguraAtributos - 1)) = bsxfun(@power, input, i);
end

end

