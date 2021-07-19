function comp=calcComp(sizeY,sizeX,Angle)

point1=[sizeX;0];
point2=[0;sizeY];
point3=[sizeX;sizeY];

R=[cos(Angle/180*pi) sin(Angle/180*pi);
   -sin(Angle/180*pi) cos(Angle/180*pi);];
   
Rpoint1=R*point1;
Rpoint2=R*point2;
Rpoint3=R*point3;

compX=min([0,Rpoint1(1),Rpoint2(1),Rpoint3(1)]);
compY=min([0,Rpoint1(2),Rpoint2(2),Rpoint3(2)]);

comp=[compX;compY];
