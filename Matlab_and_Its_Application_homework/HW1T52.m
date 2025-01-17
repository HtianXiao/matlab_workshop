R = 1;
l=1;
v=0.5*l;
theta = linspace(0, 2*pi, 100);
u = linspace(-0.5*l, 0.5*l, 100);

 
% 生成网格点
[U, Theta] = meshgrid(u, theta);
 
a=2;b=1;
% 计算参数方程
X = (R + U.*cos(0.5*a*Theta)+v*sin(0.5*a*Theta)).*cos(b*Theta);
Y = (R + U.*cos(0.5*a*Theta)+v*sin(0.5*a*Theta)).*sin(b*Theta);
Z = U.*sin(0.5*a*Theta)-v*cos(0.5*a*Theta);
 
% 计算每个网格单元格子的颜色
colormap(jet(256)); % 颜色映射，这里使用jet色标
C =abs(Theta-pi)/ (pi); % 每个网格单元格子的颜色，取值范围为[0,1]

% 绘制图像
surf(X, Y, Z, C, 'EdgeColor', 'none')

axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Mobius Strip');
colorbar; % 显示颜色条
hold on 
v=-0.5*l;
X = (R + U.*cos(0.5*a*Theta)+v*sin(0.5*a*Theta)).*cos(b*Theta);
Y = (R + U.*cos(0.5*a*Theta)+v*sin(0.5*a*Theta)).*sin(b*Theta);
Z = U.*sin(0.5*a*Theta)-v*cos(0.5*a*Theta);
surf(X, Y, Z, C, 'EdgeColor', 'none')
hold on 
[v, Theta] = meshgrid(u, theta);
U=0.5*l;
X = (R + U*cos(0.5*a*Theta)+v.*sin(0.5*a*Theta)).*cos(b*Theta);
Y = (R + U*cos(0.5*a*Theta)+v.*sin(0.5*a*Theta)).*sin(b*Theta);
Z = U*sin(0.5*a*Theta)-v.*cos(0.5*a*Theta);
surf(X, Y, Z, C, 'EdgeColor', 'none')
hold on 
U=-0.5*l;
X = (R + U*cos(0.5*a*Theta)+v.*sin(0.5*a*Theta)).*cos(b*Theta);
Y = (R + U*cos(0.5*a*Theta)+v.*sin(0.5*a*Theta)).*sin(b*Theta);
Z = U*sin(0.5*a*Theta)-v.*cos(0.5*a*Theta);
surf(X, Y, Z, C, 'EdgeColor', 'none')