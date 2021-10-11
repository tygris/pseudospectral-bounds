%This function takes as input exported data from eigtool and the desired
%eps^(-1) value of the contours to extract the pseudospectral boundaries of
%a matrix
%
%[C] = pe_contour(x,y,Z, eps_vec, show_plt)
%input, x, double vector, the x-coordinates for the pseudospectral grid
%input, y, double vector, the y-coordinates for the pseudospectral grid
%input, Z, complex matrix, the pseudospectral value at z = x + 1i*y
%input, eps_vec, double vector, list of contours to extract from the
%      pseudospectral grid 
%  Note that even if eps_vec only has one level of epsilon, it needs to be
%      listed twice due to the contour function
%input, show_plot, optional binary argument, 0 = no plots as output and 
%      1 = show both plots. No input means that only the contours are
%      plotted
%output, C, a cell array where each odd numbered cell gives the
%epsilon value and the number of elements, and each even numbered cell
%contains the vector of imaginary numbers defining the contour
%
%Natalie Wellen
%10/10/21
function C = pe_contour(x,y,Z, eps_vec, show_plt)
figure
cc = contour(x,y,Z,eps_vec); %get the contour map for all of the levels in eps_vec
if(exist('show_plt'))
    if show_plt == 0
        close
    end
end
    
j = 1;
while length(cc(1,1:end))>1
    n = cc(2,1) + 1;
    x_foo = cc(1,2:n);
    y_foo = cc(2,2:n);
    C{j} = cc(1:2,1); %save the value of the contour and the number of points defining the contour
    C{j+1} = x_foo + 1i*y_foo; %save the list of imaginary numbers defining the contour
    j = j+2;
    cc = cc(1:2, (n+1):end);
end

if(exist('show_plt'))
    if show_plt == 1
        figure
        hold on
        n = length(C);
        for j = 2:2:n
            plot(cell2mat(C(j))); %plot the extracted contours to compare to previous figure
        end
    end
else
    figure
        hold on
        n = length(C);
        for j = 2:2:n
            plot(cell2mat(C(j)));
        end
end
end