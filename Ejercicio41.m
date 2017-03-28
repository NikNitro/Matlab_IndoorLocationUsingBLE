%%Apartado 1
clear all, clc
figure(1);hold on;axis equal;grid on;axis([-1 10 -1 10])

%Datos
p1 = [1 2 0.5]';
w1  = diag([0.25 0.04]);
z = [4 0.7]'; %4m 0.7rad
sigma = 1;

r=z(1);
theta=z(2);

jacob = [cos(theta) -r*sin(theta);
         sin(theta)  r*cos(theta)];
 

xrel = r*cos(theta);yrel = r*sin(theta);
%Calculamos la matriz de covarianzas
W = jacob*w1*jacob';

DrawRobot(p1,'b');
markPose = tcomp(p1, [xrel;yrel;1]);

plot(markPose(1), markPose(2), '+m');
PlotEllipse(markPose, W, 1, 'm')



%%Apartado 2

%Calculamos elipse de R1 y la dibujamos
covar = diag([0.08 0.6 0.02]);

PlotEllipse(p1, covar, 1, 'b');

%Calculamos también la elipse nueva para landmark

c = cos(p1(3)); s = sin(p1(3));

j2=[c s; -s c];
j1=[-c -s -(markPose(1)-p1(1))*s+(markPose(2)-p1(2))*c;
     s -c -(markPose(1)-p1(1))*c-(markPose(2)-p1(2))*s];

Wnew =  j2*w1*j2' + j1*covar*j1'
PlotEllipse(markPose, Wnew, 1, 'b');

%%Apartado 3

%Calculamos pose y elipse de R2 y la dibujamos
p2=[6;4;2.1];
w2=diag([0.2 0.09 0.03]);
DrawRobot(p2, 'g');
PlotEllipse(p2, w2, 1, 'g');

%Calculamos ahora la pose relativa entre R1 y R2
relatPose = [(p2(1)-p1(1))*cos(p1(3))+(p2(2)-p1(2))*sin(p1(3));
            -(p2(1)-p1(1))*sin(p1(3))+(p2(2)-p1(2))*cos(p1(3));
                                p2(3)-p1(3)                  ];
%a = tcomp(tinv(p1),p2)

%Y su matriz de covarianzas
c = cos(p1(3)); s = sin(p1(3));

j12_2=[c s 0; -s c 0; 0 0 1];
j12_1=[-c -s -(p2(1)-p1(1))*s+(p2(2)-p1(2))*c;
        s -c -(p2(1)-p1(1))*c-(p2(2)-p1(2))*s;
        0  0                 -1             ];
    
relatCovar = j12_1*covar*(j12_1') + j12_2*w2*(j12_2')


%%Apartado 4

%Primero calculo la pose relativa de mark respecto a R2
%Pose m respecto a 2
pm_2 = tcomp(tinv(p2), markPose);
%plot(pm_2(1), pm_2(2), '*r');

coord_pm_2 = [pm_2(1);pm_2(2)];

relm_2_polares = [sqrt(sum(coord_pm_2.^2)); atan(pm_2(2)/pm_2(1))]
r2=relm_2_polares(1);
theta2=relm_2_polares(2);
%Ahora calculamos la covarianza

c = cos(p2(3)); s = sin(p2(3));

j12_2=[c s; -s c];
j12_1=[-c -s -(markPose(1)-p2(1))*s+(markPose(2)-p2(2))*c ;
        s -c -(markPose(1)-p2(1))*c-(markPose(2)-p2(2))*s];
jacobEnun = [cos(theta2) sin(theta2);
             -sin(theta2)/r2 cos(theta2)/r2];
         
covarm = j12_1*w2*(j12_1') + j12_2*W*(j12_2');

covarm = jacobEnun*covarm*jacobEnun'


%%Apartado 5
r=4;
theta = 0.3;
xrel = r*cos(theta);yrel = r*sin(theta);
LMPose = tcomp(p2, [xrel;yrel;1]);
plot(LMPose(1), LMPose(2), 'xg');


jacob = [cos(theta) -r*sin(theta);
         sin(theta)  r*cos(theta)];

%Calculamos la matriz de covarianzas
W = jacob*w1*jacob'+ j12_1*w2*(j12_1');

%PlotEllipse(LMPose, W, 1, 'g')
%%%%%%%%%%%%%%
c = cos(LMPose(3)); s = sin(LMPose(3));

j2=[c s; -s c];
j1=[-c -s -(p2(1)-LMPose(1))*s+(p2(2)-LMPose(2))*c;
     s -c -(p2(1)-LMPose(1))*c-(p2(2)-LMPose(2))*s];

Wnew2 =  j2*w1*j2' + j1*covar*j1'
PlotEllipse(LMPose, Wnew2, 1, 'g');

poseInterm = (markPose+LMPose)/2
covInterm  = Wnew+Wnew2/2
plot(poseInterm(1), poseInterm(2), '+r');
PlotEllipse(poseInterm, covInterm, 0.75, 'r');
