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
%          jj*time_step for the perturbation's trajectory.
%
%[eA] = times_expm(A, time_step, iterations)
%input, A, complex matrix describing the continuous time dynamical system
%          (DS)
%input, time_step, double, the resolution of the time solve of the DS
%input, iterations, integer, the number of times to perform the time step
%          time_step*iterations = time the DS is solved until 
%output, eA, each jj'th entry is the 2-norm of exp(A*t)
%
%Natalie Wellen
%10/10/21
function eA = for_expm(A, time_step, iterations, perturbation)
    %if no perturbation is given assume that we are calculating the norm, or
    % matrix envelope
    if(~exist('perturbation','var'))
        eA = zeros(1,iterations);
        for j = 1:iterations
            eA(j) = norm(expm(j*time_step*A),2);
        end
    %otherwise find the trajectory of the given perturbation
    else
        D = length(perturbation);
        [m1,m2] = size(A);
        if D == m2
            eA = zeros(D,iterations);
            eA(1:D,1) = perturbation;
            for j = 2:iterations+1
                eA(1:D,j) = expm(j*time_step*A)*perturbation;
            end
        else
            disp("The perturbation needs to be the same dimension as the DS.")
        end
    end
end