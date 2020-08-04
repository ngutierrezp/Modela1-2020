
% Lab 2: Primera parte


%#######################
%#      Funciones      #
%#######################



%%%% Primera Funcion %%%%

%     H(s)  =   4s
%            --------
%             3s + 1

% Lazo Abierto
H_s1_num = [4 0];
H_s1_den = [3 1];

% Lazo Cerrado
[Hc_s1_num,Hc_s1_den] = cloop(H_s1_num,H_s1_den);



%%%% Segunda Funcion %%%%

%     H(s)  =   5s^2 + 7s + 4
%              ---------------
%               s^2 + 6s + 3

%Lazo abierto
H_s2_num = [5 7 4];
H_s2_den = [1 6 3];

%Lazo cerrado
[Hc_s2_num,Hc_s2_den] = cloop(H_s2_num,H_s2_den);


%%%% Tercera Funcion %%%%

%     H(s)  =    5s^3 + s^2 + 5s - 3
%              ----------------------
%               3s^3 + 4s^2 - 3s + 4

%Lazo abierto
H_s3_num = [5 1 5 -3];
H_s3_den = [3 4 -3 4];

%Lazo cerrado
[Hc_s3_num,Hc_s3_den] = cloop(H_s3_num,H_s3_den);


%#######################
%#      Graficos       #
%#######################

%#############
% Funcion 1 Abierto
figure()
step(H_s1_num,H_s1_den);
title('Respuesta de la función 1 de lazo abierto en el tiempo')
xlabel('Tiempo (segundos)')
xlabel('Amplitud')
grid on;


%#############
% Funcion 1 Cerrado
figure()
step(Hc_s1_num,Hc_s1_den);
title('Respuesta de la función 1 de lazo cerrado en el tiempo')
xlabel('Tiempo (segundos)')
xlabel('Amplitud')
grid on;


%#############
% Funcion 2 Abierto
figure()
step(H_s2_num,H_s2_den);
title('Respuesta de la función 2 de lazo abierto en el tiempo')
xlabel('Tiempo (segundos)')
xlabel('Amplitud')
grid on;


%#############
% Funcion 2 Cerrado
figure()
step(Hc_s2_num,Hc_s2_den);
title('Respuesta de la función 2 de lazo cerrado en el tiempo')
xlabel('Tiempo (segundos)')
xlabel('Amplitud')
grid on;

%#############
% Funcion 3 Abierto
figure()
step(H_s3_num,H_s3_den);
title('Respuesta de la función 3 de lazo abierto en el tiempo')
xlabel('Tiempo (segundos)')
xlabel('Amplitud')
grid on;


%#############
% Funcion 3 Cerrado
figure()
step(Hc_s3_num,Hc_s3_den);
title('Respuesta de la función 3 de lazo cerrado en el tiempo')
xlabel('Tiempo (segundos)')
xlabel('Amplitud')
grid on;


% Graficas de polos y ceros
% necesita instalar:    - Audio Toolbox 
%                       - DSP System Toolbox


% Funcion 1
F1 = fvtool(H_s1_num,H_s1_den,Hc_s1_num,Hc_s1_den,'polezero');
F1.CurrentAxes.Title.String = 'Gráfica polos y ceros de la función 1 con lazo abierto y cerrado. ';
F1.CurrentAxes.XLabel.String = 'Parte Real';
F1.CurrentAxes.YLabel.String = 'Parte Imaginaria';
F1.Legend = 'on';
F1.CurrentAxes.Legend.String = {'','Polos Lazo Abierto','Cero de la función','Polos Lazo Cerrado'};

% Funcion 2
F2 = fvtool(H_s2_num,H_s2_den,Hc_s2_num,Hc_s2_den,'polezero');
F2.CurrentAxes.Title.String = 'Gráfica polos y ceros de la función 2 con lazo abierto y cerrado. ';
F2.CurrentAxes.XLabel.String = 'Parte Real';
F2.CurrentAxes.YLabel.String = 'Parte Imaginaria';
F2.Legend = 'on';
F2.CurrentAxes.Legend.String = {'','Polos Lazo Abierto','Ceros de la función','Polos Lazo Cerrado'};

% Funcion 3
F3 = fvtool(H_s3_num,H_s3_den,Hc_s3_num,Hc_s3_den,'polezero');
F3.CurrentAxes.Title.String = 'Gráfica polos y ceros de la función 3 con lazo abierto y cerrado. ';
F3.CurrentAxes.XLabel.String = 'Parte Real';
F3.CurrentAxes.YLabel.String = 'Parte Imaginaria';
F3.Legend = 'on';
F3.CurrentAxes.Legend.String = {'','Polos Lazo Abierto','Ceros de la función','Polos Lazo Cerrado'};



%#######################
%#      Graficos       #
%#######################

[z1a,p1a,k1a]=tf2zp(H_s1_num,H_s1_den);  
settingTimeA1= stepinfo(tf(H_s1_den,H_s1_den));
settingTimeA1 = settingTimeA1.SettlingTime;
[z1c,p1c,k1c]=tf2zp(Hc_s1_num,Hc_s1_den); 
settingTimeC1= stepinfo(tf(Hc_s1_den,Hc_s1_den));
settingTimeC1 = settingTimeC1.SettlingTime;
[z2a,p2a,k2a]=tf2zp(H_s2_num,H_s2_den);  
settingTimeA2= stepinfo(tf(H_s2_num,H_s2_den));
settingTimeA2 = settingTimeA2.SettlingTime;
[z2c,p2c,k2c]=tf2zp(Hc_s2_num,Hc_s2_den); 
settingTimeC2= stepinfo(tf(Hc_s2_num,Hc_s2_den));
settingTimeC2 = settingTimeC2.SettlingTime;
[z3a,p3a,k3a]=tf2zp(H_s3_num,H_s3_den);
settingTimeA3= stepinfo(tf(H_s3_num,H_s3_den));
settingTimeA3 = settingTimeA3.SettlingTime;
[z3c,p3c,k3c]=tf2zp(Hc_s3_num,Hc_s3_den);
settingTimeC3= stepinfo(tf(Hc_s3_num,Hc_s3_den));
settingTimeC3 = settingTimeC3.SettlingTime;


C = {'funcion','ceros','polos','ganancia','Tiempo de estabilización';
    'fun 1 Abierto',z1a,p1a,k1a,settingTimeA1;
    'fun 1 Cerrado',z1c,p1c,k1c,settingTimeC1;
    'fun 2 Abierto',z2a,p2a,k2a,settingTimeA2;
    'fun 2 Cerrado',z2c,p2c,k2c,settingTimeC2;
    'fun 3 Abierto',z3a,p3a,k3a,settingTimeA3;
    'fun 3 Cerrado',z3c,p3c,k3c,settingTimeC3;
    };
ds = cell2dataset(C);














