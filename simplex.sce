clc
clear

p = input("Enter the number of variables in the objective function: ");
q = input("Enter the number of constraint equations: ");

disp("Enter the coefficients of the objective function:");
for i = 1:p
    A(i) = input("Coefficient " + string(i) + ": ");
end

m = input("Enter 1 to minimize or 2 to maximize: ");

disp("Enter the constraint equations:");
for i = 1:q
    disp("Enter equation " + string(i) + ":");
    for j = 1:p
        disp("Enter coefficient " + string(j) + ":");
        B(i, j) = input("Coefficient " + string(j) + ": ");
        if j == p
            disp("Whether you want to maximize or minimize this equation:");
            disp("Enter 1 for <= or 2 for >=:");
            C(i) = input("Choice: ");
            disp("Enter constant:");
            D(i) = input("Constant: ");
        end
    end
end

fprintf("\n\nEquations you entered are:\n\n");
if m == 1
    fprintf("MIN\n");
else
    fprintf("MAX\n");
end

for i = 1:p
    if i == p
        fprintf("%dx%d", A(i), i);
    else
        fprintf("%dx%d + ", A(i), i);
    end
end

fprintf("\nConstraint equations are:\n");
for i = 1:q
    for j = 1:p
        fprintf("%dx%d + ", B(i, j), j);
        if j == p
            if C(i) == 1
                fprintf("<= %d", D(i));
            elseif C(i) == 2
                fprintf(">= %d", D(i));
            end
        end
    end
    fprintf("\n");
end

fprintf("\n\n====================SIMPLEX TABLE IS=======================\n\n\n");
fprintf("CJ |");
for i = 1:p-1
    fprintf(" %d", A(i));
end

for i = 1:q-1
    fprintf(" 0s%d", i);
end

fprintf("\n---------------------------------------------------------");
fprintf("\nBV Cb Xb |");
for i = 1:p
    fprintf(" x%d", i);
end

for i = 1:q
    fprintf(" s%d", i);
end

fprintf(" Min Xb/x");
fprintf("\n---------------------------------------------------------\n");

for i = 1:p
    fprintf("s%d 0 %d | ", i, D(i));
    for j = 1:q
        fprintf("%d ", B(i, j));
    end
    for j = 1:q
        if j == i
            fprintf("1 ");
        else
            fprintf("0 ");
        end
    end
    fprintf("\n");
end

fprintf("--------------------------------------------------------");
fprintf("\n ZJ-CJ |");
for i = 1:p
    fprintf(" -%d", A(i));
end

for i = 1:q
    fprintf(" 0");
end
