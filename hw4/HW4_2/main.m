% Edit from Seb Madgwick and Raimondas Pomarnacki
%% Start of script

addpath('quaternion_library');      % include quaternion library
close all;                          % close all figures
clear all;                          % clear all variables
clc;                                % clear the command terminal

%% Import and plot sensor data

load('HW_5_data.mat');

figure('Name', 'Sensor Data');
axis(1) = subplot(1,1,1);
hold on;
plot(time, Accelerometer(:,1), 'r');
plot(time, Accelerometer(:,2), 'g');
plot(time, Accelerometer(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (g)');
title('Accelerometer');
hold off;
linkaxes(axis, 'x');

%% Process sensor data through Madgwic algorithm

AHRS = MadgwickAHRS('SamplePeriod', 1/300, 'Beta', 0.033);
quaternion = zeros(length(time), 4);
for t = 1:length(time)
    AHRS.UpdateIMU(Accelerometer(t,:));	% gyroscope units must be radians
    % AHRS.UpdateIMU(Gyroscope(t,:) * (pi/180), Accelerometer(t,:));	
    quaternion(t, :) = AHRS.Quaternion;
end

%% Plot algorithm output as Euler angles

euler = quatern2euler(quaternConj(quaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.
E = [0,0,0,-9.8];
q_inv=quatinv(quaternion);
q_plot=quatmultiply(q_inv, E);
q_plot=quatmultiply(q_plot,quaternion );
figure('Name', 'AUV Euler angle');
hold on;
plot(time, euler(:,1), 'r');
plot(time, euler(:,2), 'g');
plot(time, euler(:,3), 'b');
title('AUV Euler angles');
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('\phi', '\theta', '\psi');
hold off;

figure('Name', 'AUV trajctory');
hold on;
plot3(q_plot(:,1),q_plot(:,2),q_plot(:,3));