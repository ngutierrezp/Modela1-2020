

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

%     H(s)  =    5s^3 + s^2 - 5s - 3
%              ----------------------
%               3s^3 + 4s^2 - 3s + 4

%Lazo abierto
H_s3_num = [5 1 -5 -3];
H_s3_den = [3 4 -3 4];

%Lazo cerrado
[Hc_s3_num,Hc_s3_den] = cloop(H_s3_num,H_s3_den);




figure()
step(H_s1_num,H_s1_den);

figure()
step(Hc_s1_num,Hc_s1_den);


figure()
step(H_s2_num,H_s2_den);

figure()
step(Hc_s2_num,Hc_s2_den);

figure()
step(H_s3_num,H_s3_den);

figure()
step(Hc_s3_num,Hc_s3_den);













