clc
m=input("Enter the number of rows of first matrix: "); 
n=input("Enter the number of columns of first matrix: "); 
p=input("Enter the number of rows of second matrix: "); 
q=input("Enter the number of columns of second matrix: ");

if n==p
    disp('Matrices are conformable for multiplication') 
else
    disp('Matrices are not conformable for multiplication') 
    break;
end
disp('Enter the first matrix: ') 
for i=1:m
    for j=1:n 
        A(i,j)=input('\'); 
    end
end
disp('Enter the second matrix: ') 
for i=1:p
    for j=1:q 
        B(i,j)=input('\') 
    end
end 
C=zeros(m,q); 
for i=1:m
    for j=1:q 
        for k=1:n
            C(i,j) = C(i,j)+A(i,k)*B(k,j); 
        end
    end
end
disp('The first matrix is: ') 
disp(A)
disp('The second matrix is: ') 
disp(B)
disp('The product of two matrices is: ') 
disp(C)
// Matrix Multiplication using function
clc
function []=multiplication(m, n, p, q, A, B) 
C=zeros(m,n);
if n==p
    disp('Matrices are conformable for multiplication') 
else
    disp('Matrices are not conformable for multiplication') 
    break;
end 
C=A*B
disp('The first matrix is') 
disp(A)
disp('The Second matrix is') 
disp(B)
disp('The multiplication of two matrices is') 
disp(C)
endfunction