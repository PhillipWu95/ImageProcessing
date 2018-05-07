function [ output_args ] = calpsnr( p1,p2 )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[h,w]=size(p1);
Bit=8;                %The order of bits to encode a pixel
MAX=2^Bit-1;          %The grey scale level of an image
MES=sum(sum((double(p1)-(p2)).^2))/(h*w);     %Mean square error
output_args=20*log10(MAX/sqrt(MES));           %Peak value SNR

end

