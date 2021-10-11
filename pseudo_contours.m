%Script to test methods for extracting specific contours of pseudospectral
%boundaries.
%
%How to get a pseudo epsilon curve as a list of [x; y] coordinates.
%
%The data must be exported from eigtool. If the matrix is being analyzed
%more than once i.e. accross multiple days/sessions, then it is useful to use the
%save() and load() functions built-in to MatLab to avoid extracting the
%data every time.
%
%Natalie Wellen
%10/10/21

A = [-1 5; 0 -2]; % this is the matrix that x, y, Z are measured from
%1. call 'eigtool(A)'
%2. open 'file' in the eigtool figure menu 
%3. click 'Export data... pseduospectra data...'
%4. choose variable names for the x-grid, y-grid, and the matrix which
%   contains ||(z-A)^(-1)|| for z  = x + iy
%   default is x, y, Z, this is what I used.
load('pseudoA_contours.mat');

%Say the contour curve we are interested is 10^-2 to get the x and y values
figure;
cc = contour(x,y,Z, [0.05 0.05]);
x_p05 = cc(1,2:end);
y_p05 = cc(2,2:end);
z_p05 = x_p05+(i*y_p05);

%If we want more than one specific contour level then we can do that all at
%once too
figure
cc = contour(x,y,Z, [0.05 0.1]);
n = cc(2,1) + 1;
x_p05_2 = cc(1,2:n);
y_p05_2 = cc(2,2:n);
x_p1 = cc(1,(n+1):end);
y_p1 = cc(2,(n+1):end);

%Another complication though is that in general for extracting the contours
%we don't know how amny seperate lines there are. For instance if I had
%chosen 10^-2 instead of .05, there would be two contours for the single
%level. I think a while loop could easily handle it though.