%% importación de bibliotecas
addpath('../NL/','./NLG','../NLS/');


%% Espacio de definicion de funciones : metodos  no lineales


%funcion 1:
F1 = @(x) 2*x - 2^(-x);
derivadaF1 = @(x) 2^(-x)*log(2)+2;
contractivaF1 = @(x) 1/(2^(x+1));
DcontractivaF1=@(x) -2^(-x-1)*log(2);

%funcion 2:
F2= @(x) x^3 -7*x^2+14*x -2;
derivadaF2 = @(x) 3*x^2-14*x+14;
contractivaF2= @(x) -((x^3)/7)+((x^2)/2)+(1/7);
DcontractivaF2 = @(x) x - (3*x^2)/7;


%%%%%% METODOS PARA PRIMERA FUNCION %%%%%%

%METODO 1: BISECCION
[valoresB,erroresB]=biseccion(-5,10,F1,10000,10^-15);
%METODO 2: SECANTE
[valoresS, erroresS]=secante(-5,10,1000,10^-15,F1);
%METODO 3: REGULA FALSI
[valoresRF,erroresRF]=regulaFalsi(-5,10,10000,10^-15,F1);
%METODO 4: PUNTO FIJO
[valoresPF,erroresPF]=puntoFijo(contractivaF1,DcontractivaF1,10^-15,100,2);
%METODO 5: NEWTON 
[valoresNR,erroresNR]=newtonRaphson(F1,derivadaF1,10000,10^-15,-5);



%%%%%% METODOS PARA SEGUNDA FUNCION %%%%%%

%METODO 1: BISECCION
[valoresB2,erroresB2]=biseccion(-5,10,F2,10000,10^-15);
%METODO 2: SECANTE
[valoresS2, erroresS2]=secante(-5,10,1000,10^-15,F2);
%METODO 3: REGULA FALSI
[valoresRF2,erroresRF2]=regulaFalsi(-5,10,10000,10^-15,F2);
%METODO 4: PUNTO FIJO
[valoresPF2,erroresPF2]=puntoFijo(contractivaF2,DcontractivaF2,10^-15,100,2);
%METODO 5: NEWTON 
[valoresNR2,erroresNR2]=newtonRaphson(F2,derivadaF2,10000,10^-15,-5);



%%%%%%%%%%%%%%%%%%%%%%% GRAFICAS METODOS NO LINEALES %%%%%%%%%%%%%%%%%%%%%%%

%%% Funcion 1

%Grafica de convergencia de valores vs iteraciones
arreglo_valores = [valoresB,valoresS,valoresRF,valoresPF,valoresNR];
cantidad_iteraciones = [length(valoresB),length(valoresS),length(valoresRF),length(valoresPF),length(valoresNR)];
metodos_ordenados=["Biseccion","Secante","Regula Falsi","Punto Fijo","Newton Raphson"];
label_x= "iteraciones";
label_y= "valores";
label_funcion= './data/funcion_1';
Graficar(arreglo_valores,cantidad_iteraciones,metodos_ordenados,label_x,label_y,label_funcion);
%Grafica de evolucion de errores vs iteraciones
arreglo_errores = [erroresB,erroresS,erroresRF,erroresPF,erroresNR];
cantidad_iteracionesE = [length(erroresB),length(erroresS),length(erroresRF),length(erroresPF),length(erroresNR)];
label_xE= "iteraciones";
label_yE= "errores";
label_funcionE= "./data/error_funcion_1";
Graficar(arreglo_errores,cantidad_iteracionesE,metodos_ordenados,label_xE,label_yE,label_funcionE);

%%% Funcion 2

%Grafica de convergencia de valores vs iteraciones
arreglo_valores2 = [valoresB2,valoresS2,valoresRF2,valoresPF2,valoresNR2];
cantidad_iteraciones2 = [length(valoresB2),length(valoresS2),length(valoresRF2),length(valoresPF2),length(valoresNR2)];
metodos_ordenados2=["Biseccion","Secante","Regula Falsi","Punto Fijo","Newton Raphson"];
label_x2= "iteraciones";
label_y2= "valores";
label_funcion2= "./data/funcion_2";
Graficar(arreglo_valores2,cantidad_iteraciones2,metodos_ordenados2,label_x2,label_y2,label_funcion2);
%Grafica de evolucion de errores vs iteraciones
arreglo_errores2 = [erroresB2,erroresS2,erroresRF2,erroresPF2,erroresNR2];
cantidad_iteracionesE2 = [length(erroresB2),length(erroresS2),length(erroresRF2),length(erroresPF2),length(erroresNR2)];
label_xE2= "iteraciones";
label_yE2= "errores";
label_funcionE2= "./data/error_funcion_2";
Graficar(arreglo_errores2,cantidad_iteracionesE2,metodos_ordenados2,label_xE2,label_yE2,label_funcionE2);


%% Espacio de definicion de funciones: metodos no lineales multi


%metodo de Newton Raphson multivariable

%variables:
syms x1
syms x2
syms x3 


%funcion F
f1 = x1^2 - 10*x1 + x2^2 + 8;
f2 = x1*x2^2 + x1 - 10*x2 + 8;

variablesF=[x1,x2];

[f] = [f1,f2];
[f0] = [0 0];

%funcion G
g1 = x1^2 + x2 - 37;
g2 = x1 - x2^2 - 5;
g3 = x1 + x2 + x3 - 3;

variablesG=[x1,x2,x3];

[g] = [g1,g2,g3];
[g0] = [0 0 0];
 
iter = 1000;
tolerancia = 10^-15;


%calcular valores con metodo
[resultado,error,tiempo,nInstrucciones]= newtonRapshonMulti(g,variablesG,g0,iter,tolerancia);
tamanos = length(error);

tituloY ="Errores";
tituloX =" Iteracion";
titulo = "./data/error_NR_multi";
Graficar(error,tamanos,"Newton Raphson Varias Variables",tituloX,tituloY,titulo);

save('./data/variables')

