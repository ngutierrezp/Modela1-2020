function [ Solution ] = Newton( func, x_0, tol, maxIt )
    delta = 1e-5;
    df = @(x) ((polyval(func, x+delta) - polyval(func, x))/delta);
     
    if(maxIt == 0)
        disp("Maximum iterations reached");
        Solution = x_0;
        return;
    end
    Y = x_0 - polyval(func, x_0)/df(x_0);
    err = abs((Y-x_0)/x_0);
    sprintf("iterations: %d, solution: %f" , maxIt, Y)
    if(err < tol)
        disp("Algorithm has reached a solution by convergence")
        Solution = Y;
        return
    end
    Solution = Newton( func, Y, tol, maxIt - 1);
end

