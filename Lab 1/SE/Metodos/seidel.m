%Funcion Seidel
%Resuelve funciones tipo Ax=B de forma iterativa
%Uso de funcion
%[ValoresR,Errores,nInstrucciones,tiempo] =seidel(A,B,iter)
%Parametros de entrada
%   Matriz de funciones -> A
%   Vector inicial -> b
%   Numero maximo de iteraciones ->iter
%Parametros de Salida
%   Valores Resultado -> ValoresR
%   Error por iteracion -> Errores
%   Numero total de instrucciones -> nInstrucciones
%   Tiempo de ejecucion -> tiempo

function[ValoresR,Errores,nInstrucciones,tiempo] =seidel(A,B, iter)
    nInstrucciones = 0;
    Errores(1)=1;
    IteracionesMinimas = 5;
    largo = length(B);

    cantidadFunc=length(B);
    vectorResultados=[]; 
    Suma=0;
    ValoresR=[];
    Aux = [];
    
    seidel_timer = tic;
    X = zeros(1,cantidadFunc)';
     for p=1:iter
        for i=1:cantidadFunc
           for j=1:i-1 
                 Suma=Suma + A(i,j)*X(j);
                 nInstrucciones = nInstrucciones + 2;
           end
           for j=i+1:cantidadFunc %lengt
                 Suma= Suma + A(i,j)*X(j);
                 nInstrucciones = nInstrucciones + 2;
           end
           Suma=  (B(i)-Suma)/A(i,i);
           X(i)=Suma;
           Suma=0;
           nInstrucciones = nInstrucciones + 2;
        end
        ValoresR= [ValoresR,X];
        %Error
        if(p>1)
            errorActual = norm((X-ValoresR(:,end-1)))/norm(X); 
            if(errorActual~=0)
                Errores(p) = errorActual;
            end
        end
        %Verificar casos de salida
        if(p>IteracionesMinimas)
            sonSimilares = 1;
            for z=1:cantidadFunc 
                if(sonSimilares == 1 && var(ValoresR(z,end-IteracionesMinimas:end))~=0)
                    sonSimilares = 0;
                end
            end
            if(sonSimilares==1 || var(Errores(end-IteracionesMinimas:end))==0)
                ValoresR = ValoresR';
                tiempo = toc(seidel_timer); 
                return;
            end
        end
     end
     ValoresR =ValoresR';
     tiempo = toc(seidel_timer);
     return;
end   