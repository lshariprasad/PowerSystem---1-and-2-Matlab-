clc;
clear;
y = input('Enter number of elements: ');
l = input('Enter number of loops: ');
% Initialize loop incidence matrix
c = zeros(y, l);
for i = 1:y
for j = 1:l
fprintf('\nIs element %d incident with loop %d?\n', i, j);
r = input('Enter 1 for YES and 0 for NO: ');
if r == 1
fprintf('Is the element %d directed **with** the loop %d?\n', i, j);
s = input('Enter 1 for YES and 0 for NO: ');
if s == 1
c(i, j) = 1;
else
c(i, j) = -1;
end
else
c(i, j) = 0;
end
end
end
fprintf('\nThe Loop Incidence Matrix is:\n');
disp(c);