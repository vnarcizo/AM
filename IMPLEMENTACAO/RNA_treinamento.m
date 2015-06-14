function [mTheta1, mTheta2, avaliacao] = RNA_treinamento(aTreinamento,rTreinamento, aTeste,rTeste, numeroParticao,qtdNeuronio,epocas)

%RNA_treinamento Efetua o treinamento da RNA
%   [mTheta1, mTheta2, avaliacao] = RNA_treinamento(aTreinamento,rTreinamento, 
%   ...aTeste,rTeste, numeroParticao,qtdNeuronio,epocas)
%   Efetua o treinamento da rede neural passando como parametro a base de treinamento e seus rotulos
%   a base de Teste e seus Rotulos , qual partição esta sendo realizada o treinamento, a quantidade de neuronios, na camada intermediaria
%   e a quantidade de épocas máxima de treinamento

%Utilizamos somente uma camada intermediária, pois foi comprovada pelo
%Pesquisador CYBENKO que o problema tem a caracteristica da Capacidade de
%aproximação universal, para mais detalhes segue link (Capítulo 2.4.6)
%ftp://ftp.dca.fee.unicamp.br/pub/docs/vonzuben/theses/lnunes_mest/cap2.pdf

   fprintf('\nInício Partição #%d\n', numeroParticao);

   %Inicializa algumas variáveis úteis
   [m,n] = size(aTreinamento);
   
   %Inicicializando os Thetas com valores randômicos                               
   mTheta1 = rand(qtdNeuronio,n + 1);       
   mTheta2 = rand(1,qtdNeuronio + 1);
   
   %Inicicializando a taxa de aprendizagem                             
   txAprendizagem = 0.06;
   
   %Inicicializando o erro auxilizar e a quantidade de épocas já realizadas
   erroAux = 10;
   epocasAux = 0;
       
   fprintf('Efetuando o treinamento da RNA...\n');
   tic;
   %Enquanto o erro form maior que 0.1 e a quantidade de épocas não tenha
   %chego ao limite máximo irá repetir o trexo de código abaixo
   while( erroAux > 0.1 && epocasAux < epocas )
       erroAux = 0;
       
       %Para todas as amostras
       for i = 1:m
        
        %Ao chamar o RNA_forward, passando uma amostra e os tetas correntes
        %mostrará qual foi o rótulo realizado pela predição
        [~, a2, a3] =  RNA_forward(aTreinamento(i,:),mTheta1, mTheta2);
        a1 = [1 aTreinamento(i,:)];
               
        erro = (rTreinamento(i) - a3);
        sigL = a3 *(1 - a3) * erro ;
        
        sigH = (mTheta2' * sigL) .* (a2 .* (1 - a2));
        
        %Calcula o novo Theta basendo no Capítulo 4 (Redes Neurais
        %Artificiais) de Fernando César C. de Castro e Maria Cristina F. de
        %Castro, disponibilizado pelo professor como material de leitura
        %adicional.
        
        %Camada de Saida
        mTheta2 = (mTheta2' + txAprendizagem * sigL * a2)';
        
        %Camada Intermediária
        mTheta1 = bsxfun(@plus,mTheta1 , txAprendizagem * sigH(2:end) * a1);
        
        %Verificando o erro quadratico
        erroAux = erroAux + erro^2;
       end
       
       %Obtendo o erro quadratico médio
       erroAux = erroAux/m;
       
       epocasAux = epocasAux + 1;
       
   end
   
   fprintf('Finalizado o treinamento da RNA...\n');
   tempo = toc;
   fprintf('Tempo de Treinamento: %f\n', tempo);
    
    %Obtendo os rótulos da base de treinamento para comparar com os rótulos
    %reais
    %BASE 
    [mm,~] = size(aTreinamento);
    rotulosTreinamento = zeros(mm,1);
    
    for k = 1 : mm   
          rotulosTreinamento(k) =  RNA_forward(aTreinamento(k,:),mTheta1, mTheta2);
    end
      
    
    %Obtendo os rótulos da base de teste para comparar com os rótulos
    %reais
    %TESTE
    [mm,~] = size(aTeste);
    rotulosTeste = zeros(mm,1);
    
    for k = 1 : mm   
          rotulosTeste(k) =  RNA_forward(aTeste(k,:),mTheta1, mTheta2);
    end
    
    
    %Verificando a Acuracia da base de treinamento
    acuraciaTreinamento = mean(double(rotulosTreinamento == rTreinamento)) * 100;
    fprintf('Acuracia na base de treinamento: %f\n',acuraciaTreinamento );

    %Verificando a Acuracia da base de Teste
    acuraciaTeste = mean(double(rotulosTeste == rTeste)) * 100;
    fprintf('Acuracia na base de teste: %f\n', mean(double(rotulosTeste == rTeste)) * 100);

    %Obtendo as Avaliações do método
    [avaliacao] = avaliar(rotulosTeste, rTeste, tempo);
    
    %save (strcat(num2str(numeroParticao),'_.mat'), 'mTheta1', 'mTheta2', 'acuraciaTreinamento', 'acuraciaTeste')
    fprintf('Fim Partição #%d\n\n', numeroParticao);
end