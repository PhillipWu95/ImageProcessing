function L = calcon( P )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
SE = strel('square', 8);
%P=binarize(P);
P2=imerode(P,SE);
%P2=imdilate(P2,SE);
BW=logical(P2);
Y=bwlabel(BW);
L=max(max(Y));

end

