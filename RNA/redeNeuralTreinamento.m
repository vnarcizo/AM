function [ theta1, theta2, theta3 ] = redeNeuralTreinamento( entrada, saida )

    nn = 2;
    
    theta1 = rand(size(entrada, 2)+1, nn);
    theta2 = rand(nn+1, nn);
    theta3 = rand(nn+1, size(saida,2));
    
    lambda = 1;
    
    opcoes = optimset('GradObj', 'on', 'MaxIter', 400, 'Display', 'off');
    [theta] = fminunc(@(t)(RNA_costFunction(t, entrada, saida, lambda, 1)), [theta1 theta2 theta3], opcoes);
    theta1 = cat(2, theta(:,1), theta(:,2));
    theta2 = cat(2, theta(:,3), theta(:,4));
    theta3 = theta(:,5);
end