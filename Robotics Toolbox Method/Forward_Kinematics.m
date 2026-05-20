% Forward Kinematics using MATLAB Robotics System Toolbox
%% 1. Initializeing Robot's Configurations
SupernovaArm.DataFormat='row';
%Specify the joint angles
jointAngles = [0 -pi/6 -pi/3 0];
%Identify the end-effector body name
eeName = SupernovaArm.BodyNames{end}; 

%% 2. Compute Forward Kinematics
T = getTransform(SupernovaArm, jointAngles, eeName);
disp('--- Forward Kinematics Results ---');
fprintf('End-Effector Body Name: %s\n\n', eeName);
disp('4x4 Homogeneous Transformation Matrix (Base to End-Effector):');
disp(T);
% Extract and display just the Cartesian position (X, Y, Z) in meters
position = tform2trvec(T);
disp('Cartesian Position [X, Y, Z] (meters):');
disp(position);

%% 3. Visualize the Robot Configuration
figure;
show(SupernovaArm, jointAngles, 'PreservePlot', false);
title('Robot Configuration at Specified Joint Angles');
axis auto;