%################################################
%#                  Primera Parte               #
%################################################

disp("#################################################")
disp("Primera parte")


bool = true;
while bool
    disp("Ingresa una función como polinomio, cada numero debe ir separado por espacio")
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
tol = 1e-7;
x_0 = 7;

res = Newton(poly, x_0, tol, 20);
sprintf("The solution is: %f", res);

disp("[OK]")


%################################################
%#                  Segunda Parte               #
%################################################

disp("#################################################")
disp("Segunda parte")

sqrtActivity()

disp("[OK]")






