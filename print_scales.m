function [] = print_scales (f, f_title, interval)

x_inf = interval(1);
x_sup = interval(2);

x = x_inf:0.05:x_sup;
y = f(x);

figure(4)
plot(x, y, 'r -');
title("Normal scale graph")
xlabel('x')
ylabel(f_title)

figure(5)
semilogy(x, y, 'r -')
grid on
title("Logarithmic scale graph")
xlabel('x')
ylabel(f_title)


