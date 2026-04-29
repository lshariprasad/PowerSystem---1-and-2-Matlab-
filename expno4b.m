clc;
clear;
e = input('Enter the number of elements (branches): ');
c = input('Enter the number of cutsets: ');
a = zeros(e, c); % Initialize the cutset matrix
for i = 1:e
for j = 1:c
fprintf('\nIs element %d present in cutset %d?\n', i, j);
p = input('Enter 1 for YES, 0 for NO: ');
if p == 1
fprintf('Is element %d directed **along** the direction of cutset %d?\n', i, j);
q = input('Enter 1 for YES, 0 for NO: ');
if q == 1
a(i, j) = 1;
else
a(i, j) = -1;
end
else
a(i, j) = 0;
end
end
end
% Display the cutset matrix
fprintf('\nThe Cutset Matrix is:\n');
for i = 1:e
for j = 1:c
fprintf('%3d\t', a(i,j));
end
fprintf('\n');
end