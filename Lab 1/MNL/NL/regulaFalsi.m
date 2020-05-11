function [Valores, Errores] = regulaFalsi(a, b, iter, tolerancia, f)
Errores = [];
Valores = [];
e = 1;
    for iteracion = 1 : iter
        xi = a - (f(a) * (b - a))/(f(b) - f(a));
                
        if(e < tolerancia)
            return;
        end
        
        Valores = [Valores, xi];
        Errores = [Errores, e];
        
        if (f(a) * f(xi) >= 0)
            e = (a - xi) / a;
            a = xi; 
        else
            e = (b - xi) / b;
            b = xi;
        end
    end
end