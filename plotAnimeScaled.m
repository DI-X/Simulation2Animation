function plotAnimeScaled(ScaleFactor,Uimg,Ualphachannel,Limg,Lalphachannel,xHip,yHip,thetaHip,thetaKnee)
figure(1)

UsizeI=size(Uimg); %size of scaled imaged
LsizeI=size(Limg);  %size of scaled imaged

%% set background
bg=ones(800)*255;
bg=bg([1:480],[1:720]);
KK=imshow(bg);
hold on

%% resize 
HipJointx=69*ScaleFactor;
HipJointy=90*ScaleFactor;

KneeJointxLow=50*ScaleFactor;
KneeJointyLow=50*ScaleFactor;

KneeJointyUpper=(415+68)*ScaleFactor;
UpperLegKnee=[0;KneeJointyUpper-HipJointy];

%% draw ground
plot([0 720],[400 400],'g','Linewidth',10); %% set ground

%% draw the upper leg
J = imrotate(Uimg,thetaHip);
Ja = imrotate(Ualphachannel,thetaHip);

R=[cos(thetaHip/180*pi) sin(thetaHip/180*pi);
    -sin(thetaHip/180*pi) cos(thetaHip/180*pi);];

originHip=R*[HipJointx;HipJointy];
compUpper=calcComp(UsizeI(1),UsizeI(2),thetaHip);

sizeJ=size(J);

UpperLegBegin=[xHip+compUpper(1)-originHip(1);yHip+compUpper(2)-originHip(2);];
KK=imshow(J, 'XData', [UpperLegBegin(1) UpperLegBegin(1)+sizeJ(2)], 'YData', [UpperLegBegin(2) UpperLegBegin(2)+sizeJ(1)]);
set(KK,'XData', [UpperLegBegin(1) UpperLegBegin(1)+sizeJ(2)],'yData', [UpperLegBegin(2) UpperLegBegin(2)+sizeJ(1)],'AlphaData',double(Ja));

KeePos=R*UpperLegKnee+[xHip;yHip];
%% draw lower leg
J = imrotate(Limg,(thetaHip+thetaKnee));
Ja = imrotate(Lalphachannel,(thetaHip+thetaKnee));

R=[cos((thetaHip+thetaKnee)/180*pi) sin((thetaHip+thetaKnee)/180*pi);
    -sin((thetaHip+thetaKnee)/180*pi) cos((thetaHip+thetaKnee)/180*pi);];

origin=R*[KneeJointxLow;KneeJointyLow];
comp=calcComp(LsizeI(1),LsizeI(2),(thetaHip+thetaKnee));

sizeJ=size(J);

lowerLegBegin=KeePos+comp-origin;
KK=imshow(J, 'XData', [lowerLegBegin(1) lowerLegBegin(1)+sizeJ(2)], 'YData', [lowerLegBegin(2) lowerLegBegin(2)+sizeJ(1)]);
set(KK,'XData', [lowerLegBegin(1) lowerLegBegin(1)+sizeJ(2)],'yData', [lowerLegBegin(2) lowerLegBegin(2)+sizeJ(1)],'AlphaData',double(Ja));

end
    


