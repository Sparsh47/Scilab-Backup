clc 
clear all
disp("Enter the no of observation") 
m=input('/')
disp("Enter the value of x") 
for i=1:m
    X(1,i)=input('/') 
end
disp("Enter no of frequency") 
for j=1:m
    F(1,j)=input('/') 
end
disp("Mean of distribution is") 
MEA=sum(F.*X)/sum(F) 
disp(MEA)
n=m-1 
p=MEA/n
EF=sum(F)*binomial(p,n) 
disp("Given Frequencies") 
disp(F)
disp("Expected Frequencies") 
disp(EF)
plot2d3(0:n,EF) 
plot2d(0:n,EF) 
n=50
p=0.3
plot2d3(0:n,binomial(p,n)) 
plot2d(0:n,binomial(p,n))