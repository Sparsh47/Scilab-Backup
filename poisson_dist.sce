clc 
clear
disp("Enter no of observations") 
n=input('\')
disp("Enter value of x") 
for i=1:n
    X(1,i)=input('/') 
end
disp("Enter no of frequency") 
for j=1:n
    F(1,j)=input('/') 
end
disp("Mean of distribution is") 
M=sum(F.*X)/sum(F) 
disp(M)
for i=1:n
    P(1,i)=sum(F)*exp(-M)*M^(X(i))/factorial(X(i)) 
end
disp("Expected frequencies are") 
disp(P)
plot2d(X,P)