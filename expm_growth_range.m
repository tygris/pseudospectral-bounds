%function to find minimum growth of exp(t*A)
%the goal is to use this function and compare it to the calculated
%pseudospectral lower bound

%I noticed that different perturbations have different growth, so the
%question is is the pseudospectral lower bound actually a tight bound?
%After all transient growth will have a range of possibilities for
%different perturbations, and so far I have only been testing uniform
%perturbations

function narg = expm_growth_range(A, time_step,iterations, nperturbs)
    t = 0:time_step:time_step*iterations;
    figure
    
    n = length(A);
    %uniform perturbation
    perturbation = ones(n,1)/sqrt(n);
    dyn_sys = times_expm(A, time_step, iterations, perturbation);
    plot(t, vecnorm(dyn_sys,2));
    hold on
    %uni-directional perturbations
    for k = 1:n
        perturbation = zeros(n,1);
        perturbation(k) = 1;
        dyn_sys = for_expm(A, time_step, iterations, perturbation);
        plot(t, vecnorm(dyn_sys,2));
    end
    %random strictly positive gaussian perturbations normed to one
    for p = 1:nperturbs
        perturbation = normrnd(0,1,[n,1]);
        perturbation = perturbation - min(perturbation);
        perturbation = perturbation/norm(perturbation,2);
        dyn_sys = times_expm(A, time_step, iterations, perturbation);
        plot(t, vecnorm(dyn_sys,2));
    end
    plot(t, times_expm(A,time_step, iterations), 'k')
    title("Transients of many perturbations")
    xlabel("time")
    ylabel("perturbation 2-norm")
end







%First function tried using SVD to analyze, but honestly not sure how to
%interpret since the max sigma is the norm, but the rest is all
%interaction...
% function sigmas = expm_growth_range(A, time_step,iterations)
%     n = length(A);
%     sigmas = zeros(n,iterations);
%     for j = 1:iterations
%     	expA = expm(j*time_step*A);
%         sigmas(1:n,j) = svd(expA);
%     end
%     t = time_step:time_step:time_step*iterations;
%     semilogy(t, sigmas)
% end
    