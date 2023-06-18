clc
clear
n=input("how many workers and job do you have	:");

printf("\nenter time of\n\n");
for i=1:n
   for j=1:n
       printf("worker %d  job%d :",i,j);
       T(i,j)=input('\');
       end
end

printf("\nDATA YOU ENTERED IS	:\n  ");
for i=1:n
   printf("job%d ",i);
end

for i=1:n
   printf("\nworker%d  ",i);
   for j=1:n
       printf("%d ",T(i,j));
       end
end

minim=[1000,1000,1000,1000,1000,1000,1000,1000,1000];

for i=1:n
   for j=1:n
       if(T(i,j)<=minim(i)) then
           minim(i)=T(i,j);
           end
   end
end

printf("\n");

for i=1:n
   for j=1:n
       T(i,j)=T(i,j)-minim(i);
   end
end

printf("\n");

printf("\n\n*************data after row minimum decrement is***************\n\t\t");

for i=1:n
   printf("job%d ",i);
end

for i=1:n
   printf("\nworker%d  ",i);
   for j=1:n
       printf("%d ",T(i,j));
       end
end

zerr=[1000,1000,1000,1000,1000,1000];
zerc=[1000,1000,1000,1000,1000,1000];

for i=1:n
   for j=1:n
       if(T(i,j)==0) then
           zerr(i)=0;
           zerc(j)=0;
       end
       end
end

f=0;
y=0;

for i=1:n
   if(zerr(i)) then
       f=1;
       end
end

for i=1:n
   if(zerc(i)) then
       y=1;
       end
end

if((f==1)||(y==1)) then
   
   mn=[1000,1000,1000,1000,1000,1000,1000,1000,1000];
   
        for j=1:n
            for i=1:n
                if(T(i,j)<=mn(j)) then
                    mn(j)=T(i,j);
                    end
   end
end

     for j=1:n
            for i=1:n
                T(i,j)=T(i,j)-mn(j);
            end
        end
printf("\n\n*************data after column minimum decrement is***************\n");

for i=1:n
   printf("job%d ",i);
end

for i=1:n
   printf("\nworker%d  ",i);
   for j=1:n
       printf("%d ",T(i,j));
       end
end

end

printf("\n\n\n************Final job assignment is**************");

for i=1:n
   for j=1:n
      if(T(i,j)==0) then 
          printf("\n assign job %d to worker %d",j,i);
          
          for z=1:n
              
              if (z==i) then
                  continue;
                  end
              
                  if(T(z,j)==0) then
                      T(z,j)=1000;
                      
                  end
                  
                  for l=1:n
                      if(l==j) then
                          continue;
                          end
              
                  if(T(i,l)==0) then
                      T(i,l)=1000;
                      
                  end
                  
                  
          end
          
          end
end 

end
end
printf("\n");
