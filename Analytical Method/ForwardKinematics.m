% Forward KInematics, Analytical Method
%% 1. User Input
% Input Joint Angles [theta1, theta2, theta3, theta4]
theta = [0, pi/3, -pi/3, 0]; 

%% 2. Robot Parameters
base_dz = 78;   % fixed base offset in Z (mm)
% DH parameters: [a (mm), alpha (deg), d (mm)]
dh = [  0,  90, 45;    % joint 1
      140,   0,  0;    % joint 2
      130,   0,  0;    % joint 3
      133,   0,  0];   % joint 4

%% 3. Compute Forward Kinematics
T = eye(4);
T = T * Tz(base_dz);
T = T * DHtransform(dh(1,1), dh(1,2), dh(1,3), theta(1));
T = T * DHtransform(dh(2,1), dh(2,2), dh(2,3), theta(2));
T = T * DHtransform(dh(3,1), dh(3,2), dh(3,3), theta(3));
T = T * DHtransform(dh(4,1), dh(4,2), dh(4,3), theta(4));
% Extract and Display Results
P = T(1:3, 4)'; % End-effector position [X, Y, Z]
fprintf('Joint Angles (radians): [%.2f, %.2f, %.2f, %.2f]\n', theta_deg);
fprintf('End-Effector Position [X, Y, Z] (mm): [%.2f, %.2f, %.2f]\n\n', P);
disp('Final Transformation Matrix (T):');
disp(T);

%% 4. Helper Functions
% Function for Computing the A-Matrix
function T = DHtransform(a, alpha_deg, d, theta)
    alpha = alpha_deg * pi/180;
    T = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
         sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
              0,           sin(alpha),            cos(alpha),            d;
              0,               0,                     0,                 1];
end

% Function for Computing the Offset Transformation
function T = Tz(d)
    T = eye(4);
    T(3,4) = d;
end