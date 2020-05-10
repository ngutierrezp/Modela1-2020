function [ Solution ] = Newton( func, x_0, tol, maxIt )
    delta = 1e-5;
    df = @(x) ((func(x+delta) - func(x))/delta);
     
    if(maxIt == 0)
        disp("Maximum iterations reached");
        Solution = x_0;
        return;
    end
    Y = x_0 - func(x_0)/df(x_0);
    err = abs(func(Y-x_0)/x_0);
    sprintf("iteration: %d, solution: %f, error: %f" , maxIt, Y ,err)
    if(err < tol)
        disp("Algorithm has reached a solution by convergence")
        Solution = Y;
        return
    end
    Solution = Newton( func, Y, tol, maxIt - 1);
end

