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
Q = 1 ;   % process noise covariance
R = 1 ;   % measurement noise covariance
ss2 = ss(A, BB, C, DD);

[kalmf, L, P] = kalman(ss1, Q, R);
eig_values = eig(A - L*C);
figure(1);plot(eig_values,"xr","LineWidth",2);grid on;
title("eigen value of the sys");
xlabel("Re");ylabel("Im");




