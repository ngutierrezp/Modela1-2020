function [Normalizado]  = Graficar(Arreglos,tamanos,metodos,tituloX,tituloY,lugar)
cantidad = length(tamanos);
y = max(tamanos);
x = linspace(1,y,y);
Normalizado = [];
offset =0;

%Se normalizan la cantidad de iteraciones para que todos los metodos tengan
%igual cantidad
for i=1:cantidad
     for j=1:tamanos(i)
         Normalizado(end+1)=Arreglos(j + offset);           
     end
     for p=1:y-tamanos(i)
        Normalizado(end+1) = Normalizado(end);
     end 
     offset=offset + tamanos(i);
end 
figure;

plot(x,Normalizado(1:1:y),'DisplayName',metodos(1),'LineWidth',2,'MarkerSize',10),hold on;
for i=2:cantidad
   plot(x,Normalizado(y*(i-1) +1:1:y*i),'DisplayName',metodos(i),'LineWidth',2,'MarkerSize',10);
end
title(tituloY +' vs '+ tituloX, 'FontSize', 18);
xlabel(tituloX, 'FontSize', 18);
ylabel(tituloY,  'FontSize', 18);
grid;
set(legend, 'FontSize', 12);
hold off;
print(lugar,'-dpng')
end