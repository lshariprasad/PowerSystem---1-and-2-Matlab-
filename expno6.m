% Newton-Raphson Load Flow for the given 3-bus system

clc; clear;

%% Bus Types:
% 1 - Slack
% 2 - PV
% 3 - PQ

% System base
baseMVA = 100;

% Number of buses
nb = 3;

% Bus type: 1-Slack, 2-PV, 3-PQ
bus_type = [1; 2; 3];

% Given power data (in per unit)
P = [0; -4.0; -6.0]; % PG - PD in pu
Q = [0; 0.0; -4.0]; % QG - QD in pu (initial guess for PV)

% Initial voltage magnitude and angle (in radians)
V = [1.01; 1.03; 1.00];
delta = [0; 0; 0];

% Admittance Matrix (Ybus)
Z = zeros(nb, nb);
Y = zeros(nb);

% Line admittances (in pu)
Y(1,2) = -1j*5; % 1-2 line: 0+j0.2
Y(2,3) = -1/(0.02+1j*0.04); % 2-3 line
Y(2,3) = Y(2,3) + (-1/(0.05+1j*0.025)); % Parallel line 2-3
Y(1,3) = 0; % No direct connection

% Off-diagonal elements
Y(2,1) = Y(1,2);
Y(3,2) = Y(2,3);

% Diagonal elements
for i = 1:nb
for j = 1:nb
if i ~= j
Y(i,i) = Y(i,i) - Y(i,j);
end
end
end

% Start NR iteration
max_iter = 10;
epsilon = 1e-6;

PQ_idx = find(bus_type == 3);
PV_idx = find(bus_type == 2);

for iter = 1:max_iter
% Calculate P and Q from current voltages
P_calc = zeros(nb,1);
Q_calc = zeros(nb,1);
for i = 1:nb
for k = 1:nb
P_calc(i) = P_calc(i) + V(i)*V(k)*(real(Y(i,k))*cos(delta(i)-delta(k)) + imag(Y(i,k))*sin(delta(i)-delta(k)));
Q_calc(i) = Q_calc(i) + V(i)*V(k)*(real(Y(i,k))*sin(delta(i)-delta(k)) - imag(Y(i,k))*cos(delta(i)-delta(k)));
end
end

dP = P(2:3) - P_calc(2:3);
dQ = Q(3) - Q_calc(3);
mismatch = [dP; dQ];

if max(abs(mismatch)) < epsilon
break;
end

% Jacobian submatrices (only 2 unknowns in this case)
J11 = zeros(2);
J22 = zeros(1);
J12 = zeros(2,1);
J21 = zeros(1,2);

for i = 2:3
for k = 2:3
if i == k
for m = 1:nb
J11(i-1,k-1) = J11(i-1,k-1) + V(i)*V(m)*(-real(Y(i,m))*sin(delta(i)-delta(m)) + imag(Y(i,m))*cos(delta(i)-delta(m)));
end
J11(i-1,k-1) = J11(i-1,k-1) - V(i)^2 * imag(Y(i,i));
else
J11(i-1,k-1) = V(i)*V(k)*(real(Y(i,k))*sin(delta(i)-delta(k)) - imag(Y(i,k))*cos(delta(i)- delta(k)));
end
end
end

for i = 3
for k = 3
if i == k
for m = 1:nb
J22(i-2,k-2) = J22(i-2,k-2) + V(i)*(real(Y(i,m))*cos(delta(i)-delta(m)) + imag(Y(i,m))*sin(delta(i)-delta(m)));
end
J22(i-2,k-2) = J22(i-2,k-2) + V(i)*real(Y(i,i));
else
J22(i-2,k-2) = V(i)*(-real(Y(i,k))*cos(delta(i)-delta(k)) - imag(Y(i,k))*sin(delta(i)- delta(k)));
end
end
end

for i = 2:3
J12(i-1) = V(i)*real(Y(i,3))*cos(delta(i)-delta(3)) + imag(Y(i,3))*sin(delta(i)-delta(3));
end

for i = 3
for k = 2:3
J21(1,k-1) = V(i)*(real(Y(i,k))*cos(delta(i)-delta(k)) + imag(Y(i,k))*sin(delta(i)-delta(k)));
end
end

% Construct Jacobian
J = [J11 J12; J21 J22];

% Solve for corrections
dx = J\mismatch;

delta(2:3) = delta(2:3) + dx(1:2);
V(3) = V(3) + dx(3);
end

% Print Results
fprintf('Converged in %d iterations\n', iter);
for i = 1:nb
fprintf('Bus %d: V = %.4f p.u., Angle = %.4f deg\n', i, V(i), rad2deg(delta(i)));
end