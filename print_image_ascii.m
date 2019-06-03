function print_image_ascii(I,filename)
fileID = fopen(filename','w');
[m,n] = size(I);
fprintf(fileID,'%d \n',m);
fprintf(fileID,'%d \n',n);
for i = 1 : m
        fprintf(fileID,'%d ',I(i,:));
        fprintf(fileID,'\n');

end
fclose(fileID);
end