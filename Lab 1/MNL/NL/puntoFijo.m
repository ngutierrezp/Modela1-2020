function [valores,Errores] = puntoFijo(f,df,tolerancia,iter,x0)
valores = [x0];
Errores = [];

 if(abs(df(x0))>=1)
     disp('la funcion contractiva no es apropiada')
     return;
 end
 
 x=f(x0);
 e=abs(x-x0);
 valores=[valores,x];
 Errores=[Errores,e];
 for i=1:iter
     if(e < tolerancia)
         return;
     end
     xn=f(x);
     e=abs((xn-x)/xn);
     valores=[valores,xn];
     Errores=[Errores,e];
     x=xn;
 end
     
     
     
     
     
 
 
 
