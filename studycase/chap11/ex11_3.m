function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
set(ax,'DataAspectRatio',[1 1.5 1]);
set(ax,'PlotBoxAspectRatio',[1.5 1 1]);
set(ax,'XLim',[-1.5 1.5]);
set(ax,'YLim',[-1.5 1.5]);
set(ax,'XTickMode','auto');
set(ax,'YTick',[ -1.2,...
 -1,...
 -0.79999999999999993,...
 -0.59999999999999987,...
 -0.39999999999999991,...
 -0.19999999999999996,...
 0,...
 0.19999999999999996,...
 0.39999999999999991,...
 0.59999999999999987,...
 0.79999999999999993,...
 1,...
 1.2,...
]);

% Geometry description��
pderect([-1 1 1 -1],'R1');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','R1')

% Boundary conditions��
pdetool('changemode',0)
pdesetbd(4,...
'dir',...
1,...
'1',...
'0')
pdesetbd(3,...
'neu',...
1,...
'0',...
'0')
pdesetbd(2,...
'dir',...
1,...
'1',...
'0')
pdesetbd(1,...
'neu',...
1,...
'0',...
'0')

% Mesh generation��
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
pdetool('initmesh')

% PDE coefficients��
pdeseteq(3,...
'1.0',...
'0.0',...
'0.0',...
'1.0',...
'linspace(0,5,31)',...
'atan(cos(pi/2*x))',...
'3*sin(pi*x).*exp(sin(pi/2*y))',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0';...
'0.0';...
'0.0';...
'1.0'])

% Solve parameters��
setappdata(pde_fig,'solveparam',...
str2mat('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings��
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 1 0 1 31 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE��
pdetool('solve')
