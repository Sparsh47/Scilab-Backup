clc
m = input("Enter the number of rows of matrix: ");
n = input("Enter the number of columns of matrix: "); 
disp('Enter the first matrix')
for i = 1:m 
    for j = 1:n
        A(i,j) = input('\'); 
    end
end
disp('Enter the second matrix') 
for i = 1:m
    for j = 1:n 
        B(i,j) = input('\') 
    end
end
for i = 1:m 
    for j = 1:n
        C(i,j) = A(i,j) + B(i,j);
    end
end
disp('The first matrix is:') 
disp(A)
disp('The Second matrix is: ') 
disp(B)
disp('The sum of matrices is: ') 
disp(C)
//	Matrix Addition (Using Function)
clc
function[]=addition(m, n, A, B) 
C=zeros(m,n);
C=A+B;
disp('The first matrix is') 
disp(A)
disp('The Second matrix is') 
disp(B)
disp('The sum of two matrices is') 
disp(C)
endfunction
