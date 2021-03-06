function [ saida, A1, A2 ] = redeNeuralClassificar(entrada, theta )

    theta1 = cat(2, theta(:,1), theta(:,2));
    theta2 = theta(:,3);
    A0 = [1, entrada];
    A1 = [1, sigmf(A0*theta1, [1 0])];
    A2 = sigmf(A1*theta2, [1 0]);
    saida=A2;
    saida(saida>=0.5)=1;
    saida(saida<0.5)=0;
end