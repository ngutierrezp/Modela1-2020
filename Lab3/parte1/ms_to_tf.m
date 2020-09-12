% Esta función recibe 4 matrices y un vector Y de la forma:


    %           A            B
    %       *-------*        | 
    %       |       |        |
    %       v       v        v
    
    %  |  -c/b    -a/b  | | a/b   |
    %  |   a/b    -c/b  | |  0    |

    % C = [x1 x2]
    
    % D = 0
    
% Esta función lleva de un modelo de estados a funciones de transferencia
% solo para funciones de la forma:

%                  H(s)
%            ---------------
%             1 + H(s)*G(s)

function [num,den] = ms_to_tf(A,B,C,D)

    % Se debe tener en cuenta que las variables de estados estan
    % representadas de las forma:
    
    %  X' = A*X + B*U
    %  Y = C*X + D*U
    
    % entonces: 
    %
    
    % sX = A*X+B*U
    % sX - AX  = B*U
    % (sI - A)X  = B*U
    % X = (sI - A)^-1 * B*U 
    
    % Luego :
    
    % Y = C * ((sI - A)^-1 * B*U ) + D*U
    % Y / U = (sI - A)^-1 * B + D
    % Hs = (sI - A)^-1 * B + D
    
    
    % se define una varible s
    syms s;
    
    % Matriz identidad
    I = eye(2);
    
    
    x = s*I - A;
    
    x = inv(x) * B;
    
    Hs = C * x + D;
    
    [num,den]= numden(Hs);

     num = sym2poly(num);
     den = sym2poly(den);
    
end

