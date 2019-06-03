function  matlab_cursor_interface2()


close all;
clear all;
step = 3;
s = 1;
path = [];
current_txt_file = '';
path_file = '';
file_name ='';
final_path = fullfile('C:','Users','Morteza','Desktop','final');
%Show the grid map
fig = figure;
 % Create push button
 btn = uicontrol('Style', 'pushbutton', 'String', 'Position OK!',...
        'Position', [20 20 100 30],...
        'Callback', @run_skeleton_code);    
 btn = uicontrol('Style', 'pushbutton', 'String', 'Next',...
    'Position', [130 20 100 30],...
    'Callback', @next);    

 btn = uicontrol('Style', 'pushbutton', 'String', 'View',...
    'Position', [240 20 100 30],...
    'Callback', @view);    



%Set the cursor mode
dcm_obj = datacursormode(fig);
set(dcm_obj,'UpdateFcn',@myupdatefcn)

number_position_ok = 0;

I = zeros(1);


function next(source,callbackdata)
    step = step + s;
   file_name = int2str(step);
   current_grid_map_file = fullfile(final_path,strcat(file_name,'.pgm'));
   current_ppm_file = fullfile(final_path,strcat(file_name,'.ppm'))
   current_txt_file  = fullfile(final_path,strcat(file_name,'.txt'));
   path_file = fullfile(final_path,strcat(strcat(file_name,'_path'),'.txt'));
   
   
   make_ppm_file_out_of_pgm(current_grid_map_file,current_ppm_file);
   %create txt image file for skeleton maker out of ppm
   I = imread(current_ppm_file);
   I = I(:,:,1);
   imshow(I);
   
   
   
end


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
    dlmwrite(path_file,path);
    
    print_image_ascii(I,current_txt_file);
    % Call testDivergenceSkeletonMaker    
    
    
    fullGsPath = 'testDivergenceSkeletonMaker.exe';
    
    comandLine = strcat(fullGsPath,{' '},int2str(step));
    [stat, res] = system(comandLine{1});
    
   viw = 1;

end

    function view(source,callbackdata)
        imPsName = fullfile( final_path,strcat(int2str(step),'.ps'))
        imName = fullfile( final_path,strcat(int2str(step),'.png'))
        eps2xxx(imPsName,{'png'});
        Ips = imread(imName);
        figure;
        imshow(Ips)
    end


end


