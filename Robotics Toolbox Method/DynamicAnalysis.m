%% 1. Assign Dynamic Properties to SupernovaArm
SupernovaArm.DataFormat='column';
masses = [0.17, 0.15623, 0.15443, 0.19014];
I{1} = [222364.10,   503.01,   4909.49;
           503.01,237697.08, 21236.13;
          4909.49, 21236.13,213106.79] * 1e-9;
I{2} = [408579.31,17507.74,0;
         17507.74,59808.96,-0.05;
         0,-0.05,434533.61] * 1e-9;
I{3} = [354064.76,15434.47,0;
         15434.47,59679.89,-0.04;
         0,-0.04,380063.53] * 1e-9;
I{4} = [331327.56,-72734.27,-2635.64;
         -72734.27,193326.46,-18877.39;
         -2635.64,-18877.39,401879.53] * 1e-9;
%% 2. Assign Dynamics
for k = 1:4
    body = SupernovaArm.Bodies{k};
    % Mass
    body.Mass = masses(k);
    % COM at Joint Frame
    body.CenterOfMass = [0 0 0];
    % Convert 3x3 inertia tensor to Robotics Toolbox format:
    % [Ixx Iyy Izz Iyz Ixz Ixy]
    body.Inertia = [I{k}(1,1), I{k}(2,2), I{k}(3,3), I{k}(2,3), I{k}(1,3),I{k}(1,2)];
end
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
disp('========================================');
disp('Inertia Matrix M(q)');
disp('========================================');
disp(M);
disp(' ');
disp('========================================');
disp('Coriolis/Centrifugal Vector');
disp('========================================');
disp(Cv);
disp(' ');
disp('========================================');
disp('Gravity Vector');
disp('========================================');
disp(G);
disp(' ');
disp('========================================');
disp('Required Joint Torque');
disp('========================================');
disp(Tau);