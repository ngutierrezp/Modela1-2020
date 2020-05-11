function [valores, errores] = newtonRaphson(f,df,iter,tolerancia,x0)

    valores=[x0];
    errores=[];
    e=1;
    
    for i=1:iter
        if (e < tolerancia)
            return;
        end
        xn=x0-(f(x0)/df(x0));
        valores=[valores,xn];
        e= abs((x0-xn)/x0);
        errores=[errores,e];
        x0=xn;
    end
        
    
