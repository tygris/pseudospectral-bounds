function eA = for_expm(A, time_step,iterations,perturbation)
    if(~exist('perturbation','var'))
        eA = zeros(1,iterations);
        for j = 1:iterations
            eA(j) = norm(expm(j*time_step*A),2);
        end
    elseif(exist('perturbation','var'))
        D = length(perturbation);
        eA = zeros(D,iterations);
        eA(1:D,1) = perturbation;
        for j = 2:iterations+1
            eA(1:D,j) = expm(j*time_step*A)*perturbation;
        end
    else
        "error!"
    end
end