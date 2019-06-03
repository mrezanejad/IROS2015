function fina_binary_map()


%close all;
% FI = imread('148.pgm');
% figure;
% imshow(FI);
%figure;

for aks = 1 : 1
    aks
    clf;
    path_aks = fullfile('..','final',strcat(int2str(aks),'.pgm'));
    I = imread(path_aks);
    
%     figure;
%     imshow(I);

    [m,n] = size(I);
    G = fspecial('gaussian',[10 10],4);


    R = zeros(size(I));
    RP = zeros(size(I));

    for i = 1 : m

        for j = 1 : n

            if(I(i,j)>250)
                R(i,j) = 255;
            end

            R(i,j) = 255 - R(i,j);
            RP(i,j) = 255;
        end

    end



    Ig = imfilter(R,G,'same');
    %     
        for i = 1 : m
    
            for j = 1 : n
                if(i < 500 || i > (m-500) || j < 500 || j > (n-500))
                    Ig(i,j) = 0;
                end
                
            end
    
        end

    BW2 = bwmorph(Ig,'remove');
%      figure;
%   imshow(BW2);
    b=bwboundaries(BW2);


    szToIdx = zeros(size(b,1),2);
    for tt=1:size(b,1)
        szToIdx(tt,:) = [tt,size(b{tt},1)];
    end
    
  
            
            

    for i = 1 : size(b,1)
        T1 = szToIdx(i,:);
        for j = i+1 : size(b,1)
            T2 = szToIdx(j,:);
            if T1(1,2) < T2(1,2)
                szToIdx(i,:) = T2;
                szToIdx(j,:) = T1;
                T1 = szToIdx(i,:);
            end
        end
    end
    

%    szToIdx

    % for i = 1 : size(b,1)
    %     T = b{i};
    %     sizeT = size(T,1);
    %     if(max_size < sizeT  && sizeT < 15000)
    %         
    %         second_max_size = max_size;
    %         second_max_size_ind = max_b_ind;
    %         max_size = sizeT;
    %         max_b_ind = i;
    %     end
    % end
    % 
    % 
    %  for i = 1 :size(b{max_b_ind})
    %      T = b{max_b_ind};
    %      RP(T(i,1),T(i,2)) = 0;
    %  end
    %  max_b_ind
    %  second_max_size_ind
    boundsImg = zeros(size(RP,1),size(RP,2),size(b,1));

    T = b{szToIdx(3,1)};
    F = poly2mask(T(:,1),T(:,2),size(RP,1),size(RP,2));
    szToIdx(2,1)
%     figure;
    size(T,1)


    extra_cnts = 0;
     for k = 4 : size(b,1)
         T = b{szToIdx(k,1)};
         sz = size(T,1);
         if sz > 100
             extra_cnts = extra_cnts+1;
             boundsImg(:,:,extra_cnts) = poly2mask(T(:,1),T(:,2),size(RP,1),size(RP,2));
         else
             break;
         end
    %     figure;
    %     imshow(boundsImg(:,:,k-1));
     end

     %F = (boundsImg(:,:,1)- (boundsImg(:,:,2)+boundsImg(:,:,3)))';
     

    extra_cnts
     
     for i = 1 : size(F,1)
         for j = 1 : size(F,2)
             if(F(i,j)==0)
                 F(i,j) = 255;
             else
                 clr = 0;
                 for cnt=2:extra_cnts
                     if(boundsImg(i,j,cnt) > 0 )
                         clr = 255;
                         break;
                     end         
                 end
                 F(i,j) = clr;
             end
         end
     end
     F = F';
     FCopy(:,:) = F(:,:);
    for i = 2 : size(F,1)-1 
        for j = 2 : size(F,2)-1
            if(F(i,j) > 0 )
                if(F(i-1,j-1)==0 ||F(i-1,j)==0 ||F(i-1,j+1)==0 ||F(i,j-1)==0 ||F(i,j+1)==0 ||F(i+1,j-1)==0 ||F(i+1,j)==0 ||F(i+1,j+1)==0) 
                    FCopy(i,j) = 0;

                end
            end
        end
    end

    path_aks_ppm = fullfile('ppm_images',strcat(int2str(aks),'.ppm'));
    imwrite(FCopy,'temp.png');
    %imshow(FCopy);
    %!convert temp.png -resize 50% temp_resized.png
    new_I = imread('temp.png');
    
    new_I = new_I(:,:,1);
    for i = 1 :size(new_I,1)
        for j = 1 : size(new_I,2)
            if(new_I(i,j) > 50)
                new_I(i,j) = 255;
            else
                new_I(i,j) = 0;
            end
        end
    end
    
%     [cropedImage,x1,x2,y1,y2] =  CropImage(new_I);
%     x1 = max(x1-50,0)
%     x2 = min(x2+50,size(new_I,1))
%     y1 = max(y1-50,0)
%     y2 = min(y2+50,size(new_I,2))    

    imwrite(new_I,path_aks_ppm);
    
    %     imshow(RP);
    
%         w = waitforbuttonpress;
%     while w == 0
%         pause(5);
%         w = waitforbuttonpress;
%     end
end



end
