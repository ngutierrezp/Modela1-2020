
%importacion de matrices
addpath('../Metodos','../Metodos/289x289/','../Metodos/1089x1089/','../Metodos/4225x4225/');

%error sugerido:
error = 10^-15;

%% ECUACIONES LINEALES

%En esta parte se hara uso de metodos para el calculo de N incognitas de
%ecuaciones lineales

%El calculo de estas escuaciones esta dado por Ax=b
%Donde A es: matriz de NxN (en general con los coeficientes)
%Donde x es: matriz de 1xN (matriz de incognitas)
%Donde b es : matriz de 1xN (matriz de resultados de ecuaciones)

%Para los siguientes casos, es necesario cumplir con la entrega de stas
%matrices. 

%Puesto que para este caso, las matrices son de gran dimencion, el calculo
%del resultado (en especial de la matriz de 4225x4225) puede tardar
%bastante.

%% METODOS

%Los metodos que se utilizaran son:

%  • Metodo iterativo: Gauss-Jacobi
%  • Metodo iterativo: Gauss-Seidel
%  • Metodo LU:  Doolitle
%  • Metodo LLT: Cholesky
%  • Metodo QR

%% MATRICES  

%Para el uso correcto, se debe descomentar las lineas de las matrices de
%NxN las cuales se quiere evaluar.

%Matriz de 289x289

%A1 = load('A289.dat');
%b1 = load('b289.dat');

%Matriz de 1089x1089

%A1 = load('A1089.dat');
%b1 = load('b1089.dat');

%Matriz de 4225x4255

A1 = load('A4225.dat');
b1 = load('b4225.dat');


%  • Metodo iterativo: Gauss-Jacobi

[valoresJ, erroresJ, iterJ,tiempoJ] = jacobi(A1, b1,1000);
disp('Jacobi...OK!');

%  • Metodo iterativo: Gauss-Seidel

[valoresS, erroresS, iterS,tiempoS] = seidel(A1, b1, 1000);
disp('Seidel...OK!');

%  • Metodo LU:  Doolitle

[valoresD,erroresD,iterD,tiempoD] = doolittle(A1, b1);
disp('Doolittle...OK!');

%  • Metodo LLT: Cholesky

[valoresC,erroresC,iterC,tiempoC] = cholesky(A1, b1);
disp('Cholesky...OK!');


%  • Metodo QR

[valoresQR,erroresQR,iterQR,tiempoQR] = QR(A1, b1);
disp('QR...OK!');

%%%% GRAFICAR MATRIZ 289x289 %%%%

t = [tiempoJ, tiempoS, tiempoD, tiempoC, tiempoQR];
% graficarValoresIt(iterJ, iterS)
% graficarValores(valoresD, valoresC, valoresQR)
% graficarErrores(erroresJ, erroresS)

plot([erroresJ],'-ob','MarkerSize',5,'MarkerFaceColor','b'); hold on;
plot([erroresS],'-*r','MarkerSize',5,'MarkerFaceColor','r'); hold on;

%title('Error matriz 289, Metodos iterativos')
%title('Error matriz 1084, Metodos iterativos')
title('Error matriz 4225, Metodos iterativos')
ylabel('error') % y-axis label
xlabel('Iteraciones') % x-axis label
legend('Gauss-Jacobi','Gauss-Seidel')
hold off;

%print('./graficos/error_289','-dpng');
%print('./graficos/error_1084','-dpng');
print('./graficos/error_4225','-dpng');


c=categorical({'Jacobi','Seidel','Doolitle','Cholesky','QR'});
bar(c,t); hold all;
xlabel('Metodos');
ylabel('tiempo');
hold off;

%print('./graficos/tiempo_ejecucion_289','-dpng');
%print('./graficos/tiempo_ejecucion_1084','-dpng');
print('./graficos/tiempo_ejecucion_4225','-dpng');


