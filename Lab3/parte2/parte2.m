%################################################
%#           Lab 3: Primera Parte               #
%################################################
clear
clc
%slCharacterEncoding('UTF-8')

disp("##########################")
disp("# Segunda parte: 3 casos #")
disp("##########################")

%#############################
%#   Variables y Parametros  #
%#############################

% Se crea un vector de tiempo a 5 segundos
t = (0:0.05:10)';

% ##### Caso 1: #####
A2 = 4;
h1 = 1;
h2 = 3;
% Se crea una función step de amplitud 2 a partir del segundo 2
u = zeros(1, length(t));
u(60:length(u)) = 2;

% Se llama a la función creada para obtener las matrices del state system
[A, B, C, D] = fluxModel(A2);
% Se crea el objeto state system de las matrices obtenidas
sys = ss(A,B,C,D, 'StateName', {'x1' 'x2'});

% Se grafica la simulación

% Condiciones iniciales para los niveles
% Se fija con un valor mayor a 0 para que no llegue a valores negativos
% demasiado rápido
% x_0 = [ nivel x1, nivel x2 ]
x_0 = [h1, h2];

% Se utiliza la función lsim en vez de step, para poder ingresar
% condiciones iniciales
[y, t] = lsim(sys,u,t,x_0);
plotSim(t,u,y);

% ##### Caso 2: #####
A2 = 0.5;
h1 = 3;
h2 = 6;
% Se crea una función sinusoidal
u = 2 + 2*sin(t);

[A, B, C, D] = fluxModel(A2);
sys = ss(A,B,C,D, 'StateName', {'x1' 'x2'});

% Se grafica la simulación
x_0 = [h1, h2];
[y, t] = lsim(sys,u,t,x_0);
plotSim(t,u,y);

% ##### Caso 3: #####
A2 = 3;
h1 = 10;
h2 = 2;
% Se crea una función cuadrada
[u,t] = gensig('square',1,10,0.05);
[A, B, C, D] = fluxModel(A2);
sys = ss(A,B,C,D, 'StateName', {'x1' 'x2'});

% Se grafica la simulación
x_0 = [h1, h2];
[y, t] = lsim(sys,u,t,x_0);
plotSim(t, u, y);


disp("#######################################")
disp("Segunda parte: Ejemplo visto en clase #")
disp("#######################################")

%#############################
%#   Variables y Parametros  #
%#############################

% Se utilizan los parámetros del ejemplo visto en clase
A1 = 2;
A2 = 4;
r1 = 1/4;
r2 = 1/16;

% Se llama a la función creada para obtener las matrices del state system
[A, B, C, D] = fluxModelGeneric(r1,r2,A1,A2);
% Se crea el objeto state system de las matrices obtenidas
sys = ss(A,B,C,D, 'StateName', {'x1' 'x2'});

% Se crea un vector de tiempo a 5 segundos
t = (0:0.05:5)';
% Se crea una función de entrada
u = ones(1, length(t));
% O una función de entrada alternativa
% u = 5 + 5*sin(t);

% Condiciones iniciales para los niveles
% Se fija con un valor mayor a 0 para que no llegue a valores negativos
% demasiado rápido
% x_0 = [ nivel x1, nivel x2 ]
x_0 = [4, 8];

% Se utiliza la función lsim en vez de step, para poder ingresar
% condiciones iniciales
[y, t] = lsim(sys,u,t,x_0);

subplot(2,1,1)
plot(t, y(:,1));
title("Nivel contenedor 1 (x1)");
xlabel("Tiempo (s)")
ylabel("Nivel (m)")
yline(0, "-.")

subplot(2,1,2)
plot(t, y(:,2));
title("Nivel contenedor 2 (x2)");
xlabel("Tiempo (s)")
ylabel("Nivel (m)")
yline(0, "-.")

