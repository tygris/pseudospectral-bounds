%eps, input error bound for convergence to asymptotic growth
%max_eig, input the maximum eigenvalue of A
%iterations, input for the number of time steps to iterate from pertubation
%perturbation, input, the initial population vector can also be considered a
%                 perturbation away from equilibirum
%A, input square matrix that describes the linear dynamics of the system
%d_or_c, input 'd' for discrete time or 'c' for continuous time
%normv, optional input integer to define the p-norm used when analyzing the system
%val, output matrix where each row is the population at time = index(*time
%     step)
function val = pop_growth(eps, max_eig, iterations, perturbation, A, d_or_c, normv, time_step)
    if ~exist('norm', 'var')
        normv = 2; %default Euclidean norm
    end
    if(~exist('time_step'))
        time_step=1;
    end
    val = pop_iteration(iterations, perturbation, A, d_or_c, time_step); 
    total_pop = vecnorm(val,normv,1); %calculate total change in population
    %once variable time stepping is allowed for continuous time, this will
    %need to be separated as discrete and continuous time
    growthr = log(total_pop(2:iterations))-log(total_pop(1:iterations-1)); %rise over run for each time step
    max_growth_rate = exp(max(growthr))
    min_growth_rate = exp(min(growthr))
    %steps_until_convergence_to_asymptotic_rate = find(max_eig-eps < growthr & growthr < max_eig+eps, 1 ) %does the slope ever equal spectral calculation?
    figure
    semilogy(total_pop)
    if d_or_c == 'd' %discrete time
        hold on
        plot(1:iterations, max_eig.^(0:iterations-1)) %asymptotic growth bound
        hold off
        %steps_until_convergence_to_asymptotic_rate = find(max_eig-eps < growthr & growthr < max_eig+eps, 1 ) %does the slope ever equal spectral calculation?
    elseif d_or_c == 'c' %continuous time 
        hold on
        plot(1:iterations, exp(max_eig.*(0:iterations-1))) %asympototic growth bound
        hold off
        %steps_until_convergence_to_asymptotic_rate = find(exp(max_eig)-eps < growthr & growthr < exp(max_eig)+eps, 1 ) %does the slope ever equal spectral calculation?
    end

    
end