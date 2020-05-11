
function [resultados,errores,tiempo,nInstrucciones]= newtonRapshonMulti(sistemaFunc,variables,x0,iter,tolerancia)
    num_funciones = length(sistemaFunc);
    num_variables = length(variables);
    
    resultados=[];
    errores=[];
    tiempo=0;
    nInstrucciones=0;
    
    if num_funciones ~= num_variables 
        disp('Hacen falta parametros para resolver las ecuaciones')
    end
    inicio=tic;
    %% calculo de jacobiano manual
    for filas=1:1:num_funciones
        for columnas=1:1:num_funciones
            %Para poder hacer el calculo 100% manual, es necesario
            %sustituir la funcion diff por una funcion propia para derivar
            jacobiano(filas,columnas)=diff(sistemaFunc(filas),variables(columnas));
        end
    end
    resultados=[resultados;x0];
    errores=[errores,1];
    nInstrucciones=nInstrucciones *(num_funciones^2);
    for iteracion=1:1:iter
        %evaluacion de funciones:
        J_evaluado= eval(subs(jacobiano,[variables],[x0]));
        F_evaluado= eval(subs(sistemaFunc,[variables],[x0]));
        
        
        valor0 = J_evaluado/(-F_evaluado);
        valor1 = x0+(valor0');
        error=abs((valor1-x0)/(valor1));
        resultados=[resultados; valor1];
        errores=[errores,error];
        
        if error < tolerancia
            return;
        end
        
        nInstrucciones=nInstrucciones+3;
        x0=valor1;
        
    end
    tiempo=toc(inicio);
end



