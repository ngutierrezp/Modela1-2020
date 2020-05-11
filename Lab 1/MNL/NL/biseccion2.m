%Aunque el procedimiento se aplica en el caso en que f (a) y f (b) tengan signos diferentes y
%exista m´as de una ra´?z en el intervalo (a, b) , por razones de simplicidad suponemos que la ra´?z
%de este intervalo es ´unica. El m´etodo requiere dividir varias veces en la mitad los subintervalos
%de [a, b] y en cada paso localizar aquella mitad que contenga a la ra´?z r . Para comenzar
%consideremos a0 = a y b0 = b , y sea c0 el punto medio de [a, b] , es decir, c0 = a0+b0
%2 . Si
%f (c0) = 0 , entonces r = c0 ; si no, entonces f (c0) posee el mismo signo que f (a0) o que
%f (b0) . Si f (c0) y f (a0) tienen igual signo, entonces r ? (c0, b0) y tomamos a1 = c0 y
%b1 = b0 . Si f (c0) y f (a0) tienen signos opuestos, entonces r ? (a0, c0) y tomamos a1 = a0
%y b1 = c0 . Enseguida, volvemos a aplicar el proceso al intervalo [a1, b1] , y as´? sucesivamente

function [error, iteracionesTotal, raiz, iteraciones, funcionCn, valoresC, matriz] = biseccion(funcion,tolerancia, a, b)
    valoresA=[];
    valoresB=[];
    valoresC=[];
    iteraciones =[];
    funcionCn=[];
    
    cotaA=a;
    cotaB=b;
    media = (cotaA+cotaB)/2;
    error = abs(funcion(media));
    i=1;    
    valoresA=[valoresA; cotaA];
    valoresB=[valoresB; cotaB];
    valoresC= [valoresC; media];    
    iteraciones=[iteraciones; i];    
    funcionCn=[funcionCn; funcion(media)];
    
    while error > tolerancia
        if funcion(media)*funcion(cotaA) >0 % es decir, tienen el mismo signo
            cotaA= media;
        else 
            cotaB =media;
        end
        media= (cotaA+cotaB)/2;        
        error = abs(funcion(media));
        i= i+1;
        valoresA=[valoresA; cotaA];
        valoresB=[valoresB; cotaB];
        valoresC =[valoresC; media];
        iteraciones=[iteraciones; i];
        funcionCn=[funcionCn; funcion(media)];
    end
    raiz = media;
    matriz=[iteraciones, valoresA, valoresB, valoresC, funcionCn];
    iteracionesTotal = i;
end