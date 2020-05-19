
function [] = sqrtActivity()
    bool = true;
    disp("Ingresa un vector numérico a continuación, cada numero debe ir separado por espacio")
    disp("Debe ingresar más de 4 elementos")

    while(bool)
        
        textVector = input("ingresa un vector a : ",'s');

        str = textscan( textVector, '%s', 'Delimiter',' ' ); % get scan only strings
        str = permute( str{1}, [2,1] ); % convert to vector

        num = textscan( textVector, '%n', 'Delimiter','\t' ); % get scan only numbers
        num = permute( num{1}, [2,1] ); % convert to vector

        num = num(~isnan(num)); % remove nan values
        
        if length(str) > length(num)
            disp("Por favor ingrese un vector numérico valido separado por espacios")
        elseif length(num) < 4
            disp("Por favor ingrese 4 o más números")        
        else
            bool = false;
        end

    end
    
    maxs = maxk(num,4);

    mins = mink(num,4);

    vector_logical_min = mins < 0;

   if sum(vector_logical_min) > 0
       disp("Los valores ingresados no pueden ser negativos")
       return 
   else
       result = sqrt(sum(maxs)) - sum(sqrt(mins));
       disp ( ['el resultado es : ' , num2str(result)] )

   end
end
    
    
    






