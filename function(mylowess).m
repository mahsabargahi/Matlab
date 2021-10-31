function [yhat] = mylowess(x,y,tau)
    n = length(y);
    yhat = zeros(n,1);
    W = eye(n);
    x = [x,ones(n,1)];
    for j = 1:n
        for i = 1:n
            W(i,i) = exp(-(x(i,:) - x(j,:))*(x(i,:)-x(j,:))'/(2*tau*tau));
        end
        theta = pinv(x'*(W*x))*((x'*W)*y);
        yhat(j) = [x(j,1:end-1),1]*theta;
    end
end
