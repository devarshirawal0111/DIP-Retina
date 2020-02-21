%Reading the image and extracting the channels
img = imread('02_test.tif');
[r, g, b] = imsplit(img);
imhist(g)

%Erosion and dilation on green channel of the image
SE = ones(5);
eroded_image = imerode(g,SE);
dilated_image = imdilate(eroded_image,SE);

%tophat transformations
hat_image = imbothat(dilated_image,SE);
%hat_image = 255 - (hat_image);

[threshold, out] = maxentropie(hat_image);
imshow(out);
