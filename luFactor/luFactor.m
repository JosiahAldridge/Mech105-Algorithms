function [L, U, P] = luFactor(A)
% luFactor(A)
%	LU decomposition with pivotiing
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%       P = the permutation matrix

%Checks to see if A is square
dim = size(A);
if dim(1) ~= dim(2)
    error('Matrix is not square')
end
dim = max(dim);
%Creates P
P = eye(dim);
L = eye(dim);
for j = 1:(dim-1)
  for k =j+1:dim
      if abs(A(k,j)) > abs(A(j,j))
          P([j k],:) = P([k j],:);
          A = P*A;
      end
  end
          for n = (j+1):dim
              L(n,j) = (A(n,j)/A(j,j));
              A(n,:) = A(n,:)-(A(j,:)*L(n,j));
          end
end
U = A;
end