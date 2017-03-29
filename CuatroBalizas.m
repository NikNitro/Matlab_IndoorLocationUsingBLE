    % This code has been created by Adrián M. Lloret.
%%Inicializo
clear all, clc
figure(1);hold on; axis equal; grid on;axis([-20 930 -20 700]); 
CreateMap()

%% Las balizas se definen como posición y radio máximo.
%Una matriz de covariancia unitaria para que sea un círculo
        
balizas = [100 200   300; %baliza1
           400 005   250; %baliza2
           550 250   320; %baliza3
           400 420   300]; %baliza4
W = [1 0; 0 1]; 

%Esto obtiene filas y columnas
numBalizas=size(balizas(:,1)); 
%Aquí nos quedamos solo con el número de filas
numBalizas=numBalizas(1);       

%% Imprimimos las balizas
for i=1:numBalizas
    aux = balizas(i,:)';
    plot(aux(1), aux(2), '*r');
    PlotEllipse(aux(1:2), W, aux(3), 'm');
end;

%% Defino un elemento a encontrar cualquiera
elem = [400 200]';
plot(elem(1), elem(2), '+b');

%% Dibujamos las distancias de elem a cada baliza
for i=1:numBalizas
    aux=balizas(i,:)';
    dist=sqrt( (elem(1)-aux(1))^2 + (elem(2)-aux(2))^2);
    %Imprimimos la nueva circunferencia
    if dist <= aux(3)
        PlotEllipse(aux, W, dist, 'g-');
    end;
end;


%% Calculamos una matriz de distancias de elem a cada baliza
% la formula del círculo es (x-c1)^2 + (y-c2)^2 = radio^2
% por tanto y = sqrt( radio^2 - (x-c1)^2 ) - c2

syms x y; % Avisamos de que x e y van a ser variables
for i=1:numBalizas
    aux=balizas(i,:)';
    dist=sqrt( (elem(1)-aux(1))^2 + (elem(2)-aux(2))^2);
    % Calculamos la ecuación de la circunferencia
    if dist <= aux(3)
        %distancias(i) = (x-aux(1))^2 + (y-aux(2))^2 - dist^2;
        distancias(i) = x^2 + y^2 -2*aux(1)*x -2*aux(2)*y + ( aux(1)^2 + aux(2)^2 - dist^2 ) ==0;
    end;
end;


%% Obtenemos los valores dos a dos y los resolvemos, guardándolos en 
% un mapa de resultados
numDist = size(distancias);
numDist = numDist(2);

%Creamos un mapa con los elementos a añadir
%mapObj = containers.Map;
%Los Mapas por defecto son de caracteres. Definimos uno de enteros.
mapObjX = containers.Map('KeyType','single','ValueType','single');
mapObjY = containers.Map('KeyType','single','ValueType','single');
for i=1:numDist
    for j=1:numDist
        if(i~=j)% && distancias(i)~=0 && distancias(j)~=0)
            [solx, soly] = solve(distancias(i),distancias(j));
            % Guardamos la x
            for k=1:length(solx)
                % INICIO Update 1
 %               if(mapObjX.isKey(single(solx(k)))) 
                goodKey = IsThereASimilarKey(mapObjX, single(solx(k)));
                if(goodKey~=-1)
                    mapObjX(goodKey) = (mapObjX(goodKey) + 1);
                else
                    mapObjX(single(solx(k))) = 1;
                end;
            end;
            % Y guardamos la y
            for k=1:length(soly)
                goodKey = IsThereASimilarKey(mapObjY, single(soly(k)));
                if(goodKey~=-1)
                    mapObjY(goodKey) = (mapObjY(goodKey) + 1);
                else
                    mapObjY(single(soly(k))) = 1;
                    % FIN Update 1
                end;
            end;
        end;
    end;
end;


%% Elegimos a los valores de x y de y resultantes, tomando los que tienen 
% más coincidencias

listaX = mapObjX.keys();
elemX = cell2mat(listaX(1));
numX  = mapObjX(elemX);
listaY = mapObjY.keys();
elemY = cell2mat(listaY(1));
numY  = mapObjY(elemY);
for i=2:length(listaX)
    elemAux = cell2mat(listaX(i));
    numAux = mapObjX(elemAux);
    if(numAux>numX)
        numX = numAux;
        elemX = elemAux;
    end;    
end;

for i=2:length(listaY)
    elemAux = cell2mat(listaY(i));
    numAux = mapObjY(elemAux);
    if(numAux>numY)
        numY = numAux;
        elemY = elemAux;
    end;    
end;

%% La posición resultado es:
[elemX, elemY]

plot(elemX, elemY, '+b');


%% Basura reciclabl*e



