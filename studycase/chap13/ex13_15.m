%����chess�ź�
load chess;
%�ֱ𱣴���DCT������С�������ı任ϵ��
blur1=X;
blur2=X;
%��ԭͼ������ά��ɢ���ұ任
ff1=dct2(X);
%�Ա任�����Ƶ����BUTTERWORTH�˲�
for i=1:256
   for j=1:256
      ff1(i,j)=ff1(i,j)/(1+(32768/(i*i+j*j))^2);
   end
end
%�ؽ��任���ͼ��
blur1=idct2(ff1);
%��ͼ��������Ķ�άС���ֽ�
[c,l]=wavedec2(X,2,'db3');
csize=size(c);
%�Ե�Ƶϵ�����зŴ����������Ƹ�Ƶϵ��
for i=1:csize(2);
   if(abs(c(i))<300)
      c(i)=c(i)*2;
   else
      c(i)=c(i)/2;
   end
end
%ͨ���������С��ϵ���ؽ�ͼ��
blur2=waverec2(c,l,'db3');
%��ʾ3��ͼ��
subplot(221);image(wcodemat(X,192));colormap(gray(256));
title('ԭʼͼ��','fontsize',18);
subplot(223);image(wcodemat(blur1,192));colormap(gray(256));
title('����DCT������ͼ��','fontsize',18);
subplot(224);image(wcodemat(blur2,192));colormap(gray(256));
title('����С��������ͼ��','fontsize',18);