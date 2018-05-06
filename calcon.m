function L = calcon( P )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
SE = strel('square', 8);
%P=binarize(P);
P2=imerode(P,SE);
%P2=imdilate(P2,SE);
BW=logical(P2);
Y=bwlabel(BW);
L=max(max(Y));

end

