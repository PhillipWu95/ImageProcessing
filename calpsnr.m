function [ output_args ] = calpsnr( p1,p2 )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[h,w]=size(p1);
Bit=8;                %编码一个像素用多少二进制位
MAX=2^Bit-1;          %图像有多少灰度级
MES=sum(sum((double(p1)-(p2)).^2))/(h*w);     %均方差
output_args=20*log10(MAX/sqrt(MES));           %峰值信噪比

end

