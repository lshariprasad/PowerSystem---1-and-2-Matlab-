clc;
clear;
n = input('Enter the number of nodes: ');
e = input('Enter the number of elements: ');
a = zeros(e, n); % Initialize incidence matrix
% Input incidence details using GUI menu
for i = 1:e
for j = 1:n
fprintf('\nSelect the incidence of element %d with node %d:\n', i, j);
reply = menu('Choice', 'Incident Away', 'Incident Towards', 'Not Incident');
if reply == 1
a(i,j) = 1;
elseif reply == 2
a(i,j) = -1;
else
a(i,j) = 0;
end
end
end
ref = input('\nEnter the reference node number: ');
% Display the reduced bus incidence matrix
fprintf('\nThe reduced bus incidence matrix is:\n');
for i = 1:e
for j = 1:n
if j ~= ref
fprintf('%3d\t', a(i,j));
end
end
fprintf('\n');
end