%% 1. Assign Dynamic Properties to SupernovaArm
SupernovaArm.DataFormat='column';
%% 2. Assign Dynamics
SupernovaArm.Gravity = [0 0 -9.81];
q = [0; -pi/6; -pi/3; 0];
qd = [0.1; 0.2; -0.1; -0.1];
qdd = [0.05; -0.1; 0.05; 0.0];
%% 3. Getting Dynamic Matrices
M = massMatrix(SupernovaArm,q);
Cv = velocityProduct(SupernovaArm,q,qd);
G = gravityTorque(SupernovaArm,q);
Tau = inverseDynamics(SupernovaArm,q,qd,qdd);
Tau_check = M*qdd + Cv + G;
%% 4. Results
disp('Inertia Matrix M(q)');
disp('========================================');
disp(M);
disp('Coriolis/Centrifugal Vector');
disp('========================================');
disp(Cv);
disp('Gravity Vector');
disp('========================================');
disp(G);
disp(' ');
disp('Required Joint Torque');
disp('========================================');
disp(Tau);
disp('Checked Joint Torque');
disp('========================================');
disp(Tau_check);
disp('Error');
disp('========================================');
disp(Tau_check-Tau);