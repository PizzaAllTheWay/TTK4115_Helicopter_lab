% ==================================================
% LQR code custom fit for heli 3-10
% 
% Edit and change Q and R values to fit your controller
% Or use "Change these values" section to better represent Q and R
% ==================================================

% ========== Change these values (START) ==========
p_expected_max = deg2rad(8); % [rad]
p_velocity_expected_max = deg2rad(30); % [rad/s]
e_velocity_expected_max = deg2rad(20); % [rad/s]

V_s_expected_max = 0.25; % [V]
V_d_expected_max = 0.2; % [V]
% ========== Change these values (STOP) ==========

% ==================================================
% Seting up matrixes
A = [
    0 1 0;
    0 0 0;
    0 0 0;
];

B = [
    0 0;
    0 K_1;
    K_2 0;
];



% ==================================================
% Set upp Q and R matrixes
% Have 3 inputs and 2 outputs
% Calculate Q and R matrixes
%Q_11 = 1/(p_expected_max^2);
%Q_22 = 1/(p_velocity_expected_max^2);
%Q_33 = 1/(e_velocity_expected_max^2);
%R_11 = 1/(V_s_expected_max^2);
%R_22 = 1/(V_d_expected_max^2);

% Uncoment this and coment out the upper Q and R numbers to write them in
% manualy
Q_11 = 2;
Q_22 = 3;
Q_33 = 1;
R_11 = 1;
R_22 = 3;

% Add everything to Q and R matrixes
Q_LQR = [
    Q_11 0 0;
    0 Q_22 0;
    0 0 Q_33;
];

R_LQR = [
    R_11 0;
    0 R_22;
];



% ==================================================
% Do LQR calculations to find K matrix 
K_LQR = lqr(A, B, Q_LQR, R_LQR);



% ==================================================
% Find individuall k_ij values in K matrix and save it in F matrix
k_11 = K_LQR(1, 1);
k_12 = K_LQR(1, 2);
k_13 = K_LQR(1, 3);
k_21 = K_LQR(2, 1);
k_22 = K_LQR(2, 2);
k_23 = K_LQR(2, 3);

F = [
    k_11 k_13;
    k_21 k_23;
];
