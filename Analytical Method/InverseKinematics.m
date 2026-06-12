%% =========================Inverse Kinematics============================
%  All Dimensions are in mm
%% 1. Setting Parameters and Requirements
% Links Length
  Offset=123; L2=140;  L3=130;  L4=133;
% Given Requirements: P.S. Pitch = Theta2+ Theta3 + Theta 4
  X_pos=200;  Y_pos=200;  Z_pos=300;  Pitch=0; 
%% 2. Getting Joint Variables
Theta_1= atan2d(Y_pos,X_pos);                  % Rotating Base Angle
R=sqrt(X_pos^2+Y_pos^2);                       % Radial Distane
Z_arm= Z_pos-Offset;
%% 3. Getting Arm Wrist
R_w=R-L4*cos(Pitch);
Z_w=Z_arm-L4*sin(Pitch);
D_w=sqrt(R_w^2+Z_w^2);
Theta_3= acosd((D_w^2-L2^2-L3^2)/(2*L2*L3));   % Wrist Angle
%% 4. Getting Shoulder Angle
Theta_2=atan2d(Z_w,R_w)-atan2d(L3*sind(Theta_3),L2+L3*cosd(Theta_3));
%% 5. Getting The last Joint Angle
Theta_4=Pitch-Theta_3-Theta_2;
%% 6. Display Results
fprintf('Inverse Kinematics Solutions\n');
fprintf('[%.2f, %.2f, %.2f, %.2f]\n', Theta_1,Theta_2,Theta_3,Theta_4);