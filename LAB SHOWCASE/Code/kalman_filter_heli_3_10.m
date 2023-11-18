% ==================================================
% Seting up matrixes
A_CONTINOUS = [
    0 1 0 0 0;
    0 0 0 0 0;
    0 0 0 1 0;
    0 0 0 0 0;
    K_3 0 0 0 0;
];

B_CONTINOUS = [
    0 0;
    0 K_1;
    0 0;
    K_2 0;
    0 0;
];

C_CONTINOUS = [
    1 0 0 0 0; % p
    0 0 0 0 0; % p_dot
    0 0 1 0 0; % e
    0 0 0 0 0; % e_dot
    0 0 0 0 1; % lambda_dot
];



% ==================================================
% Discretice the system 
System = ss(A_CONTINOUS, B_CONTINOUS, C_CONTINOUS, 0);
sample_time = 0.002;
DiskretSystem = c2d(System, sample_time);

% Extract the matrices
A_Kalman = DiskretSystem.A;
B_Kalman = DiskretSystem.B;
C_Kalman = DiskretSystem.C;

% Initial values for x_hat and P_bar
x_hat_init = [1; 1; 1; 1; 1;];
P_bar_init = [1 0 0 0 0; 
              0 1 0 0 0;
              0 0 1 0 0;
              0 0 0 1 0;
              0 0 0 0 1;];



% ==================================================
% Define Q_w
Q_w_11 = 0.00000001; % Pitch
Q_w_22 = 0.007; % Pitch rate
Q_w_33 = 0.00000001; % Elevation
Q_w_44 = 0.001; % Elevation rate
Q_w_55 = 0.0001; % Travel

Q_w = [Q_w_11 0 0 0 0;
       0 Q_w_22 0 0 0;
       0 0 Q_w_33 0 0;
       0 0 0 Q_w_44 0;
       0 0 0 0 Q_w_55;];



% ==================================================
% Calculate Rv based on noise model of flying drone IMU
Rd_Flying = load("Rd_Flying");

y_Flying = Rd_Flying.ans(12:16,14623:end);
y_Flying_p = y_Flying(1,:);
y_Flying_p_dot = y_Flying(2,:);
y_Flying_e = y_Flying(3,:);
y_Flying_e_dot = y_Flying(4,:);
y_Flying_lambda = y_Flying(5,:);

Covariance_y_Flying_p = cov(y_Flying_p);
Covariance_y_Flying_p_dot = cov(y_Flying_p_dot);
Covariance_y_Flying_e = cov(y_Flying_e);
Covariance_y_Flying_e_dot = cov(y_Flying_e_dot);
Covariance_y_Flying_lambda = cov(y_Flying_lambda);

R_v = [Covariance_y_Flying_p 0 0 0 0; 
       0 Covariance_y_Flying_p_dot 0 0 0;
       0 0 Covariance_y_Flying_e 0 0;
       0 0 0 Covariance_y_Flying_e_dot 0;
       0 0 0 0 Covariance_y_Flying_lambda;];


   
   
   











