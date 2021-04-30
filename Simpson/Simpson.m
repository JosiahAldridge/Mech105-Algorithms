function [I] = Simpson(x, y)
% Numerical evaluation of integral by Simpson's 1/3 Rule
% Inputs
%   x = the vector of equally spaced independent variable
%   y = the vector of function values with respect to x
% Outputs:
%   I = the numerical integral calculated
trap = 0;
f = 0;
%Checks dimensions of arrays
if length(x) ~= length(y)
    error('Arrays must have the same dimensions.');
end
%Checks if spacing is uniform
for i = 3:length(x)
    if (x(i)-x(i-1)) ~= (x(i-1)-x(i-2))
        error('Spacing is not uniform.');
    end
end
%Finds h
hsimp = (x(length(x))-x(1))/(length(x)-1);
%Determines if trap rule is necessary, sets it to true if it is required, and finds its h value
if rem(length(x),2) == 0
    trap = 1;
    warning('Trapezoidal rule will be used for final segment.');
    htrap = (x(length(x))-x(length(x)-1))/length(x);
end
%Does trap rule if only 2 data points
if length(x) == 2
    I = htrap*(y(1)+y(length(y)));
end
%Simpson 1/3 rule without trapezoids
if trap == 0
    for k = 1:(length(x))
        if rem(k,2) == 0
            f = f + 4*y(k);
        elseif k == 1
            f = f + y(k);
        elseif k == length(x)
            f = f + y(k);
        else
            f = f + 2*y(k);
        end
    end
    I = f * (hsimp/3);
end
%Simpson 1/3 with trapezoids
if trap == 1
    for k = 1:(length(x)-1)
        if rem(k,2) == 0
            f = f + 4*y(k);
        elseif k == 1
            f = f + y(k);
        elseif k == length(x)-1
            f = f + y(k);
        else
            f = f + 2*y(k);
        end
    end
    Isimp = f*(hsimp/3);
    ftrap = (y(length(x))+y(length(x)-1))/2;
    Itrap = ftrap*htrap;
    I = Isimp + Itrap;
end
end