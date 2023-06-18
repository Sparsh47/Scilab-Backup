clc; 
clear; 
close;
n=input('Enter the no of pairs of values(x,y)='); 
disp('Enter the values of x:')
s1=0; 
s2=0;
for i=1:n 
    x(i)=input(''); 
    s1=s1+x(i); 
    s2=s2+x(i)*x(i);
end
disp('Enter the corresponding values of y: ') s3=0;
for i=1:n 
    y(i)=input(''); 
    s3=s3+y(i);
end 
s4=0;
for i=1:n 
    s4=s4+x(i)*y(i);
end 
A1=s1/n; 
A2=s3/n;
m=(n*s4-s1*s3)/(n*s2-s1*s1); 
c=A2-m*A1;
disp('The line of regreassion of y on x is') 
disp('');
printf('y=%gx+(%g)\n',m,c)