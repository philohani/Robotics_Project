%% ==========Inverse Kinematics Using Robotic Systems Toolbox=============
%% 1. Initialize the Inverse Kinematics Solver
ik = inverseKinematics('RigidBodyTree', SupernovaArm);
targetPosition = [0.2, 0.2, 0.3];
targetOrientation = eul2quat([0, 0, 0]);
targetPose = trvec2tform(targetPosition) * quat2tform(targetOrientation);
%% 2. Define Solver Weights
weights = [0, 1, 0, 1, 1, 1];
%Set the Initial Guess
initialGuess = homeConfiguration(SupernovaArm);
%% 3. Execute the IK Solver
disp('Calculating Inverse Kinematics for Supernova Arm...');
[configSoln, solnInfo] = ik(endEffectorName, targetPose, weights, initialGuess);
%% 4. Output the Results
disp('--- Solver Output ---');
disp(['Status: ', solnInfo.Status]);
disp(['Iterations: ', num2str(solnInfo.Iterations)]);
disp(['Pose Error: ', num2str(solnInfo.PoseErrorNorm)]);
disp('--- Joint Angles (degrees) ---');

for i = 1:length(configSoln)
    fprintf('Joint %d: %.2f°\n', i, rad2deg(configSoln(i)));
end
%% 5.Visualization
figure;
show(SupernovaArm, configSoln);
title('Supernova Arm: IK Solution');
axis equal;
hold on;
plotTransforms(targetPosition, targetOrientation, 'FrameSize', 0.15);
hold off;