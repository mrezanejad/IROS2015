% outputVideo = VideoWriter('closer.avi');
outputVideo = VideoWriter('cave.avi');
outputVideo.FrameRate = 3;
open(outputVideo);




for j = 1:12
    j
    
%     path = fullfile('ALL_CLOSER',strcat(int2str(j),'.png'));
    path = fullfile('cave',strcat(int2str(j),'.png'));
    img = imread(path);

    writeVideo(outputVideo,img);
end
close(outputVideo);


% shuttleAvi = VideoReader('closer.avi');
shuttleAvi = VideoReader('cave.avi');
