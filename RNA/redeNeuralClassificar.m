function [ saida, A1, A2, A3 ] = redeNeuralClassificar(entrada, theta )

    theta1 = cat(2, theta(:,1), theta(:,2));
    theta2 = cat(2, theta(:,3), theta(:,4));
    theta3 = theta(:,5);
    A0 = [1, entrada];
    A1 = [1, sigmf(A0*theta1, [1 0])];
    A2 = [1, sigmf(A1*theta2, [1 0])];
    A3 = sigmf(A2*theta3, [1 0]);
    saida=A3;
    saida(saida>=0.5)=1;
    saida(saida<0.5)=0;
end