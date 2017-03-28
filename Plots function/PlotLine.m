
% This function draws a line representing a Gaussian centered at x (mean) and with covariance P 
% This code has been taken from the file DoVehicleGraphics.m by P.% Newman http://www.robots.ox.ac.uk/~pnewman

function PlotLine(Init,End,color)
% Init is de begginning of the line
% End is de ending of the line

%    x = [Init(1) : ((End(1)-Init(1))/1000) : End(1)]
%    y = [Init(2) : ((End(2)-Init(2))/1000) : End(2)]

%    plot(x, y, color);
%    line([0,0],[0,5])
    line([Init(1),End(1)], [Init(2),End(2)], 'Color', color, 'LineWidth', 2.5);
