function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false position method
if nargin < 3
    error('Not enough inputs')
end
test = func(xl, varargin{:}) * func(xu, varargin{:});
if test > 0
    error('Sign change not detected')
end
if nargin < 4
    es = .0001;
end
if nargin < 5
    maxit = 200;
end
ea = 100;
iter = 0;
xr = xl;
while (ea > es)&&(iter < maxit)
    oldr = xr;
    xr = xl - ((xu-xl)*func(xl, varargin{:}))/(func(xu, varargin{:})-func(xl, varargin{:}));
    iter = iter+1;
    ea = abs(((xr-oldr)/xr))*100;
    if (func(xr, varargin{:})*func(xl, varargin{:})) < 0
        xu = xr;
    elseif (func(xr, varargin{:})*func(xu, varargin{:})) < 0
        xl = xr;
    end
end
root = xr;
fx = func(xr, varargin{:});
ea = ea;
iter = iter-1;
end
