%% 1. Rigid Body Tree Setup
SupernovaArm.DataFormat = 'column';
q_given = [0; -pi/6; -pi/3; 0];
q_dot_given = [0.1; 0.2; -0.1; 0.1];
config = q_given;
%% 2. Jacobian Matrix Determination
J = geometricJacobian(SupernovaArm, config, eeName);
% This Function gets the angular component before the linear component
% so we adjust them
J_v=J(4:6,:);
J_w=J(1:3,:);
J_mod=[J_v; J_w];
disp('--- 1. Jacobian Analysis ---');
disp('Jacobian matrix J (6 x N):');
disp(J_mod);
%% 3. Singularity Analysis
n = size(J, 2);          % number of joints (DOF)
maxRank = min(6, n);     % maximum possible rank
% Rank Test
rank_J = rank(J);
fprintf('Jacobian Rank is: %d\n', rank_J);
fprintf('Maximum Rank is: %d\n', maxRank);
if rank_J < maxRank
    fprintf('*** SINGULAR CONFIGURATION DETECTED ***\n');
    fprintf('Jacobian rank = %d (max possible = %d)\n', rank_J, maxRank);
else
    fprintf('Configuration is non-singular. Jacobian rank = %d\n', rank_J);
end
%% 4. Velocity Mapping
% Map joint velocities to end-effector velocities using V = J * q_dot
V_ee = J * q_dot_given;
% Separate angular and linear velocities for clarity
omega = V_ee(1:3); % Angular velocity [rad/s]
v= V_ee(4:6); % Linear velocity [m/s]
disp('--- 3. Velocity Mapping ---');
disp('Given Joint Velocities (q_dot):');
disp(q_dot_given);
disp('End-Effector Velocity (V = J * q_dot):');
fprintf('Angular Velocity [wx, wy, wz]^T : [%.4f, %.4f, %.4f] rad/s\n' ...
    , omega(1), omega(2), omega(3));
fprintf('Linear Velocity  [vx, vy, vz]^T : [%.4f, %.4f, %.4f] m/s\n' ...
    , v(1), v(2), v(3));