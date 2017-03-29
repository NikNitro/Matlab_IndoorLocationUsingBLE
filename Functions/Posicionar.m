    % This code has been created by Adrián M. Lloret.
    
function [ elemX, elemY ] = Posicionar( distancias )
%POSICIONAR Recibe las distancias a cada baliza en forma de ecuación y
% devuelve la posición del elemento a encontrar.
%   

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

end

