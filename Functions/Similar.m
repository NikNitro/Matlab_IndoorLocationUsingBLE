    % This code has been created by Adrián M. Lloret.
function result = Similar( arg1, arg2, margen)
%SIMILAR return true if both args are equals with a 1mm of error

% Margen parametrizado, por defecto 1
    if(nargin==2)
        margen=1;
    end;
    
    if(abs(arg1-arg2)>margen)
        result = false;
    else
        result = true;
    end;
end

