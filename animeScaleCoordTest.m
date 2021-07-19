movieVector=[];
figh=figure(1);
v = VideoWriter('SimulationAnime.mp4','MPEG-4');
open(v);

%% calcurate scale factor
L1=0.32;  %true leg length
L2=0.327;

PicL1=393; %leg length in picture
PicL2=401;

Negative=0.3;  % magnitude of negative hight
ysimMax=1.5+Negative;
ymax=480;    %hight of video

ScaleFactor=L1/PicL1*ymax/ysimMax;

%% load image and resize

[Uimg, map, Ualphachannel] = imread('images/Picture3.png');
Uimg=flip(Uimg,2);
Ualphachannel=flip(Ualphachannel,2);

[Limg, Lmap, Lalphachannel] = imread('images/LowerLeg.png');
Limg=flip(Limg,2);
Lalphachannel=flip(Lalphachannel,2);

Uimg = imresize(Uimg,ScaleFactor);
Ualphachannel = imresize(Ualphachannel,ScaleFactor);

Limg = imresize(Limg,ScaleFactor);
Lalphachannel = imresize(Lalphachannel,ScaleFactor);
%% load simulation data

load('simdata.mat')
t=simdataout(1,:);
xtorso=simdataout(2,:);
ytorso=simdataout(3,:);
hipAng=simdataout(4,:);
kneeAng=simdataout(5,:);

%%
tf=4.01;
for j=401:431
    
    tf=tf+0.01;
    [M,I]=min(abs(t-tf));
    
    xHip=xtorso(I)+0.5;
    yHip=ytorso(I);
    thetaHip=hipAng(I)*180/pi;
    thetaKnee=kneeAng(I)*180/pi;
    
    %%% coordinate transformation
    yHip2=yHip+Negative;
    yHip3=ymax-yHip2*ymax/ysimMax;
    xHip2=xHip*ymax/ysimMax;
    
    xHip=xHip2;
    yHip=yHip3;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    plotAnimeScaled(ScaleFactor,Uimg,Ualphachannel,Limg,Lalphachannel,xHip,yHip,thetaHip,thetaKnee)

    set(gcf, 'Position',  [100, 100, 720, 480])
    frame=getframe(figh);
    writeVideo(v,frame);
end
close(v)
