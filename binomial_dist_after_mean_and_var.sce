clc 
clear all
disp("Enter no of observation") 
n=input('\')
disp("Enter the value of x") 
for i = 1:n
    X(i)=input('\') 
end
disp("Enter the no of frequency") 
for j=1:n
    F(j)=input('\') 
end
disp("Mean of the distribution is") 
MEA = sum(F.*X)/sum(F) 
disp("MEA")
p=MEA/n 
EF=sum(F)*binomial(p,n) 
disp("Given Frequencies") 
disp(F)
disp("Expected Frequencies") 
disp(EF )