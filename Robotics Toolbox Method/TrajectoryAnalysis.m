%% 1. Define waypoints (3x7) and corresponding timestamps
waypoints = [0.35690 0.28690 0.00025 0.00025 0.00025 0.28690 0.35690;
             0.00025 0.00025 0.28690 0.35690 0.28690 0.00025 0.00025;
             0.11730 0.23854 0.23854 0.11730 0.23853 0.23854 0.11730];
timePoints = [0, 1, 3, 4, 5, 7, 8];
tVec = 0:0.001:8;
%% 2. Generate quintic polynomial trajectory 
[q, qd, qdd] = quinticpolytraj(waypoints, timePoints, tVec);
%% 3. Plot results
figure('Name', 'Quintic Polynomial Trajectory using Robotics System Toolbox');
% Position
subplot(3,1,1);
plot(tVec, q(1,:), 'b-', 'LineWidth', 1.5); hold on;
plot(tVec, q(2,:), 'r-', 'LineWidth', 1.5);
plot(tVec, q(3,:), 'g-', 'LineWidth', 1.5);
plot(timePoints, waypoints(1,:), 'bo', 'MarkerSize', 6, 'MarkerFaceColor', 'b');
plot(timePoints, waypoints(2,:), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
plot(timePoints, waypoints(3,:), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g');
xlabel('Time (s)'); ylabel('Position');
title('Position vs Time');
legend('x', 'y', 'z', 'Location', 'best');
grid on;
% Velocity
subplot(3,1,2);
plot(tVec, qd(1,:), 'b-', 'LineWidth', 1.5); hold on;
plot(tVec, qd(2,:), 'r-', 'LineWidth', 1.5);
plot(tVec, qd(3,:), 'g-', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Velocity');
title('Velocity vs Time (zero at all waypoints)');
legend('x', 'y', 'z', 'Location', 'best');
grid on;
% Acceleration
subplot(3,1,3);
plot(tVec, qdd(1,:), 'b-', 'LineWidth', 1.5); hold on;
plot(tVec, qdd(2,:), 'r-', 'LineWidth', 1.5);
plot(tVec, qdd(3,:), 'g-', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Acceleration');
title('Acceleration vs Time (zero at all waypoints)');
legend('x', 'y', 'z', 'Location', 'best');
grid on;
% Adjust figure size
set(gcf, 'Position', [100, 100, 800, 600]);