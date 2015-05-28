

aTreinamento = [0,0;
                0,1;
                1,0;
                1,1];
            
rTreinamento = [0,1,1,0]';
           
           
aTeste = [0,0;0,1;1,0;1,1];

rTeste = [0,1,1,0]';

qtdNeuronio = 2;

[mTheta1, mTheta2, mTeste] = RNA_treinamento(aTreinamento,rTreinamento,qtdNeuronio,400000, aTeste,rTeste);

fprintf( 'Para %d %d : %d\n', 0,0,RNA_forward([0 0],mTheta1, mTheta2))
fprintf( 'Para %d %d : %d\n', 0,1,RNA_forward([0 1],mTheta1, mTheta2))
fprintf( 'Para %d %d : %d\n', 1,0,RNA_forward([1 0],mTheta1, mTheta2))
fprintf( 'Para %d %d : %d\n', 1,1,RNA_forward([1 1],mTheta1, mTheta2))