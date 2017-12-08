clear;close all;clc;
I = imread('envelope3.jpg');
Imed = medfilt2(I, [100 100]);
Ifinal = Imed - I;

BW = Ifinal > 50;


[H, theta, rho] = hough(BW);
[maxH, maxHIndex] = max(max(H));
Hgray = mat2gray(H);
Hadj = imadjust(Hgray);
Irot = imrotate(BW, maxHIndex-1.5, 'crop');

figure,
imshow(Irot)

Icrp = imcrop(Irot, [0 723 748 434]);


figure,
imshow(Hadj, 'InitialMagnification', 'fit'); axis normal;


Imorph = imopen(Icrp, strel('square', 8));
Imorph = imclose(Imorph, strel('square', 8));
[labels, number] = bwlabel(Imorph, 8);
Istats = regionprops(labels, 'basic', 'Centroid');
[values, index] = sort([Istats.Area], 'descend');
[maxVal, maxIndex] = max([Istats.Area]);


imshow(Icrp)
hold on;
for n = 3:number
   Istats(n).BoundingBox(2) = Istats(n).BoundingBox(2) + 35;
   Istats(n).BoundingBox(4) = Istats(n).BoundingBox(4) + 85;
    rectangle('Position', ...
        [Istats(n).BoundingBox], ...
        'LineWidth',2,'EdgeColor','r');
end
figure,
mesh(H)
view(0,90)
colormap(hot)