%################################################
%#                  Segunda Parte               #
%################################################
clear
clc
%slCharacterEncoding('UTF-8')
disp("#################################################")
disp("Segunda parte")

%########## Definición de variables ############

n1 = [4 0];
d1 = [10 0 4];
n2 = [0 0 0 3];
d2 = [0 0 6 16];
n3 = [0 0 4 10];
d3 = [4 9 5 0];
n4 = [0 0 0 1];
d4 = [0 0 7 10];
n5 = [0 0 8 8];
d5 = [1 2 3 0];
n6 = [0 0 3 2];
d6 = [0 5 7 10];

H1 = tf(n1,d1);
H2 = tf(n2,d2);
H3 = tf(n3,d3);
H4 = tf(n4,d4);
H5 = tf(n5,d5);
H6 = tf(n6,d6);

% Intento #1 (casi coincide con intento #3)
figure(1)
s1 = feedback(H3, 1, +1); % Equivale a H3/(1-H3)
s2 = parallel(H4, H5);
s3 = series(s2, s1);
s4 = series(s3, H6);
s5 = parallel(H1,H2); 
Y = parallel(s4, s5);

step(Y, 10);
%%%%%%%%%%%%%%%%%%%%%%%%%

% Método alternativo opcional
% ** Usando el método #2 **
n7 = 1;
d7 = 1;
H7 = tf(n7, d7);

%figure(2)
%transferNum = H1+H1*H3+H2-H2*H3+H3*H6*(H4+H5);
%transferDen = 1+H3;
%transfer = tf(transferNum, transferDen)
%step(transfer, 10)

sys = append(H1,H2,H3,H4,H5,H6, H7);
nblocks = 7;
blkbuild;
q =[1 0 0 0
    2 0 0 0
    3 3 0 0
    4 3 0 0
    5 3 0 0
    6 4 5 0
    7 1 2 6];
input = [1,2,3];
output = 7;
system = connect(sys,q,input,output)
[Yn, Yd] = ss2tf(system.A,system.B,system.C,system.D, 3)

step(Yn, Yd, 10);
