%################################################
%#           Lab 3: Primera Parte               #
%################################################
clear
clc
%slCharacterEncoding('UTF-8')
disp("#################")
disp("Primera parte")
disp("#################")



% Funcion de transferencia a modelo de estados


% ENTRADAS : 2 FUNCIONES 

%Funcion 1 H(s):

%           4
%        -------
%         s + 5
f1num= [0 4];
f1den= [1 5];


%Funcion 2 G(s):

%           2
%        -------
%         s + 1

f2num= [0 2];
f2den= [1 1];

% transformandola a modelo de estados

[M,V] = tf_to_ms(f1num,f1den,f2num,f2den)


% Transformando matriz de estados a funcion de transferencia.

[n1,d1,n2,d2] = ms_to_tf(M,V);

tf(n1,d1)
tf(n2,d2)















