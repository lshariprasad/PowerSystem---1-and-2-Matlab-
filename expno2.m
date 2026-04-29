clc;
clear all;
n = input('Enter number of buses: ');
l = input('Enter number of lines: ');
s = input('Enter 1 for Impedance or 2 for Admittance: ');
% Initialize matrices
y = zeros(n, n); % Mutual admittances
lc = zeros(n, n); % Line charging admittances
ybus = zeros(n, n); % Bus admittance matrix
% Read line data
for i = 1:l
a = input('Starting bus: ');
b = input('Ending bus: ');
t = input('Admittance or Impedance of line: ');
lca = input('Line charging admittance (total for the line): ');
if s == 1
y(a,b) = 1/t; % Convert impedance to admittance
else
y(a,b) = t; % Use admittance directly
end
y(b,a) = y(a,b); % Symmetry
lc(a,b) = lca;
lc(b,a) = lca; % Symmetry
end
% Construct Ybus
for i = 1:n
for j = 1:n
if i == j
for k = 1:n
ybus(i,j) = ybus(i,j) + y(i,k) + lc(i,k)/2;
end
else
ybus(i,j) = -y(i,j);
end
end
end
% Display Ybus
disp('Ybus matrix is:');
disp(ybus);
% Calculate and display Zbus (inverse of Ybus)
zbus = inv(ybus); % Better numerically than using ybus^(-1)
disp('Zbus matrix is:');
disp(zbus);