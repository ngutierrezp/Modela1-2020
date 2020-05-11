
%Resuelve funciones tipo Ax=B de forma directa haciendo cambio A = QR

function [x,Error,nInstrucciones,tiempo]=QR(A,b)
    nInstrucciones = 0;
    [m,n]=size(A);
    if m<n
       return
    end
    grandSchmidt_timer = tic;
    Q=A;
    R=zeros(n);
    for k=1:m
        for i=1:k-1
              R(i,k)=Q(:,i)'*A(:,k);
              Q(:,k)=Q(:,k)-Q(:,i)*R(i,k);
              nInstrucciones = nInstrucciones + 3*n;
        end
        R(k,k) = norm(Q(:,k));
        Q(:,k)=Q(:,k)/R(k,k);
        nInstrucciones = nInstrucciones + 4 + 2*m;
    end 
    %Obtener resultado
    z = inv(Q)*b;
    x = inv(R)*z; 
    tiempo = toc(grandSchmidt_timer);
    Error = norm(eye(m)-inv(Q*R)*A);
    nInstrucciones = nInstrucciones + 2*m^2;
end