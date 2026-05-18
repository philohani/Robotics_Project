% Supernova Robotic Arm Workspace – Analytical Method
% DH parameters: [a (mm), alpha (deg), d (mm), θ (deg)]
base_dz = 78;   % fixed base offset in Z
dh = [  0,  90, 45, 0;    % joint 1
      140,  0,  0, 0;     % joint 2
      130,  0,  0, 0;     % joint 3
      133,  0,  0, 0];    % joint 4

% Joint limits [min, max] in degrees
theta_lim = [-90 90;   % θ₁
             0 180;    % θ₂
             -90 90;   % θ₃
             -90 90];  % θ₄

N = 50000;   % number of random samples
% Generate random joint angles (radians)
lim1 = theta_lim(:,1).';
lim2 = theta_lim(:,2).';
theta = bsxfun(@plus,lim1,bsxfun(@times,(lim2-lim1),rand(N,4))) * pi/180;

% Forward kinematics – analytical, no toolboxes
P = zeros(N,3);
for i = 1:N
    T = eye(4);
    T = T * Tz(base_dz);
    T = T * DHtransform(dh(1,1), dh(1,2), dh(1,3), theta(i,1));
    T = T * DHtransform(dh(2,1), dh(2,2), dh(2,3), theta(i,2));
    T = T * DHtransform(dh(3,1), dh(3,2), dh(3,3), theta(i,3));
    T = T * DHtransform(dh(4,1), dh(4,2), dh(4,3), theta(i,4));
    P(i,:) = T(1:3,4)';
end

% Clipping the negative Z-values to make it more reasonable
P(P(:,3) < 0, 3) = 0;

% Plot workspace point cloud
scatter3(P(:,1), P(:,2), P(:,3));
axis equal; grid on;
xlabel('X (mm)'); ylabel('Y (mm)'); zlabel('Z (mm)');
title('4DOF Arm Workspace');

% --- Local functions ---
function T = DHtransform(a, alpha_deg, d, theta)
    alpha = alpha_deg * pi/180;
    T = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
         sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
              0,           sin(alpha),            cos(alpha),            d;
              0,               0,                     0,                 1];
end

function T = Tz(d)
    T = eye(4);
    T(3,4) = d;
end