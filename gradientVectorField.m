I = imread('143.ppm');
I = double(I);
I = ones(size(I))*255 - I;
[gx,gy] = gradient(double(I));
g = abs(gx) + abs(gy);
figure;
imshow(g, []);  % [] to display image properly     
hold on;

[Nx, Ny] = size(g);
xidx = 1:2:Nx;
yidx = 1:2:Ny;
[X,Y] = meshgrid(xidx,yidx);
quiver(Y',X',abs(gx(xidx,yidx)),abs(gy(xidx,yidx)));