%iterations, input for the number of time steps to iterate from pertubation
%perturbation, input, the initial population vector can also be considered a
%                 perturbation away from equilibirum
%A, input square matrix that describes the linear dynamics of the system
%d_or_c, input 'd' for discrete time or 'c' for continuous time
%pop, output matrix where each row is the population at time = index(*time
%     step)
function pop = pop_iteration(iterations, perturbation, A, d_or_c, time_step)
    n = length(A);
    pop = zeros(n, iterations+1); %output matrix
    pop(1:n, 1) = perturbation; %save initial value
    if(~exist('time_step', 'var'))
        time_step=1;
    end
    if d_or_c == 'd' %discrete time
        for j = 2:iterations+1
            perturbation = A*perturbation; %iterate the sytem forward one time step
            pop(1:n,j) = perturbation;
        end
    elseif d_or_c == 'c' %continuous time
        t = time_step:time_step:time_step*(iterations+1);
        expA = expm(time_step*A); %calculate e^A (implicitly makes the time step = 1)
        for j = 2:iterations
            perturbation = expA*perturbation; %move the dyn sys one time step forward
            pop(1:n,j) = perturbation;
        end
    else
        "Error: You need to indicate 'd' for discrete time or 'c' for continuous time."
    end
end
