% Metodo de bisección %
% Tolerancia  =

function [ValoresR,Errores] = biseccion(a,b,f,iter,tolerancia)
 ValoresR=[];
 Errores =[];
 e=1;
 %Tiempo =0;
 %% comprobaciones de entrada : %%
 %  debemos determinar que f(a)*f(b) es menor a 0 (difernetes signos)
if f(a)*f(b)>0
    disp('a y b con igual signo')
    return
end
%TiempoInicial= tic;
for i=1:iter
   c = (a + b ) / 2; % Costo = 1 suma + 1 division.

   ValoresR =[ValoresR, c]; 
  
   e = abs((b-a)/2);
   Errores = [Errores,e];  % Costo = 1 resta + 1 division.
       
   if (tolerancia > e )
      return;
   end
       
   if f(c) == 0
        %Tiempo = toc(TiempoInicial);
        return
   else     
        if f(a)*f(c)<0
            b = c;
        else      
            a = c;
        end
    end
end
%Tiempo = toc(TiempoInicial);
end