clc
m=input("Enter the number of rows of the matrix: "); 
n=input("Enter the number of columns of the matrix: "); 
disp('Enter the matrix: ')
for i=1:m 
    for j=1:n
        A(i,j)=input('\') 
    end
end 
B=zeros(n,m); 
for i=1:n
    for j=1:m 
        B(i,j)=A(j,i) 
    end
end
disp('Matrix Entered: ') 
disp(A)
disp('Transpose of the matrix: ') 
disp(B)

// Matrix Transpose function file

function []=transpose(m, n, A) 
B=zeros(m,n);
B=A'
disp('The matrix is') 
disp(A)
disp('Transposed matrix is')
disp(B)
endfunction
