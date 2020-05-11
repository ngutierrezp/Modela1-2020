function [soluciones, errores,iteraciones,tiempo] = gaussJacobi(A, b, tol,iter)
    [M N] = size(A);
    D = zeros(M, N);
    E = zeros(M, N);
    F = zeros(M, N);
    iteraciones=0;
    aux = 1;
    jacobi_timer = tic;
    for i = 1 : M
       D(i, i) = A(i, i);
       for j = 1 : aux
          E(i, j) = A(i, j); 
          F(j, i) = A(j, i);
          iteraciones=iteraciones+1;
       end
       E(i, i) = 0;
       F(i, i) = 0;
       aux = aux + 1;
       iteraciones=iteraciones+5;
    end
    x0 = zeros(N ,1);
    soluciones = [];
    errores = [];
    for i = 1 : iter
       j = inv(D)*(-E-F);
       c = inv(D) * b;
       x1 = j*x0 + c;
       e = norm(x1 - x0, inf)/norm(x1, inf);
       soluciones = [soluciones, x1];
       errores = [errores, e];
       if(e < tol)
           return;
       end
       x0 = x1;
       iteraciones=iteraciones+1;
    end
    xs = x1;
    tiempo=toc(jacobi_timer);
end