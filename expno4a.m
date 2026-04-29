clc;
clear;
n = input('Enter number of nodes: ');
b = input('Enter number of branches: ');
k = zeros(b, n); % Initialize incidence matrix
for i = 1:b
for j = 1:n
fprintf('\nIs node %d connected to branch %d?\n', j, i);
p = input('Enter 1 for YES, 0 for NO: ');
if p == 1
fprintf('Is the direction of branch %d **towards** node %d?\n', i, j);
q = input('Enter 1 for YES, 0 for NO: ');
if q == 1
k(i,j) = 1;
else
k(i,j) = -1;
end
else
k(i,j) = 0;
end
end
end
% Display the branch-node incidence matrix
fprintf('\nThe Branch-Path Incidence Matrix is:\n');
for i = 1:b
for j = 1:n
fprintf('%3d\t', k(i,j));
end
fprintf('\n');
end