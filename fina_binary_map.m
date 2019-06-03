function fina_binary_map()

close all;

% FI = imread('148.pgm');
% figure;
% imshow(FI);
% figure;
I = imread(fullfile('final','5.pgm'));



[m,n] = size(I);
G = fspecial('gaussian',[5 5],4);


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
%     for i = 1 : m
% 
%         for j = 1 : n
%             if(i < 500 || i > (m-500) || j < 500 || j > (n-500))
%                 Ig(i,j) = 0;
%             end
%             
%         end
% 
%     end

BW2 = bwmorph(Ig,'remove');
imshow(BW2);
b=bwboundaries(BW2);


max_b_ind = 0;

max_size = 0;

second_max_size = 0;
second_max_size_ind = 0;



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
boundsImg = zeros(size(RP,1),size(RP,2),2);

T = b{szToIdx(3,1)};
size(b{szToIdx(3,1)})
F = poly2mask(T(:,1),T(:,2),size(RP,1),size(RP,2));
%figure;
%imshow(T);
extra_cnts = 0;
 for k = 7 : 4
     T = b{k};
     sz = size(T)
     if sz > 50
         extra_cnts = extra_cnts+1;
         boundsImg(:,:,extra_cnts) = poly2mask(T(:,1),T(:,2),size(RP,1),size(RP,2));
     end
%     figure;
%     imshow(boundsImg(:,:,k-1));
 end

 %F = (boundsImg(:,:,1)- (boundsImg(:,:,2)+boundsImg(:,:,3)))';
 
 
 for i = 1 : size(F,1)
     for j = 1 : size(F,2)
         if(F(i,j)==0)
             F(i,j) = 255;
         else
             clr = 0;
             if extra_cnts > 0
                 if(boundsImg(i,j,1)== 255)
                     clr = 255;
                 end
                 if extra_cnts > 1
                     if  boundsImg(i,j,2)== 255
                          clr = 255;
                     end
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
 
%  FR = imresize(F, 0.25);
figure;
 imshow(FCopy);
 imwrite(FCopy,'final.png');
 %imwrite(FR,'final-resized.ppm');
%     imshow(RP);




end
