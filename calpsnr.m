function [ output_args ] = calpsnr( p1,p2 )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[h,w]=size(p1);
Bit=8;                %����һ�������ö��ٶ�����λ
MAX=2^Bit-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((double(p1)-(p2)).^2))/(h*w);     %������
output_args=20*log10(MAX/sqrt(MES));           %��ֵ�����

end

