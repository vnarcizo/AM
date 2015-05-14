function [mTheta1, mTheta2, mTeste] = RNA_treinamento(mTreinamento,qtdNeuronio, mTeste)

       %Inicicializando os Thetas com valores randômicos                               
       mTheta1 = rand(size(mTreinamento,2),qtdNeuronio);                               
       mTheta2 = rand(1,size(mTheta1,2) + 1);
       
       mTreinamento = mTreinamento';
       
       delta = 0;
       
       for i = 1:size(mTreinamento,1)
           
        [saida, a2, a3] =  RNA_forward(mTreinamento(i:2),mTheta1, mTheta2);
        
        sig3 = a3 - mTreinamento(size(mTreinamento,1),1);
        
        delta  = delta + sig3*a3;
        
        delta  = delta + sig3*a3;
           
       end
       
       
       %  Definicao das opcoes para fminunc
       opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

        %  Executa fminunc para encontrar o theta otimo
        %  A funcao retornara theta e o custo 
        [theta, custo] = fminunc(@(t)(funcaoCusto(t, X, y)), theta_inicial, opcoes);


end