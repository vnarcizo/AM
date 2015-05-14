function [saida, a2, a3] = RNA_forward(x,mTheta1, mTheta2)

   a1 = x';
   z2 = mTheta1 * a1;

   %Adicionando o Bias 
   a2 = [1 z2(1:end)']';
   
   %função sigmoid
   a2 =  1 ./ ( 1 + exp(-a2));
   
   z3 = mTheta2 * a2;
   
   %calculando a saida
   a3 =  1 ./ ( 1 + exp(-z3));
   
   if(a3 > 0.5)
       saida = 1;
   else
       saida = 0;
end