close all;


%imgs = [30];

imgs = 1:148;

%fig = figure;

for i=1:size(imgs,2)

    imgs(i)

    imName = fullfile('cave',strcat(int2str(imgs(i)),'.ps'));
%     imName = fullfile('all_closer_ps',strcat(int2str(imgs(i)),'.ps'));
    eps2xxx(imName,{'png'});

    imName = fullfile('cave',strcat(int2str(imgs(i)),'.png'));
%     imName = fullfile('all_closer_ps',strcat(int2str(imgs(i)),'.png'));

    img = imread(imName);


    %path_aks = fullfile('final',strcat(int2str(imgs(i)),'.pgm'));
    path_aks = fullfile('cave',strcat(int2str(imgs(i)),'.ppm'));
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

    for m=1:min(size(I,1),size(img,1))
        for n=1:min(size(I,2),size(img,2))
            if I(m,n)<5 && img(m,n,1) >240 && img(m,n,2) >240 && img(m,n,3) >240
                img(m,n,:) = [220,220,220];
            end
        end
    end
        

    
    frm = imread('plain.png');
    W = size(frm,1);
    H = size(frm,2);    
    w = size(img,1);
    h = size(img,2);
    w1 = W-w;
    h1 = H-h;

    frm(1:w,h1:h1+h-1,:) = img(:,:,:);

    
%     imName = fullfile('ALL_CLOSER',strcat(int2str(imgs(i)),'.png'))
    imName = fullfile('CAVEVID',strcat(int2str(imgs(i)),'.png'))
    
    imwrite(frm,imName);
end

