function path = compute_odom()
%close all;
fig = figure;
dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myupdatefcn)
I = imread('final.pgm');
imshow(I);

path = [];

function txt =  myupdatefcn(empt,event_obj)
% Customizes text of data tips

pos = get(event_obj,'Position');
txt = {['Time: ',num2str(pos(1))],...
	      ['Amplitude: ',num2str(pos(2))]};
pos(1)
pos(2)
path = [path; pos(1) pos(2)];

dlmwrite('paths.txt',path)
end

end