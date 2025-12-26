clc; clear all; close all;
%%
A = [-3.0551 -0.9750;
     29.8597 -3.4196];

B = [1.12; 40.9397];

C = [-152.7568 1.2493;
     0 1];

D = [56; 0];

Ed = [1 0 0;
      0 1 0];

Fd = [0 0 1;
      0 0 0];

Ef = [zeros(2) B];

Ff = [eye(2) D];
ss1 = ss(A, B, C, D);

n = size(A,2); % #x
m = size(C,1); % #y
r = size(B,2); % #u
s = 4;

Ts = 0.01;
sigma_ay = 0.05; 
sigma_r = 0.01;
BB = [B Ed Ef zeros(2)];
DD = [D Fd Ff eye(2)];
sys_nom = ss(A,BB,C,DD);
sys_d = c2d(sys_nom,Ts);

[Ad, Bdd, Cd, Ddd] = ssdata(sys_d);

Bd = Bdd(:,1);
Edd = Bdd(:,2:4);
Efd = Bdd(:,5:7);
Enu = Bdd(:,8:9);

Dd = Ddd(:,1);
Fdd = Ddd(:,2:4);
Ffd = Ddd(:,5:7);
Fnu = Ddd(:,8:9);

HOs = [];
for i = 0:s
    HOs = [HOs; C * A^i];
end
Null_Os = null(HOs', 'r');
vs = Null_Os(:,1);         
%%
Hus = zeros(m*(s+1),r*(s+1));
for i = 1:s+1;
    for j=1:i;
        row_start = (i - 1) * m + 1;
        row_end   = i * m;
        col_start = (j - 1) * r + 1;
        col_end   = j * r;
            
        power = i - j;
            
        if power == 0
           Hus(row_start:row_end, col_start:col_end) = Dd;
        else
           Hus(row_start:row_end, col_start:col_end) = Cd * (Ad^(power - 1)) * Bd;
        end  
     end
end


w = 2*s + 2;
gain = zeros(w, w);

for i = 1:2:w
    gain(i, (i+1)/2) = 1;
end

for i = 2:2:w
    gain(i, s + 1 + i/2) = 1;
end
