%װ��һ����ά�ź�
load wbarb
%��ʾͼ��
subplot(121);image(X);colormap(map)
title('ԭʼͼ��');
axis square
%�������ͼ��ѹ��
%��ͼ����db3С�����ж���С���ֽ�
[c,s]=wavedec2(X,2,'db3');
%ʹ��wavedec2������ʵ��ͼ���ѹ��
[thr,sorh,keepapp]=ddencmp('cmp','wv',X);
%���������ѡ����ȫ����ֵѡ�gbl�������������и�Ƶϵ��������ͬ����ֵ��������
[Xcomp,cxc,lxc,perf0,perfl2]=wdencmp('gbl',c,s,'db3',2,thr,sorh,keepapp);
%��ѹ�����ͼ����ԭʼͼ����Ƚϣ�����ʾ����
subplot(122);image(Xcomp);colormap(map)
title('ѹ��ͼ��');
axis square
disp('С���ֽ�ϵ������0��ϵ�������ٷֱȣ�');
perf0
disp('ѹ����ͼ��ʣ�������ٷֱȣ�');
perfl2