% Esta función supone que se tiene dos funciones de transferencia de la
% forma:

% H(s)=         a
%            --------
%             b*s + c

% Ademas se supone que la función 2 entra como realimentación.

%
%   U       *---*          *-------*      x1             Y
%     ----->|+  | -------->|  H(s) |-----------*---------> 
%           | - |          *-------*           |
%           *-^-*                              | 
%             |                                |
%             |   x2      *-------*            | 
%             *-----------|  G(s) |<-----------* 
%                         *-------*


function [matrix, vectorY] =  tf_to_ms(num1,den1,num2,den2)

    
    if num1(1) ~= 0 ||  num2(1) ~= 0
        disp("No se puede operar con funciones de transfernecia de orden 1 en el numerador")
        return
    end
    
    
    % Se puede describir x1 y x2 de la forma:
     
    %  x1 = H(s)* (U  - x2)
    %  x2 = G(s)* x1
    
    % Con este se puede suponer que existe un vector [ x1 , x2 , U]
    % el cual esta ultiplicando a las funcioens de transferencia
    
    % Entonces si se expresa lo anterior en forma de un vector se tiene:
    
    % [1 0 0] = H(s)* [0 -1 1]  // lo que equivale a x1
    % [0 1 0] = G(s)* [1 0 0]  // lo que equivale a x2 
    
    vectorX1 = [1 0 0];
    vectorX2 = [0 1 0];
    
    vectorHs = [0 -1 1];
    vectorGs = [1 0 0];
    
    
    
    % Como una funcion de transferencia tiene numerador y denominador se
    % tiene: 
    
    %              [0 a]
    %    H(s) =   -------
    %              [b c]
    
    % La forma facil de trabajar es que b tome el valor de 1 por lo cual es
    % posible dividir toda la fracción por b:
    
    num1 = num1 / den1(1);
    den1 = den1 / den1(1);
    
    num2 = num2 / den2(1);
    den2 = den2 / den2(1);
    
    
    % Luego, para x1 se tiene :
    
    % [1 0 0]*[1 c/b] = [0 a/b]* [0 -1 1]
    % X'1 =  [0 a/b]* [0 -1 1] + [-1 0 0] * [c/b]
    vectorX_1 = sum(num1).*vectorHs + den1(2)*-vectorX1;
    
    % para x2 se tiene :
    
    % [0 1 0]*[1 c/b] = [0 a/b]* [1 0 0]
    % X'2 =  [0 a/b]* [1 0 0] + [0 -1 0] * [c/b]
    
    
    vectorX_2 = sum(num2).*vectorGs + den2(2)*-vectorX2;
    
    % Ahora si se juntan estos dos vectores se tendra una matriz que
    % representa el modelo de estados de forma matricial
    
    
    %           A           B
    %       *-------*       | 
    %       |       |       |
    %       v       v       v
    
    %  |  -c/b    -a/b    a/b   |
    %  |   a/b    -c/b     0    |
    
    % con esta matriz se puede expresar de la forma: 
    % X'i = A*xi + B*u
    
    matrix = [vectorX_1;vectorX_2];
    
    
    % Del diagrama se puede ver que el valor de Y es el mismo que el de x1
    % por lo tanto el vector Y sera [1 0]
    
    vectorY = [1 0];

end