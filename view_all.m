close all;


%imgs = [30];

imgs = 25:25;

fig = figure;

for i=1:size(imgs,2)

    i
%    clf;

    imName = fullfile('ps_closer',strcat(int2str(imgs(i)),'.ps'));
    eps2xxx(imName,{'png'});

    imName = fullfile('ps_closer',strcat(int2str(imgs(i)),'.png'));

    img = imread(imName);
    imshow(img)


    %path_aks = fullfile('final',strcat(int2str(imgs(i)),'.pgm'));
    path_aks = fullfile('final_ppms',strcat(int2str(imgs(i)),'.ppm'));
    pgm = imread(path_aks);
    croped = CropImage(pgm);

    ratio = size(img,1)/size(croped,1);

    rt = strcat(num2str(ratio*100),'%');
    imwrite(croped,'tmp.png');

    fullGsPath = 'convert.exe';

    comandLine = ['"' fullGsPath '"' ' '  '"' 'tmp.png' '" ' '"' '-resize' '" ' '"' rt '" ' '"' 'tmp_resized.png' '"'];
    [stat, res] = system(comandLine);

    IN = imread('tmp_resized.png');

    I = IN(:,:,1);

    hold on;
    h = imshow(I);



    filter = zeros(size(I));

    for m=1:size(I,1)
        for n=1:size(I,2)
            if I(m,n) == 0
                filter(m,n) = 0.1;
            else
                filter(m,n) = 0;
            end
        end
    end

    set (h,'AlphaData', filter);
 
    imName = fullfile('output_closer',strcat(int2str(imgs(i)),'.jpg'))
    
    print(fig,'-djpeg','-r1000',imName);
    pause(2);


end

