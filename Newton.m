function [ Solution ] = Newton( func, x_0, tol, maxIt )
    delta = 1e-5;
    df = @(x) ((polyval(func, x+delta) - polyval(func, x))/delta);
     
    if(maxIt < 1)
        disp("WARN: Iteraciones máximas superadas");
        Solution = x_0;
        return;
    end
    Y = x_0 - polyval(func, x_0)/df(x_0);
    err = abs((Y-x_0)/Y);
    %sprintf("INFO: Iteraciones restantes: %d, Actual: %f" , maxIt, Y)
    if(err < tol)
        disp("INFO: El algoritmo converge a una soluciÃ³n") 
        Solution = Y;
        return;
    end
    Solution = Newton( func, Y, tol, maxIt - 1);
end

