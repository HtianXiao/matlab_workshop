clear all
figure;
x=[1 5 6 7 9 5 1 3 12 20];
y=[20 15 6 3 1 5 3 0 1 5];
subplot(1,2,1);
scatter(x,y);   %����ɢ��ͼ
subplot(1,2,2);
scatter(x,y,[],[1 0 0],'fill');  %����ɢ��ͼ
