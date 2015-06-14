function [y, a2, a3] = RNA_forward(x,mTheta1, mTheta2)

%RNA_treinamento Obtem a predição do rótulo através dos Thetas
%   [y, a2, a3] = RNA_forward(x,mTheta1, mTheta2)
%   Obtem o rótulo passando como parametro a amostra que deseja obter e os
%   Thetas para o cálculo, retornará o y como saida da rede e os valores
%   intermediários a2 e a3

   a1 = x';
   
   a1 = [1 a1(1:end)']';
   z2 = mTheta1 * a1;
   
   %função sigmoid
   a2 =  1 ./ ( 1 + exp(-z2));
   
   %Adicionando o Bias 
   a2 = [1 a2(1:end)']';
   
   
   z3 = mTheta2 * a2;
   
   %calculando a saida
   a3 =  1 ./ ( 1 + exp(-z3));
   
   
   y = a3 >= 0.5;
   
end