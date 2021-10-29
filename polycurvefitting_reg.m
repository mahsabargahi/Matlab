function [theta,intercept] = polycurvefitting_reg(X,y,dim,lambda,app)
    num_d = length(X);
    v_m = ones(num_d,dim);
    for i = 1:dim
        v_m(:,i) = X.^(dim-i);
    end
    if app=='Ridge'
        theta = ((v_m'*v_m)+lambda*eye(dim))\v_m'*y';
        intercept = 0;
    elseif app=='Lasso'
        [theta,FitInfo] = lasso(v_m,y','Lambda',lambda);
        intercept = FitInfo.Intercept;
    end
end