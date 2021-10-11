%Function, calculates the lower bound (14.6) from Trefethen and Embree for 
% different values of epsilon 
%
%[vals] = pseudo_lb(Gam, d_or_c)
%input, Gam, is a cell aray of epsilon values and contours for the pseudospectra; output of pe_contour
%input, d_or_c, is 'd' for discrete time DS or 'c' for continuous time DS
%output, vals,  is a table of the 1/eps value and the lower bound of the
%        max part of the dynamical system implied by that epsilon value
%
%Natalie Wellen
%10/10/21
function vals = pseudo_lb(Gam, d_or_c)
    %Every other entry of Gam is the size of epsilon
    n = length(Gam);
    vals = zeros(2,n/2);
    eps = cell2mat(Gam(1:2:(n-1))); %saved in every other cell of pe_contour output
    eps = eps(1,1:end); % epsilon value is the first row, length of contour is the second
    vals(1, 1:n/2) = eps(1:n/2); %save epsilon value as first row of output
    
    %calculate the lower bound from the pseudospectra
    if d_or_c == 'd' %discrete time system
    for j = 1:(n/2)
        g = cell2mat(Gam(2*j)); %extract list of contour points/curves
        radius = max(abs(g));
        if radius >= 1          %lower bound is only for ps>1, ignore others
            vals(2, j) = (radius-1)*(radius/(eps(j)-1)); % bound (14.24) in T & E 2005
        else
            vals(2,j) = nan;
        end
    end
    elseif d_or_c == 'c'    %continuous time
        for j = 1:(n/2)
            g = cell2mat(Gam(2*j)); %extract contour points
            abscissa = max(real(g)) 
            if abscissa>0    %bound is only relevant for ps>0
                vals(2,j) = abscissa/eps(j); % bound (14.6) in T & E 2005
            else
                vals(2,j) = nan;
            end
        end
    end
end
   