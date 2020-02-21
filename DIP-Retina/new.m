clc;
clear;

img = imread('01_test.tif');
[r, g, b] = imsplit(img);
g = adapthisteq(g);
bw = g;

SE = strel('disk',5);
%SE = strel('square',5);
 bw3 = imopen(bw,SE);
% %imshow(bw3);
% 
 marker = imerode(bw,SE);
 mask = bw;
%mid = imerode(bw,SE);
%mid = imdilate(mid,SE);

mid = imreconstruct(marker,mask);
%imshow(something);

mid = imbothat(mid, SE);
%mid = 255 - mid;
mid = adapthisteq(mid);
%SE2 = strel('disk',5);

%mid = imopen(mid,SE2);
%mid = imclose(mid,SE2);
%figure(1);
%[threshold, mid] = maxentropie(mid);

%imshow(mid);






%---------------------------Matched Filtering-----------------


img = im2double(mid);

s = 1.5; %sigma
L = 7;
theta = 0:15:360; %different rotations

out = zeros(size(img));

m = max(ceil(3*s),(L-1)/2);
[x,y] = meshgrid(-m:m,-m:m); % non-rotated coordinate system, contains (0,0)
for t = theta
   t = t / 180 * pi;        % angle in radian
   u = cos(t)*x - sin(t)*y; % rotated coordinate system
   v = sin(t)*x + cos(t)*y; % rotated coordinate system
   N = (abs(u) <= 3*s) & (abs(v) <= L/2); % domain
   k = exp(-u.^2/(2*s.^2)); % kernel
   k = k - mean(k(N));
   k(~N) = 0;               % set kernel outside of domain to 0

   res = conv2(img,k,'same');
   out = max(out,res);
end

out = out/max(out(:)); % force output to be in [0,1] interval that MATLAB likes
%imwrite(out,'so_result.png')
out2 = uint8(255*out);
%imshow(out);
[threshold, final] = maxentropie(out2);
for i = 1:size(out,1)
    for j = 1:size(out,2)
       if out(i,j) < (35/255)
           out(i,j)=1;
       else
           out(i,j)=0;
       end
    end
end
out = uint8(255*out);
output = out;
out2 = medfilt2(final);
out3 = medfilt2(out);

f = 21;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 19;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end


f = 17;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 15;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 13;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 11;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 9;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 7;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end

f = 5;
%structelememt = ones(7);
for i=1+f:size(out,1)-f
    for j=1+f:size(out,2)-f
        temp = out(i-f:i+f,j-f:j+f);
        sum = (255-out(i-f,j+f:j+f)) + (255-out(i+f,j-f:j+f)) + (255-out(i-f:i+f,j-f)) + (255-output(i-f:i+f,j+f));
        if sum==0
            out(i-f:i+f,j-f:j+f) = 255;
        end
    end
end


stel = strel('disk',1);
out = imerode(out,stel);
%figure, montage({img,out2,output,out});.
imshow(out);
