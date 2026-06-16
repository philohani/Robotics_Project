%% 1. Performing Forward Kinematics
theta = [0, pi/3, -pi/3, 0]; 
% DH parameters: [a, alpha, d]
base_dz = 78;   
dh = [  0,  90, 45;    % Link 1
      140,   0,  0;    % Link 2
      130,   0,  0;    % Link 3
      133,   0,  0];   % Link 4
% Forward Kinematics Transformation Matrix
T01 = Tz(base_dz) * DHtransform(dh(1,1), dh(1,2), dh(1,3), theta(1));
T02 = T01 * DHtransform(dh(2,1), dh(2,2), dh(2,3), theta(2));
T03 = T02 * DHtransform(dh(3,1), dh(3,2), dh(3,3), theta(3));
T04 = T03 * DHtransform(dh(4,1), dh(4,2), dh(4,3), theta(4));
% Extract Positions (o_i)
o0 = [0; 0; 0];
o1 = T01(1:3, 4);
o2 = T02(1:3, 4);
o3 = T03(1:3, 4);
on = T04(1:3, 4); % End-effector tip
% Extract Orientations about Z-Axis (z_i)
z0 = [0; 0; 1];
z1 = T01(1:3, 3);
z2 = T02(1:3, 3);
z3 = T03(1:3, 3);
%% 2. Getting Jacobian Matrix
J1 = [cross(z0, (on - o0)); z0];
J2 = [cross(z1, (on - o1)); z1];
J3 = [cross(z2, (on - o2)); z2];
J4 = [cross(z3, (on - o3)); z3];
J = [J1, J2, J3, J4];
disp('--- JACOBIAN MATRIX ---');
disp(J);
%% 3. Singularity Analysis:
disp('---- 2. Singularity Analysis ----')
J11=J(1:2,1:2);         det_J11=det(J11);
J12=J(1:2,3:4);         det_J12=det(J12);
J21=J(3:4,1:2);         det_J21=det(J21);
J22=J(3:4,3:4);         det_J22=det(J22);
J31=J(5:6,1:2);         det_J31=det(J31);
J32=J(5:6,3:4);         det_J32=det(J32);
disp('Determinant of the Jacobian Matrix:')
Det_matrix=[det_J11, det_J12; det_J21, det_J22; det_J31, det_J32]
if(Det_matrix==zeros(3,2))
    disp('Singular Configuration')
else    
    disp('Non-Singular Configuration')
end
%% 4. Velocity Mapping 
q_dot = [0.1; 0.2; -0.1; 0.1]; % Example joint speeds (rad/s)
x_dot = J * q_dot;             % Forward mapping: q_dot -> x_dot
J_pinv = pinv(J);              % Inverse Mapping: x_dot -> q_dot
q_dot_recovered = J_pinv * x_dot;
disp('--- 3. VELOCITY MAPPING TEST ---');
disp('Assumed Joint Velocities (q_dot):');
disp(q_dot);
disp('Resulting End-Effector Task Velocities (x_dot):');
disp(x_dot);
disp('Recovered Joint Velocities (J_pinv * x_dot):');
disp(q_dot_recovered);

%% Helper Function
% Transformation Matrix
function T = DHtransform(a, alpha_deg, d, theta)
    alpha = alpha_deg * pi/180;
    T = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
         sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
              0,           sin(alpha),            cos(alpha),            d;
              0,                0,                     0,                 1];
end
% Getting the Z_i
function T = Tz(d)
    T = eye(4);
    T(3,4) = d;
end