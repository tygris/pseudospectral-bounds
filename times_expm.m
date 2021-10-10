%output changes dimension depending on if there is a perturbation or not
%   without perturbation it is 1 by iteration
function eA = times_expm(A, time_step,iterations,perturbation)
    if(~exist('perturbation','var'))
        eA = ones(1,iterations+1);
        expmA = expm(time_step*A);
        eA(2) = norm(expmA,2);
        last = expmA;
        for j = 3:(iterations+1)
            new = expmA*last;
            eA(j) = norm(new,2);
            last = new;
        end
    elseif(exist('perturbation','var'))
        n = length(perturbation);
        eA = zeros(n,iterations);
        expmA = expm(time_step*A);
        eA(1:n,1) = perturbation;
        for j = 1:iterations
            eA(1:n,j+1) = expmA*eA(1:n,j);
        end
    else
        "error!"
    end
end