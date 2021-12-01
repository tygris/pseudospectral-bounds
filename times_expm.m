%function to calculate the solution of a linear continuous time Dynamical 
% System (DS)
%
%[eA] = times_expm(A, time_step, iterations, perturbation)
%input, A, complex matrix describing the continuous time dynamical system
%          (DS)
%input, time_step, double, the resolution of the time solve of the DS
%input, iterations, integer, the number of times to perform the time step
%          time_step*iterations = time the DS is solved until
%input, perturbation, double vector, the initial conditions for the DS to 
%          find the trajectory of. needs to have the same num of rows as A. 
%output, eA, each column jj is a snapshot of the DS variables at time 
%          jj*time_step for the perturbation's trajectory
%
%[eA] = times_expm(A, time_step, iterations)
%input, A, complex matrix describing the continuous time dynamical system
%          (DS)
%input, time_step, double, the resolution of the time solve of the DS
%input, iterations, integer, the number of times to perform the time step
%          time_step*iterations = time the DS is solved until 
%output, eA, each jj'th entry is the 2-norm of exp(A*t)

%Natalie Wellen
%12/01/21
function eA = times_expm(A, time_step, iterations, perturbation)
    assert(nargin <= 2, "Three inputs are necessary: A, time_step, and the number of iterations.")
    
    %if no perturbation is given assume that we are calculating the norm, or
    % matrix envelope
    if nargin == 3
        eA = ones(1,iterations+1);
        expmA = expm(time_step*A);
        eA(2) = norm(expmA,2);
        last = expmA;
        for j = 3:(iterations+1)
            new = expmA*last;
            eA(j) = norm(new,2);
            last = new;
        end
    %otherwise find the trajectory of the given perturbation
    else nargin == 4
        n = length(perturbation);
        [m1,m2] = size(A);
        if n == m2
            eA = zeros(n,iterations);
            expmA = expm(time_step*A);
            eA(1:n,1) = perturbation;
            for j = 1:iterations
                eA(1:n,j+1) = expmA*eA(1:n,j);
            end
        else
            disp("The perturbation needs to be the same dimension as the DS.")
        end
    end
end