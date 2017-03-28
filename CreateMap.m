function CreateMap()
%CREATEMAP Summary of this function goes here
    %% Creo la forma del salón.

    PlotLine([0,0], [0,290], 'black')
    PlotLine([0,290], [384,290], 'black')
    PlotLine([0,0], [909,0], 'black')
    PlotLine([909,0], [909,111], 'black')
    PlotLine([909,111], [595,111], 'black')
    PlotLine([595,111], [595,290], 'black')
    PlotLine([595,290], [472,290], 'black')
    
    %% Añado el pasillo, que comienza en los puntos [472,290] y [384,290]
    
    PlotLine([472,290], [472,608], 'black')
    PlotLine([384,290], [384,608], 'black')
    PlotLine([472,608], [384,608], 'black')
    

end

