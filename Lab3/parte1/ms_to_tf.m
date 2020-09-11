% Esta función recibe una matriz y un vector Y de la forma:


    %           A           B
    %       *-------*       | 
    %       |       |       |
    %       v       v       v
    
    %  |  -c/b    -a/b    a/b   |
    %  |   a/b    -c/b     0    |

    
    
    % Y = [x1 x2]
    
% Esta función lleva de un modelo de estados a funciones de transferencia
% solo para funciones de la forma:

% H(s)=         a/b
%            --------
%             s + c/b

function [num1,den1,num2,den2] = ms_to_tf(matrix,vectorY)


    matrixA = matrix(:,[1,2]);
    
    % se puede notar que la matriz de entrada tiene los valores de las
    % funciones de transferencia de forma implicita por lo que :
    
    VectorHS = matrixA(1,:);
    VectorHS = -VectorHS*sum(vectorY);
    
    num1 = [0 VectorHS(2)];
    den1 = [1 VectorHS(1)];
    
    
    
    
    VectorGS = matrixA(2,:);
    VectorGS = [1 -1].* VectorGS*sum(vectorY);
    
    
    num2 = [0 VectorGS(1)];
    den2 = [1 VectorGS(2)];
    
    


end

