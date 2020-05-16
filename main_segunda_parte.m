bool = true;
while bool
    disp("Ingrese una funci�n como polinomio, cada numero debe ir separado por espacio")
    textVector = input('ingresa un vector: ','s');
    lengthUserVector = length(split(textVector,' '));

    str = textscan( textVector, '%s', 'Delimiter',' ' ); % get scan only numbers
    str = permute( str{1}, [2,1] ); % convert to vector
    num = textscan( textVector, '%n', 'Delimiter','\t' ); % get scan only numbers
    num = permute( num{1}, [2,1] ); % convert to vector
    poly = num(~isnan(num)); % remove nan values

     if length(str) > length(poly)
         disp("Por favor ingrese un vector numerico valido separado por espacios")
     else
         bool = false;
     end
end
bool = true;
while bool
    x_0 = str2double(input('Ingrese el valor inicial del algoritmo: ', 's'));
    if(isnan(x_0))
        disp("Ingrese un valor num�rico")
    else
        bool = false;
    end
end
bool = true;
while bool
    tol = str2double(input('Ingrese la tolerancia del error: ', 's'));
    if(isnan(tol))
        disp("Ingrese un valor num�rico")
    else
        bool = false;
    end
end
bool = true;
while bool
    iter = str2num(input('Ingrese numero m�ximo de iteraciones: ', 's'));
    if(isempty(iter) || iter <= 0)
        disp("Ingrese un valor num�rico entero")
    else
        bool = false;
    end
end
res = Newton(poly, x_0, tol, iter);
sprintf("The solution is: %f", res);