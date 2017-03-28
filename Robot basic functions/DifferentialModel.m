%------------ MODEL --------------%
function y = DifferentialModel(x,u,dT)
%This function takes pose x and transform it according to the motion u=[v,w]
%applying the differential drive model. 
% Dt: time increment
% y: Transformed pose (in world reference)
if(u(2)== 0) %linear motion w=0. Only motion in x
    %dx = u(1)*dT; dy = 0; d_thetha = 0;
    y(1,1) = x(1) + u(1)*dT*cos(x(3));
    y(2,1) = x(2) + u(1)*dT*sin(x(3));
    y(3,1) = x(3);
else %Non-linear motion w=!0
    R=u(1)/u(2); %v/w=r is the curvature radius
    y(1,1) = x(1) - R*sin(x(3)) + R*sin(x(3)+u(2)*dT);
    y(2,1) = x(2) + R*cos(x(3)) - R*cos(x(3)+u(2)*dT);
    y(3,1) = x(3) + u(2)*dT;
end