%Sonntag
%6.6 The mass rate of flow into a steam turbine is 1.5 kg/s and the heat
%transfer from the turbine is 8.5 kW.  The following data are known for the
%steam entering and leaving the turbine.  Determine the power output of the
%turbine.
% +-----------------------------------+
% |             |  Inlet   |  Outlet  |
% +-----------------------------------+
% | Pressure    |  2.0 MPa |  0.1 MPa |
% | Temperature |  350 C   |   TBF    |
% | Quality     |  --      |   100%   |   
% | Velocity    |  50 m/s  |  100 m/s |
% | Elevation   |  6 m     |   3 m    |
% +-------------+----------+----------+
%
% Aneet Narendranath, PhD (c) 2018
%

%Preamble to clear screen and any variables in the workspace:
%------------------------------------------------------------
clc; %clear console
clear all;

%Given info:
%-----------
% All given info is in table
% Inlet = 1, Outlet = 2
%
P_1 = 2; %MPa
P_1_bar = 2*10; %bar
P_2 = 0.1; %MPa
P_2_bar = 0.1*10; %bar
T_1 = 350; %C
vel_1 = 50; %m/s
vel_2 = 100; %m/s
z_1 = 6; %m
z_2 = 3; %m
g = 9.806; %m/sq.s: acceleration due to gravity
x_2 = 1.0; %Quality
Q_dot = 10.5; %kW
m_dot = 1.5; %kg/s
m_dot_1 = m_dot;
m_dot_2 = m_dot; 

%To find:
%--------
%Power output of the turbine.

%SOLUTION:
%---------
% dEdt = Q_dot - W_dot + m_dot_in*(h_1 + 0.5*vel_1^2 + g*z_1) - m_dot_in*(h_1 + 0.5*vel_1^2 + g*z_1)
% For steady state operation, dEdt = 0
%
h_1 = xsteam('h_pT', P_1_bar, T_1); %kJ/kg
h_2 = xsteam('hV_p', P_2_bar); %kJ/kg

W_dot = Q_dot + m_dot_1*(h_1 + 0.5*vel_1^2/1000 + g*z_1/1000)- m_dot_2*(h_2 + 0.5*vel_2^2/1000 + g*z_2/1000); %kW
save('W_dot.txt', 'W_dot', 'Q_dot', '-ascii');
%eof

