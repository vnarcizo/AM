function [mTheta1, mTheta2, mTeste] = RNA_treinamento(mTreinamento,qtdNeuronio,epocas, mTeste)

       %Inicicializando os Thetas com valores randômicos                               
       mTheta1 = rand(qtdNeuronio,size(mTreinamento,2));       
       mTheta2 = rand(1,qtdNeuronio + 1);
       alpha = 0.1;
       
       [m,n] = size(mTreinamento);

    for k = 1 : epocas   
       for i = 1:m
           
        [~, a2, a3] =  RNA_forward(mTreinamento(i:i,1:(n-1)),mTheta1, mTheta2);
        a1 = [1 mTreinamento(i:i,1:(n-1))];
                
        sigL = a3 *(1 - a3)*(mTreinamento(i,end) - a3) ;
        
        sigH = (mTheta2' * sigL) .* (a2 .* (1 - a2));
        
        mTheta2 = (mTheta2' + alpha * sigL * a2)';
        mTheta1 = bsxfun(@plus,mTheta1 , alpha * sigH(2:end) * a1);
        
       end
    end
    
    [mm,nn] = size(mTeste);
    %Coloca uma coluna de zeros no final da matriz
    mTeste = cat(2,mTeste, zeros(1,size(mTeste,1))');
    
    
    for k = 1 : mm   
        
          mTeste(k,end) =  RNA_forward(mTeste(k:k,1:nn),mTheta1, mTheta2);
        
    end
end