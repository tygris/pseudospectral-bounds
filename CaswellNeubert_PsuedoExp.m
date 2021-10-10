%% Example 1 in the Caswell and Neubert 1997 paper
%for bounding convergence to asymptotic rate
eps = 10^-3;

%data matrix for example 1 from the paper
A_CN = [-1.5622, 0.6685,0,0,0,0,0,0,0;
     0, -0.7119,0,0,2.5632,0,0,0,0;
     1.4627, 0.0364, -6.4091,0,0,1.1446,0,55.8201,17.2972;
     0,0,0,-0.0222,0,0,315.9443,0,0;
     0,0,0,0.0201,-2.5632,0,0,0,0;
     0,0.0070,0,0,0,-2.0348,0,0,0;
     0,0,6.4091,0,0,0,-315.9443,0,0;
     0.0995,0,0,0,0,0.8902,0,-62.6458,0;
     0,0,0,0,0,0,0,6.8257,-17.2972];
 
% calculate the numerical abscissa of the matrix
 HA_CN = (A_CN+A_CN')/2;
 num_abscissa_CN = max(eig(HA_CN))

eigtool(A_CN)
% eigtool with boundaries predefined as ideal for extracting the abscissa
opts.levels = -1*(0.25:.25:1.75); opts.ax = [-0.5, 2, -1, 1]; opts.npts = 200;
eigtool(A_CN,opts)
 %% After exporting the data from eigtool
 %1. Click file in the eigtool gui
 %2. Export...
 %3. Pseudospectra data
 %4. Name all three variables appropriately for following code and ease of
 %    switching between matrices

%Calculate the pseudospectral lower bound of growth
Gam_CN = pe_contour(x_CN,y_CN,Z_CN,10.^[-1.75 -1.5 -1.25 -1 -0.75 -0.5 -0.25], 0);
"lower bound of growth for the matrix A_CN"
%pseudo_lb(Gam_CN,'c')
lb_CN = pseudo_lb(Gam_CN,'c')


% And look at the plots comparing the asymptotic behavior to actual
%   transients
lam_CN = max(eig(A_CN))
iterations = 100;
n = length(A_CN);
perturbation = ones(n,1)/sqrt(n); 
total_population_CN = pop_growth(eps, lam_CN, 100, ones(9,1)/sqrt(9), A_CN, 'c', 2);
%title("Perturbation of norm 1")
xlabel("time in years")
ylabel("logarithmic scale of ||exp(tA)||")
legend("Actual model behavior", "Expected asymptotic growth", 'Location', 'east')
hold on

%Include time estimates from equation 14.13 T and E
tao = 1:100;
time_bound = exp(lb_CN(2,2)*lb_CN(1,2)*tao)./(1+(exp(lb_CN(2,2)*lb_CN(1,2)*tao)-1)/lb_CN(2,2));
plot(tao, time_bound,'o', 'DisplayName', 'lower-bound for previous time-steps')
%Include the 2-norm of exp(At) in the plot
dyn_sys = times_expm(A_CN, 1, iterations);
plot(0:100, dyn_sys,'-k','DisplayName','Matrix Envelope');
max_growth_of_A_CN = max(dyn_sys)
hold off






%% Second example from the Caswell Nuebert paper
A_cn2_1984 = [-0.9503,0,0.0130,0.0056, 0.0257;
         0.95, -0.59,0,0,0;
         0, 0.029, -0.2622,0,0;
         0,0,0.2, -0.1752,0;
         0,0,0.0192, 0.0026, -0.0389];

A_cn2_1986 = [-0.9503,0,0.0690,0.0002, 0.0027,0.0034;
         0.95, -0.18,0,0,0,0;
         0, 0.15, -0.2569,0,0,0;
         0,0,0.100, -0.0138,0,0;
         0,0,0.0019, 0.0002, -0.0124,0;
         0,0,0,0.0001, 0.0028, -0.0049];


% for calculating the numerical abscissa of matrix 2
HA_cn2_1984 = (A_cn2_1984+A_cn2_1984')/2;

% for calculating the numerical abscissa of matrix 3
HA_cn2_1986 = (A_cn2_1986+A_cn2_1986')/2;

clear opts %delete previous bounds for matrix 1
eigtool(A_cn2_1984)
title("1984")
eigtool(A_cn2_1986)
title("1986")

% eigtool with boundaries ideal for extracting the abscissa
opts.levels = -1*(0.2:.2:1.6); opts.ax = [-0.1, 0.8, -0.45, 0.45]; opts.npts = 100;
eigtool(A_cn2_1984,opts)
title("1984")
%opts.ax = [-0.1, 0.2, -0.15, 0.15];
eigtool(A_cn2_1986,opts)
title("1986")

%% After exporting the data from eigtool

%numerical abscissa
num_abscissa_cn2_1984 = max(eig(HA_cn2_1984))

%Calculate the pseudospectral lower bound of growth
Gam_cn2_1984 = pe_contour(x_cn2_1984,y_cn2_1984,Z_cn2_1984,10.^[-1*(0.2:.2:1.6)], 0); %extract contours as vector of points
"lower bound of growth for the matrix A_cn2_1984"
pseudo_lb(Gam_cn2_1984,'c') %print table of minumum transiant growth

% And look at the plots comparing the asymptotic behavior to actual
%   transients
lam_cn2_1984 = max(eig(A_cn2_1984))
iterations = 200;
n = length(A_cn2_1984);
perturbation = ones(n,1)/sqrt(n); %norm 1 vector
total_population_CN = pop_growth(eps, lam_cn2_1984, iterations, perturbation, A_cn2_1984, 'c', 2);

%Repeat for the third matrix example
%numerical abscissa
num_abscissa_cn2_1986 = max(eig(HA_cn2_1986))

%Calculate the pseudospectral lower bound of growth
Gam_cn2_1986 = pe_contour(x_cn2_1986,y_cn2_1986,Z_cn2_1986,10.^[-1*(0:.2:1.6)], 0);
"lower bound of growth for the matrix A_cn2_1986"
%pseudo_lb(Gam_cn2_1986,'c')
lb_1986 = pseudo_lb(Gam_cn2_1986,'c')


% And look at the plots comparing the asymptotic behavior to actual
%   transients for 1986
lam_cn2_1986 = max(eig(A_cn2_1986))
n = length(A_cn2_1986);
perturbation = ones(n,1)/sqrt(n); 
total_population_CN = pop_growth(eps, lam_cn2_1986, iterations, perturbation, A_cn2_1986, 'c', 2, 0.1);
%title("Perturbation of 1986 Model, norm 1")
xlabel("time in days")
ylabel("logarithmic scale of ||exp(tA)||")
legend("Actual model behavior", "Expected asymptotic growth", 'Location', 'southwest')
hold on

%Incluude time estimates from equation 14.13 T and E
tao = 1:20;
time_bound = exp(lb_1986(2,8)*lb_1986(1,8)*tao)./(1+(exp(lb_1986(2,8)*lb_1986(1,8)*tao)-1)/lb_1986(2,8));
plot(tao, time_bound,'o', 'DisplayName', 'lower-bound for previous time-steps')
%Include the 2-norm of exp(At) in the plot
time_step = 0.1;
iterations2 = 20/time_step;
dyn_sys = times_expm(A_cn2_1986, time_step, iterations);
plot((0:time_step:20),dyn_sys,'-k','DisplayName','Matrix Envelope');
hold off
max_growth_of_A_cn2_1986 = max(dyn_sys)


%% Example 2 matrix norm (envelope)

semilogy(times_expm(A_cn2_1984,0.1,200))
legend("matrix envelope")
title("1984")

%% Example 2 matrix norm (envelope)
iterations = 10;
mnorm_cn2_1986 = zeros(1,iterations);
for j = 1:iterations+1
    mnorm_cn2_1986(j) = norm(expm(A_cn2_1986*(j-1)));
end
figure
plot(mnorm_cn2_1986)
