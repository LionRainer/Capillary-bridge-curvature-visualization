function[M_zra] = makepolar(M_xyz)

% Extract x, y, and z coordinates
x = M_xyz(:, 1);
y = M_xyz(:, 2);
z = M_xyz(:, 3);

% Calculate radius (r) and angle (theta)
r = sqrt(x.^2 + y.^2);
theta = pi + atan2(y, x);

% Create the polar coordinates matrix M_zra
M_zra = [z, r, theta];
