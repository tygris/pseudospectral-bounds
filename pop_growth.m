%Function to calculate the time evolution of a linear dynamical system
% (DS) given an inital condition aka perturbation to the system and to
% compare to the asymptotic growth rate
%
%[val] = pop_growth(eps, max_eig, A, iterations, perturbation, d_or_c, normv, time_step)
%input, eps, error bound for convergence to asymptotic growth
%input, max_eig, the maximum eigenvalue of A
%input, A, square matrix that describes the linear dynamics of the system
%input,iterations, for the number of time steps to iterate from pertubation
%input, perturbation, the initial population vector can also be considered a
%                 perturbation away from equilibirum
%input, d_or_c, 'd' for discrete time or 'c' for continuous time
%input, normv, optional, integer to define the p-norm used when analyzing the system
%output, val, matrix where each row is the population at time = index(*time
%     step)
%
%Natalie Wellen
%10/10/21
function val = pop_growth(eps, max_eig, A, iterations, perturbation, d_or_c, normv, time_step)
    if ~exist('norm', 'var')
        normv = 2; %default Euclidean norm
    end
    if(~exist('time_step', 'var'))
        time_step=1;
    end
    val = pop_iteration(A, iterations, perturbation, d_or_c, time_step); 
    total_pop = vecnorm(val,normv,1); %calculate total change in population
    %once variable time stepping is allowed for continuous time, this will
    %need to be separated as discrete and continuous time
    growthr = log(total_pop(2:(iterations+1)))-log(total_pop(1:iterations)); %rise over run for each time step
    max_growth_rate = exp(max(growthr));
    min_growth_rate = exp(min(growthr));
    %steps_until_convergence_to_asymptotic_rate = find(max_eig-eps < growthr & growthr < max_eig+eps, 1 ) %does the slope ever equal spectral calculation?
    if d_or_c == 'd' %discrete time
        figure
        semilogy(0:iterations, total_pop)
        hold on
        plot(0:iterations, max_eig.^(0:iterations)) %asymptotic growth bound
        hold off
        %steps_until_convergence_to_asymptotic_rate = find(max_eig-eps < growthr & growthr < max_eig+eps, 1 ) %does the slope ever equal spectral calculation?
    elseif d_or_c == 'c' %continuous time 
        figure
        t = 0:time_step:time_step*(iterations);
        size(t);
        semilogy(t, total_pop)
        hold on
        plot(t, exp(max_eig.*(t))) %asympototic growth bound
        hold off
        %steps_until_convergence_to_asymptotic_rate = find(exp(max_eig)-eps < growthr & growthr < exp(max_eig)+eps, 1 ) %does the slope ever equal spectral calculation?
    end 
end