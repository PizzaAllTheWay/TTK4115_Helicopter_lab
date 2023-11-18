% ==================================================
% Integral LQR code custom fit for heli 3-10
% 
% Edit and change Q and R values to fit your controller
% Or use "Change these values" section to better represent Q and R
% 
% Takes into acount integral ledd as well as LQR
% ==================================================



% ========== Change these values (START) ==========
p_expected_max = 1.5; % [rad]
p_velocity_expected_max = 0.5; % [rad/s]
e_velocity_expected_max = 0.25; % [rad/s]
p_integral_expected_max = 0.3; % [rad] 0.3
e_velocity_integral_expected_max = 0.5; % [rad]

V_d_expected_max = 0.25; % [V]
V_s_velocity_expected_max = 1.0; % [V]

% ========== Change these values (STOP) ==========



% ==================================================
% Run matlab files that this file is dependent on
%init_heli_3_10
%luenberg_observer_heli_3_10



% ==================================================
% Seting up matrixes
A_LQR = [
    0 1 0 0 0;
    0 0 0 0 0;
    0 0 0 0 0;
    -1 0 0 0 0;
    0 0 -1 0 0;
];

B_LQR = [
    0 0;
    0 K_1;
    K_2 0;
    0 0;
    0 0;
];

G = [
    0 0;
    0 0;
    0 0;
    1 0;
    0 1;
];



% ==================================================
% Set upp Q and R matrixes
% Have 3 inputs and 2 outputs
% Calculate Q and R matrixes
Q_11 = 1/(p_expected_max^2);
Q_22 = 1/(p_velocity_expected_max^2);
Q_33 = 1/(e_velocity_expected_max^2);
Q_44 = 1/(p_integral_expected_max^2);
Q_55 = 1/(e_velocity_integral_expected_max^2);
R_11 = 1/(V_d_expected_max^2);
R_22 = 1/(V_s_velocity_expected_max^2);

% Uncoment this and coment out the upper Q and R numbers to write them in
% manualy
%Q_11 = 1.5;
%Q_22 = 0.5;
%Q_33 = 0.25;
%Q_44 = 0.3;
%Q_55 = 0.5;
%R_11 = 0.25;
%R_22 = 1;

% Add everything to Q and R matrixes
Q_LQR = [
    Q_11 0 0 0 0;
    0 Q_22 0 0 0;
    0 0 Q_33 0 0;
    0 0 0 Q_44 0;
    0 0 0 0 Q_55;
];

R_LQR = [
    R_11 0;
    0 R_22;
];



% ==================================================
% Do LQR calculations to find K matrix 
K_LQR = lqr(A_LQR, B_LQR, Q_LQR, R_LQR);



% ==================================================
% Find individuall k_ij values in K matrix and save it in F matrix
k_11 = K_LQR(1, 1);
k_12 = K_LQR(1, 2);
k_13 = K_LQR(1, 3);
k_14 = K_LQR(1, 4);
k_15 = K_LQR(1, 5);
k_21 = K_LQR(2, 1);
k_22 = K_LQR(2, 2);
k_23 = K_LQR(2, 3);
k_24 = K_LQR(2, 4);
k_25 = K_LQR(2, 5);

F = [
    k_11 k_13;
    k_21 k_23;
];

