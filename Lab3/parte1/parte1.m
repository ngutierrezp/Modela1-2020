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

[A,B,C,D] = tf_to_ms(f1num,f1den,f2num,f2den)


% Transformando matriz de estados a funcion de transferencia.

[num,den] = ms_to_tf(A,B,C,D);


tf(num,den)




