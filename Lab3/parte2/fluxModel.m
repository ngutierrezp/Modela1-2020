function [A, B, C, D] = fluxModel(A2)
    %**** Sistema de control de niveles de vasos comunicantes ****
    % Se quiere modelar las variables de esta de la altura x1 y x2
    % En este modelo se tienen las ecuaciones:
    % (1) V1 = x*A2
    % (2) V2 = x*A2
    % (3) dV1/dt = 0
    % (4) dV2/dt = F1 - F2
    % (5) U = F1
    % (6) F2 = x2
    
    % Esto resulta en las ecuaciones de estado:
    % dx1/dt = 0*x1 + 0*x2 + 0*U
    % dx2/dt = 0*x1 - (1/A2)*x2 + (1/A2)*U
    
    A = [0 0 ;  0  -1/A2];
    B = [0 ; 1/A2];
    C = [1 0 ; 0 1];
    D = [0 ; 0];
end
