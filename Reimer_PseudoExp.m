%% Simulations of the Arctic Seal population MC's described in Reimer 2019
clear; clc; close all;
%% Define the population dynamic matrices
% error bound for convergence to asymptotic growth rate (used later)
eps = 10^-12;

%Only fertility rates vary depending on the snowfall and icepack
m0 = [0.08428 0.12672 0.1755 0.37352];
m1 = [0.0731 0.11 0.1521 0.32384];
m2 = [0.03956 0.05896 0.0819 0.17296];
m3 = [0.03612 0.05456 0.0756 0.161];

%define the Leslie matrices for the four different environment conditions
A = diag([0.65 0.8 0.82 0.84 0.86 0.88 0.9], -1); A(8,8) =  0.92;
A0 = A; A0(1,5:8) = m0;
A1 = A; A1(1,5:8) = m1;
A2 = A; A2(1,5:8) = m2;
A3 = A; A3(1,5:8) = m3;

%Calculate the spectral abscissa of each matrix
lam_a = zeros(1,4);
lam_a(1) = max(eig(A0));
lam_a(2) = max(eig(A1));
lam_a(3) = max(eig(A2));
lam_a(4) = max(eig(A3));


%% Eigtool
close all; clear opts 

%zoomed out picture of the most non-normal system
opts.levels = -1*(0.2:.2:1.6); opts.unit_circle = 1; opts.fov=1;
eigtool(A3, opts)
title("A3")

%system ideal for exporting the pseudospectra information for A3
opts.levels = -1*(0.2:.2:1.6); opts.ax = [0.8, 1.8, -0.65, 0.65]; opts.fov=0;
eigtool(A3,opts)
title("A3")

%ideal for exporting the pseudospectra radius of A2
eigtool(A2, opts)
title("A2")
%ideal for exporting the pseudospectra radius of A1
eigtool(A1, opts)
title("A1")
%ideal for exporting the pseudospectra radius of A0
eigtool(A0, opts)
title("A0")

%% Analyze bounds on ||A^k|| for A3
Gam0 = pe_contour(x0,y0,Z0,10.^[-1.6, -1.4, -1.2, -1, -.8, -0.6, -0.4, -0.2], 0);
"lower bound of growth for the matrix A0"
lam_a(1) 
pseudo_lb(Gam0,'d')  %Note that the max eigenvalue is >1

Gam1 = pe_contour(x1,y1,Z1,10.^[-1.6, -1.4, -1.2, -1, -.8, -0.6, -0.4, -0.2], 0);
"lower bound of growth for the matrix A1"
lam_a(2) 

pseudo_lb(Gam1,'d') %Note that the max eigenvalue is >1

Gam2 = pe_contour(x2,y2,Z2,10.^[-1.6, -1.4, -1.2, -1, -.8, -0.6, -0.4, -0.2], 0);
"lower bound of growth for the matrix A2"
pseudo_lb(Gam2,'d')

Gam3 = pe_contour(x3,y3,Z3,10.^[-1.6, -1.4, -1.2, -1, -.8, -0.6, -0.4, -0.2], 0);
"lower bound of growth for the matrix A3"
pseudo_lb(Gam3,'d')

%% A0: Look at actual dynamical system behavior
total_pop0 = pop_growth(eps, lam_a(1), 100, ones(8,1)/sqrt(8), A0, 'd', 2);
%% A1: Look at actual dynamical system behavior
total_pop1 = pop_growth(eps, lam_a(2), 100, ones(8,1)/sqrt(8), A1, 'd', 2);
%% A2: Look at actual dynamical system behavior
total_pop2 = pop_growth(eps, lam_a(3), 100, ones(8,1)/sqrt(8), A2, 'd', 2);
%% A3: Look at actual dynamical system behavior
total_pop3 = pop_growth(eps, lam_a(4), 100, ones(8,1)/sqrt(8), A3, 'd', 2);

