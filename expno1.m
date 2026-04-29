clc;
clear all;
% Input number of buses and lines
n = input('Enter number of buses: ');
l = input('Enter number of lines: ');
s = input('Enter 1 for Impedance or 2 for Admittance input: ');0
% Initialize matrices
ybus = zeros(n, n);
y = zeros(n, n); % To store admittance between buses
lc = zeros(n, n); % Line charging admittance
% Read line data
for i = 1:l
a = input('Starting bus: ');
b = input('Ending bus: ');
t = input('Admittance or Impedance of line: ');
lca = input('Line charging admittance (total for the line): ');
if s == 1
y(a,b) = 1/t; % Convert impedance to admittance
else
y(a,b) = t; % Admittance directly given
end
y(b,a) = y(a,b); % Symmetrical for undirected lines
lc(a,b) = lca;
lc(b,a) = lca;
end
% Construct Ybus matrix
for i = 1:n
for j = 1:n
if i == j
for k = 1:n
ybus(i,j) = ybus(i,j) + y(i,k); % Off-diagonal admittances
if lc(i,k) ~= 0
ybus(i,j) = ybus(i,j) + lc(i,k)/2; % Add half line charging
end
end
else
ybus(i,j) = -y(i,j); % Off-diagonal element is negative admittance
end
end
end
% Display Ybus
disp('Ybus matrix is:');
disp(ybus);