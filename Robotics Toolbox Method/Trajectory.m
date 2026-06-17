%% 1. Define the Extracted Waypoints Matrix (X, Y, Z rows)
Waypoints = [0.35690 0.28690 0.00025 0.00025 0.00025 0.28690 0.35690;
             0.00025 0.00025 0.28690 0.35690 0.28690 0.00025 0.00025;
             0.11730 0.23854 0.23854 0.11730 0.23853 0.23854 0.11730];
% Define the specific timestamps for each waypoint
t_waypoints = [0, 1, 3, 4, 5, 7, 8];
[num_axes, num_points] = size(Waypoints);
num_segments = num_points - 1;
% Timing Parameters
dt = 0.01;        % Resolution of the plot (time step)
time_total = [];
pos_total = [];
vel_total = [];
acc_total = [];
%% 2. Calculate Trajectories Segment by Segment
for i = 1:num_segments
    q0 = Waypoints(:, i);
    q1 = Waypoints(:, i+1);
    % Calculate the specific duration for this segment
    T_seg = t_waypoints(i+1) - t_waypoints(i);
    % Time vector for current segment
    t = 0:dt:T_seg;
    tau = t / T_seg; % Normalized time [0 to 1]
    % Preallocate segment matrices
    pos = zeros(num_axes, length(t));
    vel = zeros(num_axes, length(t));
    acc = zeros(num_axes, length(t));
    % Apply Quintic Equations for X, Y, and Z
    for j = 1:num_axes
        dq = q1(j) - q0(j);
        % Calculate Position, Velocity, and Acceleration
        pos(j, :) = q0(j) + dq * (10*tau.^3 - 15*tau.^4 + 6*tau.^5);
        vel(j, :) = (dq / T_seg) * (30*tau.^2 - 60*tau.^3 + 30*tau.^4);
        acc(j, :) = (dq / T_seg^2) * (60*tau - 180*tau.^2 + 120*tau.^3);
    end    
    % Append to the total arrays
    % Shift the time vector by the absolute start time of the segment
    time_total = [time_total, t_waypoints(i) + t(1:end-1)];
    pos_total = [pos_total, pos(:, 1:end-1)];
    vel_total = [vel_total, vel(:, 1:end-1)];
    acc_total = [acc_total, acc(:, 1:end-1)];
end
% Add the very final point to cap off the arrays
time_total = [time_total, t_waypoints(end)];
pos_total  = [pos_total, Waypoints(:, end)];
vel_total  = [vel_total, zeros(num_axes, 1)];
acc_total  = [acc_total, zeros(num_axes, 1)];
%% 3. Visualization: Motion Profiles
figure('Name', 'Quintic Motion Profiles', 'Position', [100, 100, 800, 800]);
% Position Plot
subplot(3, 1, 1);
plot(time_total, pos_total(1,:), 'r', 'LineWidth', 1.5); hold on;
plot(time_total, pos_total(2,:), 'g', 'LineWidth', 1.5);
plot(time_total, pos_total(3,:), 'b', 'LineWidth', 1.5);
% Plot the actual waypoints on top of the curves to verify timestamps
plot(t_waypoints, Waypoints(1,:), 'ro', 'MarkerFaceColor', 'r');
plot(t_waypoints, Waypoints(2,:), 'go', 'MarkerFaceColor', 'g');
plot(t_waypoints, Waypoints(3,:), 'bo', 'MarkerFaceColor', 'b');
title('Position Profile');
ylabel('Position (m)');
legend('X', 'Y', 'Z', 'Location', 'best');
grid on;
% Velocity Plot
subplot(3, 1, 2);
plot(time_total, vel_total(1,:), 'r', 'LineWidth', 1.5); hold on;
plot(time_total, vel_total(2,:), 'g', 'LineWidth', 1.5);
plot(time_total, vel_total(3,:), 'b', 'LineWidth', 1.5);
title('Velocity Profile');
ylabel('Velocity (m/s)');
legend('X', 'Y', 'Z', 'Location', 'best');
grid on;
% Acceleration Plot
subplot(3, 1, 3);
plot(time_total, acc_total(1,:), 'r', 'LineWidth', 1.5); hold on;
plot(time_total, acc_total(2,:), 'g', 'LineWidth', 1.5);
plot(time_total, acc_total(3,:), 'b', 'LineWidth', 1.5);
title('Acceleration Profile');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
legend('X', 'Y', 'Z', 'Location', 'best');
grid on;