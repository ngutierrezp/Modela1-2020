function [valoresX, Err] = secante(x0, x1, iteraciones, tolerancia, f)
    valoresX = [];
    Err = [];
    e = 1;
    %% primera iteracion
    numerador = f(x1)*(x1 - x0);
    denominador = (f(x1) - f(x0));
    xn = x1 - (numerador/denominador);
    x0 = x1;
    x1 = xn;
    valoresX = [valoresX, xn];
    Err = [Err, e];
    %% N iteraciones
    for i = 1 : iteraciones
       if (e < tolerancia)
           return;
       end
       numerador = f(x1)*(x1 - x0);
       denominador = (f(x1) - f(x0));
       xn = x1 - (numerador/denominador);
       %Cambiar error
       e = abs(x1 - x0)/x0;
       x0 = x1;
       x1 = xn;
       valoresX = [valoresX, xn];
       Err = [Err, e];
    end
end