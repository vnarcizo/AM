function [mTheta1, mTheta2, avaliacao] = RNA_treinamento(aTreinamento,rTreinamento, aTeste,rTeste, numeroParticao,qtdNeuronio,epocas)
      
fprintf('\nInício Partição #%d\n', numeroParticao);

   [m,n] = size(aTreinamento);
   
   %Inicicializando os Thetas com valores randômicos                               
   mTheta1 = rand(qtdNeuronio,n + 1);       
   mTheta2 = rand(1,qtdNeuronio + 1);
   txAprendizagem = 0.06;
   
   erroAux = 10;
   epocasAux = 0;
       
   fprintf('Efetuando o treinamento da RNA...\n');
   tic;
   while( erroAux > 0.1 && epocasAux < epocas )
       erroAux = 0;
       for i = 1:m
           
        [~, a2, a3] =  RNA_forward(aTreinamento(i,:),mTheta1, mTheta2);
        a1 = [1 aTreinamento(i,:)];
               
        erro = (rTreinamento(i) - a3);
        sigL = a3 *(1 - a3) * erro ;
        
        sigH = (mTheta2' * sigL) .* (a2 .* (1 - a2));
        
        mTheta2 = (mTheta2' + txAprendizagem * sigL * a2)';
        mTheta1 = bsxfun(@plus,mTheta1 , txAprendizagem * sigH(2:end) * a1);
        erroAux = erroAux + erro^2;
       end
       
       erroAux = erroAux/m;
       %fprintf( 'Epoca %d -> Erro %d\n',epocasAux, erroAux);
       epocasAux = epocasAux + 1;
       
   end
   
   fprintf('Finalizado o treinamento da RNA...\n');
   fprintf('Tempo de Treinamento: %f\n', toc);
    
   %BASE 
    [mm,~] = size(aTreinamento);
    rotulosTreinamento = zeros(mm,1);
    
    for k = 1 : mm   
          rotulosTreinamento(k) =  RNA_forward(aTreinamento(k,:),mTheta1, mTheta2);
    end
      
    %TESTE
    [mm,~] = size(aTeste);
    rotulosTeste = zeros(mm,1);
    
    for k = 1 : mm   
          rotulosTeste(k) =  RNA_forward(aTeste(k,:),mTheta1, mTheta2);
    end
    
    acuraciaTreinamento = mean(double(rotulosTreinamento == rTreinamento)) * 100;
    fprintf('Acuracia na base de treinamento: %f\n',acuraciaTreinamento );

    acuraciaTeste = mean(double(rotulosTeste == rTeste)) * 100;
    fprintf('Acuracia na base de teste: %f\n', mean(double(rotulosTeste == rTeste)) * 100);

    [avaliacao] = avaliar(rotulosTeste, rTeste);
    
    %save (strcat(num2str(numeroParticao),'_.mat'), 'mTheta1', 'mTheta2', 'acuraciaTreinamento', 'acuraciaTeste')
    fprintf('Fim Partição #%d\n\n', numeroParticao);
end