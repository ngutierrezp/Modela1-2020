%Funcion cholesky
%Resuelve funciones tipo Ax=B de forma directa haciendo cambio A = LLT
%Uso de funcion
%[x,Error,nInstrucciones,tiempo] =cholesky(A,B,iter)
%Parametros de entrada
%   Matriz de funciones -> A
%   Vector inicial -> b 
%Parametros de Salida
%   Valores Resultado -> x
%   Error -> Error
%   Numero total de instrucciones -> nInstrucciones
%   Tiempo de ejecucion -> tiempo

function [x,Error,nInstrucciones,tiempo]=cholesky(A, b)
    [N, M]=size(A);
    nInstrucciones = 0; 
    cholesky_timer = tic;
    %Inicio de iteraciones 
    for k = 1 : N
        A(k,k) = sqrt(A(k,k));
        A(k+1:N,k) = A(k+1:N,k)/A(k,k);
        nInstrucciones = nInstrucciones + 1 + N - (k+1);
        for j = k + 1 : N
            A(j:N,j) = A(j:N,j) - A(j,k)*A(j:N,k);
            nInstrucciones = nInstrucciones + 2*(N-j);
        end
    end
    L = tril(A);
    LT = L';
    %Obtener resultado
    z = inv(L)*b;
    x = inv(LT)*z; 
    tiempo = toc(cholesky_timer);
    Error = norm(eye(N)-inv(L*LT)*A);
    nInstrucciones = nInstrucciones + N*M/2 + 2*N^2;
end