clc 
clear all
disp("enter no of observation") 
n=input('\')
disp("enter the vlaue of x") 
for i=1:n
    X(1,i)=input('\') 
end
disp("enter no of frequency") 
for j=1:n
    F(1,j)=input('\') 
end
disp("Mean of the distribution is") 
MEA=sum(F.*X)/sum(F) 
disp(MEA)
p=MEA/n EF=sum(F)*binomial(p,n-1) 
disp("Given frequencies") 
disp(F)
disp("Expected frequencies") 
disp(EF)
plot2d3(0:n-1, F)
plot2d(0:n-1,EF)