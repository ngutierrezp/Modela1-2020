%Funcion crout
%Resuelve funciones tipo Ax=B de forma directa haciendo cambio A = LU
%Uso de funcion
%[x,Error,nInstrucciones,tiempo] =crout(A,B,iter)
%Parametros de entrada
%   Matriz de funciones -> A
%   Vector inicial -> b 
%Parametros de Salida
%   Valores Resultado -> x
%   Error -> Error
%   Numero total de instrucciones -> nInstrucciones
%   Tiempo de ejecucion -> tiempo

function [x,Error,nInstrucciones,tiempo] = doolittle(A,b)
    [largo,ancho] = size(A);
    %Si el largo es distinto del ancho entonces no 
    if(largo~=ancho)
        disp('La matriz no es cuadrada')
        return;
    end
    %Definir matrices triangular superior U y triangular inferior L
    L = zeros(largo,ancho);
    U = zeros(largo,ancho);
    nInstrucciones = 0;
    doolittle_timer = tic;
     %Definir valores para U y L 
    for k = 1:largo
        L(k, k) = 1;
        for i = k + 1: largo
            L(i,k) = A(i,k) / A(k,k);
            nInstrucciones = nInstrucciones + 1;
            for j = k + 1 : largo
                A(i,j) = A(i,j) - L(i,k)*A(k,j);
                nInstrucciones = nInstrucciones + 2;
            end
        end
        for j = k : largo
            U(k,j) = A(k,j);
        end
    end 
    % L*y = b' /(Inv(L)) -> y = Inv(L)*b'
    y = inv(L)*b;
    % U*x = y /(Inv(L)) -> x = inv(U)*y
    x = inv(U)*y;
    %Orden operacional de inv(x) = lenght(x)^2
    tiempo = toc(doolittle_timer);
    nInstrucciones = nInstrucciones + 2*largo^2;
    Error = norm(eye(largo)-inv(L*U)*A);
end