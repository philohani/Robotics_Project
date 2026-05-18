clc;
%% 1. Load the Robot's Rigid Body Tree
SupernovaArm.DataFormat = 'row';
% Define the end-effector body name.
endEffectorName = 'Body5';

%% 2. Plot Robot's Workspace
rng default; % For reproducible results
fprintf('Generating reachable workspace\n');
[wksp, cfgs] = generateRobotWorkspace(SupernovaArm, {}, endEffectorName, ...
    'IgnoreSelfCollision', 'on');
fprintf('Generated %d reachable end-effector poses.\n', size(wksp, 1));
wksp(wksp(:,3) < 0, 3) = 0;
scatter3(wksp(:,1),wksp(:,2),wksp(:,3))