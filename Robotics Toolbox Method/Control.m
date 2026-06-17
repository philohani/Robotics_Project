%% 1. Load the Rigid Body Tree Model
numJoints = SupernovaArm.NumBodies - 1; 
Kp = 900;
Kd = 200;
% Time Parameters
dt = 0.01; 
t_end = 2.0;
time = 0:dt:t_end;
% Desired constant state
q_desired   = ones(numJoints, 1); % 1 rad for each joint
dq_desired  = zeros(numJoints, 1);
ddq_desired = zeros(numJoints, 1);
% Initial state
x0 = [zeros(numJoints,1); zeros(numJoints,1)];  % [q; dq]
%% 2. Define the ODE function (derivative of state)
odefun = @(t, x) robotDynamics(t, x, SupernovaArm, q_desired, dq_desired, ddq_desired, Kp, Kd);
% Solve using ode15s (stiff solver, like Simscape)
options = odeset('OutputFcn', @odeplot);  % optional
[t_out, x_out] = ode15s(odefun, time, x0, options);
% Extract q and dq from solution
q_meas_history = x_out(:, 1:numJoints)';
dq_meas_history = x_out(:, numJoints+1:end)';
% q_desired repeated for plotting
q_des_history = repmat(q_desired, 1, length(t_out));
%% 3. Plotting (fix the loop to show all joints)
figure('Name', 'Joint Position Tracking', 'Color', 'w');
for jointIdx = 1:numJoints
    subplot(2,2,jointIdx);  % adjust layout if numJoints >4
    plot(t_out, q_meas_history(jointIdx, :), 'b', 'LineWidth', 2);
    hold on;
    plot(t_out, q_des_history(jointIdx, :), 'r--', 'LineWidth', 1.5);
    title(sprintf('Joint %d: Measured vs Desired', jointIdx));
    xlabel('Time (s)'); ylabel('Angle (rad)');
    legend('Measured', 'Desired', 'Location', 'best');
    grid on;
end
%% Helper functions
function dx = robotDynamics(t, x, robot, q_des, dq_des, ddq_des, Kp, Kd)
    numJoints = length(q_des);
    q  = x(1:numJoints);
    dq = x(numJoints+1:end);
    % Extract dynamics
    M = massMatrix(robot, q);
    V = velocityProduct(robot, q, dq);
    G = gravityTorque(robot, q);
    % Errors
    e  = q_des - q;
    de = dq_des - dq;
    % Control torque (computed torque with PD)
    aq = ddq_des + Kp*e + Kd*de;
    tau = M * aq + V + G;
    % Forward dynamics
    ddq = forwardDynamics(robot, q, dq, tau);
    % State derivative
    dx = [dq; ddq];
end