close all;

image = imread('segment.png');
cform = makecform('srgb2lab');
lab_image = applycform(image,cform);
ab = double(lab_image(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat timage clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
imshow(pixel_labels,[]), title('image labeled by cluster index');
segmented_images = cell(1,6);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = image;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure; imshow(segmented_images{1}), title('objects in cluster 1');
figure; imshow(segmented_images{2}), title('objects in cluster 2');
figure; imshow(segmented_images{3}), title('objects in cluster 3');
% figure; imshow(segmented_images{4}), title('objects in cluster 4');
% figure; imshow(segmented_images{5}), title('objects in cluster 5');
% figure; imshow(segmented_images{6}), title('objects in cluster 6');
