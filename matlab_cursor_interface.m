function  matlab_cursor_interface()

close all;
clear all;
path = [];
file_name = 'final\143';
current_grid_map_file = strcat(file_name,'.pgm');
current_ppm_file = strcat('current.ppm');
current_txt_file  = 'current_image.txt';

%Show the grid map
fig = figure;
 % Create push button
 btn = uicontrol('Style', 'pushbutton', 'String', 'Position OK!',...
        'Position', [20 20 100 30],...
        'Callback', @run_skeleton_code);    

    
    
    
I = imread(current_grid_map_file);
imshow(I);

%CREATE Binary Map


%Set the cursor mode
dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myupdatefcn)


function txt = myupdatefcn(~,event_obj)
% Customizes text of data tips

pos = get(event_obj,'Position');
txt = {['Time: ',num2str(pos(1))],...
	      ['Amplitude: ',num2str(pos(2))]};
pos(1)
pos(2)
path = [path; pos(1) pos(2)];

end

function run_skeleton_code(source,callbackdata)
    %disp('Hello\n');
    %size(robot_position)
    
    %write down path to path.txt
    dlmwrite('path.txt',path);
    
    %create ppm file out of gridmap
    make_ppm_file_out_of_pgm(current_grid_map_file,current_ppm_file);
    
    %create txt image file for skeleton maker out of ppm
    I = imread(current_ppm_file);
    I = I(:,:,1);
    print_image_ascii(I,current_txt_file);
    
    % Call testDivergenceSkeletonMaker 
    
    !testDivergenceSkeletonMaker.exe current_image.txt > current_image_result.ps
    
    
end

end


