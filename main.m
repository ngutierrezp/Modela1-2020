f_1_2 = @(x) 6* exp(x + 18); 
interval = [-10, 10];
f_1_2_title = '6e^(^x^+^1^8^)';

print_scales(f_1_2, f_1_2_title, interval)


% Ecuaciones de prueba

f = @(x) x^3 - 4*x^2 + 6*x - 24;
f2 = @(x) x^3 - 7*x^2 + 14*x - 2;

tol = 1e-7;
res = Newton(f2, 12, tol, 50)