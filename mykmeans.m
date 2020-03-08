function [ class, centroid ] = mykmeans( pixels, K )
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with K rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

% random cluster
rownum = size(pixels,1);
c = pixels(randperm(rownum,K),:);
iterno=10;
for iter = 1:iterno
    dist = pdist2(pixels,c);
    [val,lab] = min(dist,[],2);
    %assign new position
    P = sparse(1:rownum,lab,1,rownum,K,rownum);
    count = sum(P,1);
    
   c = bsxfun(@rdivide,P'*pixels,count');
end
class = lab;
centroid = c;
    
    
    
end

