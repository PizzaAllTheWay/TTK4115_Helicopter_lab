% ==================================================
% Luenberg Observer
% ==================================================

% ==================================================
% Seting up matrixes
A_LUENBERG = [
    0 1 0 0 0;
    0 0 0 0 0;
    0 0 0 1 0;
    0 0 0 0 0;
    K_3 0 0 0 0;
];

B_LUENBERG = [
    0 0;
    0 K_1;
    0 0;
    K_2 0;
    0 0;
];

C_LUENBERG = [
    1 0 0 0 0; % p
    0 0 0 0 0; % p_dot
    0 0 1 0 0; % e
    0 0 0 0 0; % e_dot
    0 0 0 0 1; % lambda_dot
];

p = [-30, -30, -20, -20, -10];

A_trn_LUENBERG = transpose(A_LUENBERG);
C_trn_LUENBERG = transpose(C_LUENBERG);
L_LUENBERG_CONST = transpose(place(A_trn_LUENBERG, C_trn_LUENBERG, p));







