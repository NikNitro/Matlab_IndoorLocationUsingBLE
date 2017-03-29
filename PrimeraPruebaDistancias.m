    % This code has been created by Adrián M. Lloret.
%%Inicializo
clear all, clc
figure(1);hold on; axis equal; grid on;axis([-1 10 -1 10]); 

%% Las balizas se definen como posición y radio máximo.
%Una matriz de covariancia unitaria para que sea un círculo
balizas = [ 1 6; 2 4; 3 4];
W = [1 0; 0 1]; 
%baliza1 =  [1 2 3]';
baliza1 =  balizas(:,1);
plot(baliza1(1), baliza1(2), '*r');
PlotEllipse(baliza1(1:2), W, baliza1(3), 'm');
%baliza2 =  [6 4 4]';
baliza2 =  balizas(:,2);
plot(baliza2(1), baliza2(2), '*r');
PlotEllipse(baliza2(1:2), W, baliza2(3), 'm');


%% Defino un elemento a encontrar cualquiera
elem = [3 2]';
plot(elem(1), elem(2), '+b');

%% Calculamos una matriz de distancias de elem a cada baliza
for i=1:size(balizas(1))+1
    aux=balizas(:,i);
    dist=sqrt( (elem(1)-aux(1))^2 + (elem(2)-aux(2))^2) 
    %Imprimimos la nueva circunferencia
    PlotEllipse(aux, W, dist, 'g-');
end;
