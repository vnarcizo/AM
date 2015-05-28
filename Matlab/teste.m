

mTreinamento = [
                0,0,0;
                0,1,1;
                1,0,1;
                1,1,0
               ];
mTeste = [0,0;0,1;1,0;1,1];

qtdNeuronio = 10;

[mTheta1, mTheta2, mTeste] = RNA_treinamento(mTreinamento,qtdNeuronio,4000, mTeste);

fprintf( 'Para %d %d : %d\n', 0,0,RNA_forward([0 0],mTheta1, mTheta2))
fprintf( 'Para %d %d : %d\n', 0,1,RNA_forward([0 1],mTheta1, mTheta2))
fprintf( 'Para %d %d : %d\n', 1,0,RNA_forward([1 0],mTheta1, mTheta2))
fprintf( 'Para %d %d : %d\n', 1,1,RNA_forward([1 1],mTheta1, mTheta2))