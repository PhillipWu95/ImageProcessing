function I = binarize( I )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
s=size(I);
for m=1:s(1)
    for n=1:s(2)
        if I(m,n)>=128;
            I(m,n)=255;
        else I(m,n)=0;
        end
    end
end

end

