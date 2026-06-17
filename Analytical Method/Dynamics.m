%% Dynaminc Analysis Analytical Method
%% 1. Given Parameters
thetas    = [0, pi/3, -pi/3, 0]; 
theta_dot = [0.1, 0.2, -0.1, -0.1];
masses    = [0.17, 0.15623, 0.15443, 0.19014];
I1 = [222364.10,   503.01,   4909.49;
         503.01, 237697.08,  21236.13;
        4909.49,  21236.13, 213106.79] * 1e-9;
I2 = [408579.31,  17507.74,      0.00;
       17507.74,  59808.96,     -0.05;
           0.00,     -0.05, 434533.61] * 1e-9;         
I3 = [354064.76,  15434.47,      0.00;
       15434.47,  59679.89,     -0.04;
           0.00,     -0.04, 380063.53] * 1e-9;         
I4 = [331327.56, -72734.27,  -2635.64;
      -72734.27, 193326.46, -18877.39;
       -2635.64, -18877.39, 401879.53] * 1e-9;
I_tensors = {I1, I2, I3, I4};
%% 2. Symbolic Variables & DH Parameters
syms q1 q2 q3 q4 dq1 dq2 dq3 dq4 real
q = [q1; q2; q3; q4];
dq = [dq1; dq2; dq3; dq4];
% Fixed base transformation (Link 0 -> 0)
T_base = [eye(3), [0; 0; 78]; 0 0 0 1];
% Standard DH Table: [alpha_x, a_x, d_z, theta_z]
DH = [pi/2,   0, 0.045, q1;
         0, 0.14,  0, q2;
         0, 0.13,  0, q3;
         0, 0.133,  0, q4];
%% 3. Forward Kinematics
T = cell(1, 4);  % Transformation Matrix
R = cell(1, 4);  % Rotation Matrix
P = cell(1, 4);  % Position Matrix
Z = cell(1, 4);  % Z-axis Matrix
T_curr = T_base;
for i = 1:4
    alpha = DH(i, 1); a = DH(i, 2); d = DH(i, 3); theta = DH(i, 4);
    % Denavit-Hartenberg Transformation Matrix
    A = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
         sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
                  0,             sin(alpha),             cos(alpha),            d;
                  0,                      0,                      0,            1];                  
    T_curr = T_curr * A;
    T{i} = T_curr;
    % Extract Rotation, Position, and Z-axis
    R{i} = T_curr(1:3, 1:3);
    P{i} = T_curr(1:3, 4);
    if i == 1
        Z{1} = T_base(1:3, 3);
    else
        Z{i} = T{i-1}(1:3, 3);
    end
end
%% 4. Getting Jacobian Matricies and Getting the Inertia Matrix M(q):
disp('Calculating the Inertia Matrix...');
M_sym = sym(zeros(4, 4));
for i = 1:4
    J_v = sym(zeros(3, 4));
    J_w = sym(zeros(3, 4));
    % Calculate Jacobians up to link i
    for j = 1:i
        if j == 1
            P_prev = T_base(1:3, 4);
        else
            P_prev = P{j-1};
        end
        J_v(:, j) = cross(Z{j}, P{i} - P_prev); % Linear Velocity Jacobian
        J_w(:, j) = Z{j};                       % Angular Velocity Jacobian
    end
    % Inertia Tensor in World Frame = R * I * R^T
    I_world = R{i} * I_tensors{i} * R{i}.';
    % Accumulate Mass Matrix components
    M_sym = M_sym + masses(i) * (J_v.' * J_v) + (J_w.' * I_world * J_w);
end
M_sym = simplify(M_sym);
%% 5. Gravity Matrix G(q)
disp('Calculating Gravity Matrix...');
g_vec = [0; 0; -9.81]; % Gravity acceleration along -Z
Pot = sym(0);
% Potential Energy = sum(m * g * h)
for i = 1:4
    Pot = Pot - masses(i) * g_vec.' * P{i}; 
end
% Gravity vector is the gradient of Potential Energy wrt q
G_sym = simplify(jacobian(Pot, q).');
%% 6. Coriolis Matrix C(q, dq) 
disp('Calculating Coriolis Matrix...');
C_sym = sym(zeros(4, 4));
% Computed analytically using Christoffel symbols
for k = 1:4
    for j = 1:4
        for i = 1:4
            c_ijk = 0.5 * (diff(M_sym(k, j), q(i)) + diff(M_sym(k, i), q(j)) - diff(M_sym(i, j), q(k)));
            C_sym(k, j) = C_sym(k, j) + c_ijk * dq(i);
        end
    end
end
C_sym = simplify(C_sym);
%% 7. Evaluate and Print Numerical Matrices
disp('========================================');
disp('          NUMERICAL RESULTS             ');
disp('========================================');

q_val = thetas.';
dq_val = theta_dot.';

% Evaluate M(q)
M_num = double(subs(M_sym, q, q_val));
disp('Inertia Matrix M(q):');
disp(M_num);
disp(' ');

% Evaluate C(q, dq)
C_num = double(subs(C_sym, [q; dq], [q_val; dq_val]));
disp('Coriolis Matrix C(q, dq):');
disp(C_num);
disp(' ');

% Evaluate G(q)
G_num = double(subs(G_sym, q, q_val));
disp('Gravity Matrix G(q):');
disp(G_num);
%% 8. Calculate Joint Torques (Tau)
disp('Calculating Joint Torques...');
theta_ddot = [0.05, -0.1, 0.05, 0.0]; 
q_ddot_val = theta_ddot.';
Tau_num = M_num * q_ddot_val + C_num * dq_val + G_num;
disp('Joint Torques Tau (Nm):');
disp(Tau_num);