    % This code has been created by Adrián M. Lloret.
function result = IsThereASimilarKey( mapObj, elem, margen )
%ISTHEREASIMILARKEY If a Similar key is contained in the map, return the
%true key. Otherwise return -1.

% Margen parametrizado, por defecto 1
    if(nargin==2)
        margen=1;
    end;
    
    result = -1;
    
    for i = (elem-margen):(elem+margen)
        if(mapObj.isKey(i))
            result=i;
        end;
    end;


end

