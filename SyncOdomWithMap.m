close all;


odom = importdata('paths.txt');

odomSize = size(odom,1);
figure;
axis equal;

originalsize= [4000 4000];

laserSize = 148;

startToPause = 1;

for i=1:1:laserSize

    i
     
    clf;
    
    odomIndex = getRelventIndexOfAnImageNumber(i);
 
    framePath = odom(1:odomIndex,:);
    laser = imread(strcat(strcat('final_ppms\',int2str(i)),'.ppm')); 
    %ratio = [size(laser,1)/originalsize(1,1) size(laser,2)/originalsize(1,2)];
    ratio = [0.5 0.5];
    [laser,x1,x2,y1,y2] = CropImage(laser);
    
    x1
    x2
    y1
    y2
    imshow(laser);
    curPath = zeros(size(framePath));
    
    toSave = zeros(size(framePath));
    
    w = size(laser,1);
    h = size(laser,2);
    for j=1:size(framePath,1)
        curPath(j,1) = framePath(j,1)*ratio(1,1)-y1 - 600;
        curPath(j,2) = framePath(j,2)*ratio(1,2)-x1 - 700;
        toSave(j,1) = curPath(j,1)/h;
        toSave(j,2) = curPath(j,2)/w;
    end
    
    framePath
    curPath

    hold on;
    plot(curPath(:,1), curPath(:,2));
    dlmwrite(strcat(strcat('paths\',int2str(i)),'.txt'),toSave);
    
    if i > startToPause
        w = waitforbuttonpress;
        while w == 0
            pause(5);
            w = waitforbuttonpress;
        end
    end

end
