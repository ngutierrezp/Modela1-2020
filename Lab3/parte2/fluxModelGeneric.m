function [A, B, C, D] = fluxModelGeneric(r1, r2, A1, A2)
    %**** Sistema de control de niveles de vasos comunicantes ****
    % Se quiere modelar las variables de esta de la altura x1 y x2
    % En el modelo genérico, se tienen las ecuaciones:
    % (1) V1 = x*A1
    % (2) V2 = x*A2
    % (3) dV1/dt = F0 - F1
    % (4) dV2/dt = F1 - F2
    % (5) F1 = (x1 - x2)/r1
    % (6) F2 = x2/r2
    
    % Esto resulta en las ecuaciones de estado:
    % dx1/dt = - x1/(A1*r1) + x2/(A1*r1) + (1/A1)*F0
    % dx2/dt = x1/(A2*r1) - x2/(A2*(r1+r2)) + 0*F0
    
    A = [-1/(A1*r1)  1/(A1*r1) ;  1/(A2*r1)  -1/(A2*(r1+r2)) ];
    B = [1/A1 ; 0];
    C = [1 0 ; 0 1];
    D = [0 ; 0];
end
