function V = gauss_seidel_loadflow()

% Gauss-Seidel Load Flow for the given 3-bus system

% Ybus matrix
Z = [ 0 0.02+1i*0.04 0.01+1i*0.03;
0.02+1i*0.04 0 0.0125+1i*0.025;
0.01+1i*0.03 0.0125+1i*0.025 0 ];

n = 3;

Ybus = zeros(n,n);

% Build Ybus
for k = 1:3
for m = 1:3
if k ~= m && Z(k,m) ~= 0
Ybus(k,k) = Ybus(k,k) + 1/Z(k,m);
Ybus(k,m) = -1/Z(k,m);
end
end
end

% Known bus voltages
V = ones(n,1);
V(1) = 1.05 + 0j; % Slack bus with 0 angle

% Load data (PD, QD) in p.u.
P = [0; -2.566; -1.386]; % Negative since it is load
Q = [0; -1.102; -0.452];

% Convergence tolerance
tol = 1e-6;
max_iter = 100;

% Gauss-Seidel iteration
for iter = 1:max_iter
V_old = V;
for i = 2:n
sumYV = 0;
for j = 1:n
if j ~= i
sumYV = sumYV + Ybus(i,j)*V(j);
end
end
S = P(i) + 1i*Q(i);
V(i) = (1/Ybus(i,i)) * ((conj(S)/conj(V(i))) - sumYV);
end
if max(abs(V - V_old)) < tol
fprintf('Gauss-Seidel converged in %d iterations\n', iter);
break;
end
end

% Output
fprintf('\nBus Voltages (magnitude and angle):\n');
for i = 1:n
fprintf('Bus %d: |V| = %.4f, Angle = %.4f degrees\n', i, abs(V(i)), angle(V(i))*180/pi);
end