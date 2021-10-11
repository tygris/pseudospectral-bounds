%This script analyzes the non-linear example from Neubert and Caswell 1997
%
%y_1' = y_1*(1-(y_1/k)) - (y_2*y_1)/(1+y_1)
%y_2' = a*((y_2*y_1)/(1+y_1) - b*y_2))
%
%Natalie Wellen
%5/5/21


%% Bifurcation Analysis varying beta
alpha = 0.05;
kappa = 1;
beta = 0;

J = @(beta) [1-2*beta/(kappa*(1-beta)) - (1-beta -beta/kappa), -1*beta;
             alpha*(1-beta-beta/kappa), 0];
         
J0 = J(0); J0p5 = J(0.5); E = norm(J0-J0p5); e = log10(E);

opt.levels = e:-0.25:(e-1.25); opt.ax = [-2.5, 1.5, -2, 2];
eigtool(J0, opt)
title("Beta - J(0)")
eigtool(J0p5, opt)
title("Beta - J(0.5)")

%The goal is to calculate then plot the max real eigenvalue of J as beta
%varies

eig_beta_varied = zeros(1,51);
num_absc_beta_varied = zeros(1, 51);
count = 1;
beta_vec = 0:0.01:0.5;
for beta = beta_vec
    A = J(beta);
    eig_beta_varied(count) = -1* max(eig(A));%max(abs(eig(A)));
    num_absc_beta_varied(count) = max(0.5*eig(A+A'));%norm(A+A.');
    count = count+1;
end
figure;
plot(beta_vec, eig_beta_varied);
hold on
plot(beta_vec, num_absc_beta_varied);
title("Resilience and Reactivity");
hold off
%% After extracting x,y,Z from eigtool for J(0)
Gam_Jb0 = pe_contour(x_J0, y_J0, Z_J0, 10.^opt.levels);
pseudo_lb(Gam_Jb0, 'c')
num_absc_beta_varied(1)

%Extract x,y,Z for max beta value
Jb0p16 = J(0.16);
eigtool(Jb0p16, opt)

%% After extracting x, y, Z from eigtool for J(0.16)
Gam_Jb0p16 = pe_contour(x_Jb0p16, y_Jb0p16, Z_Jb0p16, 10.^opt.levels,0);
pseudo_lb(Gam_Jb0p16, 'c')
num_absc_beta_varied(17)

Gam_Jb0p16 = pe_contour(x_Jb0p16, y_Jb0p16, Z_Jb0p16, 10.^[-0.55, -0.6, -0.65, -0.7, -0.75, -0.8, -0.85],0);
plb_Jb0p16 = pseudo_lb(Gam_Jb0p16, 'c')

%% Plot of the matrix norm (def of rho) with pseudospectral time sensitive lower bounds
iterations = 51;
mnorm_Jb0p16 = zeros(1,iterations);
for j = 1:iterations
    mnorm_Jb0p16(j) = norm(expm(Jb0p16*(j-1)));
end
figure
plot(0:50,mnorm_Jb0p16)
title("Exponential norm of Jb(0.16)")

%Calculate the time bounds
a = cell2mat(Gam_Jb0p16(4)); %using the epsilon with the max lower bound calculated
a = max(real(a));
foo = 1:50;
time_Jb0p16 = exp(a*foo)./(1+ (exp(a*foo)-1)/(a/plb_Jb0p16(1,2)));
hold on 
plot(1:50, time_Jb0p16, 'o')
hold off


%% Vary alpha and hold beta and kappa constant
kappa = 1;
beta = 0.4;
Ja = @(alpha) [1-2*beta/(kappa*(1-beta)) - (1-beta -beta/kappa), -1*beta;
             alpha*(1-beta-beta/kappa), 0];
         
alpha_vec = 0.1:0.1:10;
eig_alpha_varied = zeros(1,100);
num_absc_alpha_varied = zeros(1, 100);
count = 1;
for alpha = alpha_vec
    A = Ja(alpha);
    eig_alpha_varied(count) = -1* max(eig(A));%max(abs(eig(A)));
    num_absc_alpha_varied(count) = max(0.5*eig(A+A'));%norm(A+A.');
    count = count+1;
end
figure;
semilogx(alpha_vec, eig_alpha_varied);
hold on
plot(alpha_vec, num_absc_alpha_varied);
title("Resilience and Reactivity");
hold off

J0p1 = Ja(0.1); J10 = Ja(10); Ea = norm(J0p1-J10); ea = log10(Ea);

opt.levels = ea:-0.25:(ea-1.25); opt.ax = [-3.25, 2.75, -3.5, 3.5];
eigtool(J0p1, opt)
title("Alpha - J(0.1)")
eigtool(J10, opt)
title("Alpha - J(10)")