function plotSim(t,u,y)

subplot(3,1,1)
plot(t, u);
title("Entrada");
xlabel("Tiempo (s)")
ylabel("Flujo (m^3/s)")

subplot(3,1,2)
plot(t, y(:,1));
title("Nivel contenedor 1 (x1)");
xlabel("Tiempo (s)")
ylabel("Nivel (m)")
yline(0, "-.")

subplot(3,1,3)
plot(t, y(:,2));
title("Nivel contenedor 2 (x2)");
xlabel("Tiempo (s)")
ylabel("Nivel (m)")
yline(0, "-.")

end

