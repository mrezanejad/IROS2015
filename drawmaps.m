function drawmaps()


figure;
for i = 1:148
    clf;
    I = imread(strcat(int2str(i),'.pgm'));
    I = I(750:end-750,750:end-750);
    hold on;
    imshow(I);
    pause(0.01);
end


end