%% ����Ϊ matrixplot.m �ļ�
function h = matrixplot(data,varargin)
%   ����ʵֵ�������ɫ��ͼ���÷ḻ����ɫ����״�����չʾ����Ԫ��ֵ�Ĵ�С��
%   ���ػ�ͼ���ھ��
%
%   matrixplot(data) ���ƾ���ɫ��ͼ��dataΪʵֵ����ÿһ��Ԫ�ض�Ӧһ��ɫ�飬ɫ
%                    ����ɫ��Ԫ��ֵ��С������
%
%   matrixplot(data, 'PARAM1',val1, 'PARAM2',val2, ...) 
%          �óɶԳ��ֵĲ�����/����ֵ����ɫ��ĸ������ԡ����õĲ�����/����ֵ���£�
%          'FigShape' --- �趨ɫ�����״�������ֵΪ��
%                'Square'  --- ���Σ�Ĭ�ϣ�
%                'Circle'  --- Բ��
%                'Ellipse' --- ��Բ��
%                'Hexagon' --- ������
%                'Dial'    --- ������
%
%          'FigSize' --- �趨ɫ��Ĵ�С�������ֵΪ��
%                'Full'    --- ���ɫ�飨Ĭ�ϣ�
%                'Auto'    --- ���ݾ���Ԫ��ֵ�Զ�ȷ��ɫ���С
%
%          'FigStyle' --- �趨����ͼ��ʽ�������ֵΪ��
%                'Auto'    --- ���ξ���ͼ��Ĭ�ϣ�
%                'Tril'    --- �����Ǿ���ͼ
%                'Triu'    --- �����Ǿ���ͼ
%
%          'FillStyle' --- �趨ɫ�������ʽ�������ֵΪ��
%                'Fill'    --- ���ɫ���ڲ���Ĭ�ϣ�
%                'NoFill'  --- �����ɫ���ڲ�
%
%          'DisplayOpt' --- �趨�Ƿ���ɫ������ʾ����Ԫ��ֵ�������ֵΪ��
%                'On'      --- ��ʾ����Ԫ��ֵ��Ĭ�ϣ�
%                'Off'     --- ����ʾ����Ԫ��ֵ
%
%          'TextColor' --- �趨���ֵ���ɫ�������ֵΪ��
%                ��ʾ��ɫ���ַ���'r','g','b','y','m','c','w','k'��,Ĭ��Ϊ��ɫ
%                1��3�еĺ졢�̡�����Ԫɫ�Ҷ�ֵ������[r,g,b]��
%                'Auto'    --- ���ݾ���Ԫ��ֵ�Զ�ȷ��������ɫ
%
%          'XVarNames' --- �趨X�᷽����Ҫ��ʾ�ı�������Ĭ��ΪX1,X2,...���������ֵΪ��
%                �ַ���������ַ���Ԫ�����飬��Ϊ�ַ�������������Ӧ��data��������ͬ
%                ��Ϊ�ַ���Ԫ�����飬�䳤��Ӧ��data��������ͬ��
%
%          'YVarNames' --- �趨Y�᷽����Ҫ��ʾ�ı�������Ĭ��ΪY1,Y2,...���������ֵΪ��
%                �ַ���������ַ���Ԫ�����飬��Ϊ�ַ�������������Ӧ��data��������ͬ
%                ��Ϊ�ַ���Ԫ�����飬�䳤��Ӧ��data��������ͬ��
%
%          'ColorBar' --- �趨�Ƿ���ʾ��ɫ���������ֵΪ��
%                'On'      --- ��ʾ��ɫ��
%                'Off'     --- ����ʾ��ɫ����Ĭ�ϣ�
%
%          'Grid' --- �趨�Ƿ���ʾ�����ߣ������ֵΪ��
%                'On'      --- ��ʾ�����ߣ�Ĭ�ϣ�
%                'Off'     --- ����ʾ������
%
%   Example:
%   x = [1,-0.2,0.3,0.8,-0.5
%        -0.2,1,0.6,-0.7,0.2
%         0.3,0.6,1,0.5,-0.3
%         0.8,-0.7,0.5,1,0.7
%        -0.5,0.2,-0.3,0.7,1];
%   matrixplot(x);
%   matrixplot(x,'DisplayOpt','off');
%   matrixplot(x,'FillStyle','nofill','TextColor','Auto');
%   matrixplot(x,'TextColor',[0.7,0.7,0.7],'FigShap','s','FigSize','Auto','ColorBar','on');
%   matrixplot(x,'TextColor','k','FigShap','d','FigSize','Full','ColorBar','on','FigStyle','Triu');
%   XVarNames = {'xiezhh','heping','keda','tust','tianjin'};
%   matrixplot(x,'FigShap','e','FigSize','Auto','ColorBar','on','XVarNames',XVarNames,'YVarNames',XVarNames);
%
%   CopyRight��xiezhh��л�л���,2013.01.24��д


% �Ե�һ������������ͽ����ж�
if ~ismatrix(data) || ~isreal(data)
    error('����������Ͳ�ƥ�䣺��һ���������ӦΪʵֵ����');
end


% �����ɶԳ��ֵĲ�����/����ֵ
[FigShape,FigSize,FigStyle,FillStyle,DisplayOpt,TextColor,XVarNames,...
    YVarNames,ColorBar,GridOpt] = parseInputs(varargin{:});


% ������������
[m,n] = size(data);
[x,y] = meshgrid(0:n,0:m);
data = data(:);
maxdata = nanmax(data);
mindata = nanmin(data);
rangedata = maxdata - mindata;
if isnan(rangedata)
    warning('MATLAB:warning1','����������ľ����Ƿ���ʣ�');
    return;
end
z = zeros(size(x))+0.2;
sx = x(1:end-1,1:end-1)+0.5;
sy = y(1:end-1,1:end-1)+0.5;


if strncmpi(FigStyle,'Tril',4)
    z(triu(ones(size(z)),2)>0) = NaN;
    sx(triu(ones(size(sx)),1)>0) = NaN;
elseif strncmpi(FigStyle,'Triu',4)
    z(tril(ones(size(z)),-2)>0) = NaN;
    sx(tril(ones(size(sx)),-1)>0) = NaN;
end
sx = sx(:);
sy = sy(:);
id = isnan(sx) | isnan(data);
sx(id) = [];
sy(id) = [];
data(id) = [];


if isempty(XVarNames)
    XVarNames = strcat('X',cellstr(num2str((1:n)')));
else
    if (iscell(XVarNames) && (numel(XVarNames) ~= n)) || (~iscell(XVarNames) && (size(XVarNames,1) ~= n))
        error('X�᷽�������ӦΪ�ַ���������ַ���Ԫ�����飬�䳤������������������ͬ');
    end
end
if isempty(YVarNames)
    YVarNames = strcat('Y',cellstr(num2str((1:m)')));
else
    if (iscell(YVarNames) && (numel(YVarNames) ~= m)) || (~iscell(YVarNames) && (size(YVarNames,1) ~= m))
        error('Y�᷽�������ӦΪ�ַ���������ַ���Ԫ�����飬�䳤������������������ͬ');
    end
end


% ��ͼ
h = figure('color','w',...
    'units','normalized',...
    'pos',[0.289165,0.154948,0.409956,0.68099]);
axes('units','normalized','pos',[0.1,0.022,0.89,0.85]);
if strncmpi(GridOpt,'On',2)
    mesh(x,y,z,...
        'EdgeColor',[0.7,0.7,0.7],...
        'FaceAlpha',0,...
        'LineWidth',1);   % �ο�������
end
hold on;
axis equal;
axis([-0.1,n+0.1,-0.1,m+0.1,-0.5,0.5]);
view(2);
% ����X���Y��̶�λ�ü���ǩ
set(gca,'Xtick',(1:n)-0.5,...
    'XtickLabel',XVarNames,...
    'Ytick',(1:m)-0.5,...
    'YtickLabel',YVarNames,...
    'XAxisLocation','top',...
    'YDir','reverse',...
    'Xcolor',[0.7,0.7,0.7],...
    'Ycolor',[0.7,0.7,0.7],...
    'TickLength',[0,0]);
axis off


% �������ɫ��
if strncmpi(FillStyle,'Fill',3)
    MyPatch(sx',sy',data',FigShape,FigSize);
end


% ��ʾ��ֵ�ı���Ϣ
if strncmpi(DisplayOpt,'On',2)
    str = num2str(data,'%4.2f');
    scale = 0.1*max(n/m,1)/(max(m,n)^0.55);
    if strncmpi(TextColor,'Auto',3)
        ColorMat = get(gcf,'ColorMap');
        nc = size(ColorMat,1);
        cid = fix(mapminmax(data',0,1)*nc)+1;
        cid(cid<1) = 1;
        cid(cid>nc) = nc;
        TextColor = ColorMat(cid,:);
        for i = 1:numel(data)
            text(sx(i),sy(i),0.1,str(i,:),...
                'FontUnits','normalized',...
                'FontSize',scale,...
                'fontweight','bold',...
                'HorizontalAlignment','center',...
                'Color',TextColor(i,:));
        end
    else
        text(sx,sy,0.1*ones(size(sx)),str,...
            'FontUnits','normalized',...
            'FontSize',scale,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'Color',TextColor);
    end
end


% ����X���Y��̶ȱ�ǩ��������ʽ
MyTickLabel(gca,FigStyle);


% �����ɫ��
if strncmpi(ColorBar,'On',2)
    if any(strncmpi(FigStyle,{'Auto','Triu'},4))
        colorbar('Location','EastOutside');
    else
        colorbar('Location','SouthOutside');
    end
end
end
% ---------------------------------------------------
%  ����������̶ȱ�ǩ�Ӻ���
% ---------------------------------------------------
function MyTickLabel(ha,tag)


%   ������ʾ��Χ�Զ�����������̶ȱ�ǩ�ĺ���
%   ha   ����ϵ���ֵ
%   tag  ����������̶ȱ�ǩ�ı�ʶ�ַ���������ȡֵ���£�
%        'Auto' --- ��x��̶ȱ�ǩ��ת90�ȣ�y��̶ȱ�ǩ��������
%        'Tril' --- ��x��̶ȱ�ǩ��ת90�ȣ�������������y��̶ȱ�ǩ��������
%        'Triu' --- ��x��̶ȱ�ǩ��ת90�ȣ�y��̶ȱ�ǩ��������
%   Example:
%   MyTickLabel(gca,'Tril');
%
%   CopyRight��xiezhh��л�л���,2013.1��д


if ~ishandle(ha)
    warning('MATLAB:warning2','��һ���������ӦΪ����ϵ���');
    return;
end


if ~strcmpi(get(ha,'type'),'axes')
    warning('MATLAB:warning3','��һ���������ӦΪ����ϵ���');
    return;
end


axes(ha);
xstr = get(ha,'XTickLabel');
xtick = get(ha,'XTick');
xl = xlim(ha);
ystr = get(ha,'YTickLabel');
ytick = get(ha,'YTick');
yl = ylim(ha);
set(ha,'XTickLabel',[],'YTickLabel',[]);
x = zeros(size(ytick)) + xl(1) - range(xl)/30;
y = zeros(size(xtick)) + yl(1) - range(yl)/70;
nx = numel(xtick);
ny = numel(ytick);


if strncmpi(tag,'Tril',4)
    y = y + (1:nx) - 1;
elseif strncmpi(tag,'Triu',4)
    x = x + (1:ny) - 1;
end


% text(xtick,y,xstr,...
%     'rotation',90,...
%     'Interpreter','none',...
%     'color','r',...
%     'HorizontalAlignment','left');
text(xtick,y,xstr,...
    'Interpreter','none',...
    'color','k',...
    'HorizontalAlignment','left');
text(x,ytick,ystr,...
    'Interpreter','none',...
    'color','k',...
    'HorizontalAlignment','right');
end
% ---------------------------------------------------
%  ����ɢ�����ݻ���3άɫ��ͼ�Ӻ���
% ---------------------------------------------------
function  MyPatch(x,y,z,FigShape,FigSize)
%   ����ɢ�����ݻ���3άɫ��ͼ
%   MyPatch(x,y,z,FigShape,FigSize)  x,y,z��ʵֵ���飬����ָ��ɫ�����ĵ���ά
%          ���ꡣFigShape���ַ�������������ָ��ɫ����״��
%          FigSize���ַ�������������ָ��ɫ���С��
%
%   CopyRight:xiezhh��л�л���, 2013.01 ��д
%
%   Example��
%         x = rand(10,1);
%         y = rand(10,1);
%         z = rand(10,1);
%         MyPatch(x,y,z,'s','Auto');
%


% ������������ж�
if nargin < 3
    error('������Ҫ�����������');
end
if ~isreal(x) || ~isreal(y) || ~isreal(z)
    error('ǰ��������ӦΪʵֵ����');
end


n = numel(z);
if numel(x) ~= n || numel(y) ~= n
    error('����Ӧ�ȳ�');
end


if strncmpi(FigSize,'Auto',3) && ~strncmpi(FigShape,'Ellipse',1)
    id = (z == 0);
    x(id) = [];
    y(id) = [];
    z(id) = [];
end
if isempty(z)
    return;
end


% ��ɫ�鶥������
rab1 = ones(size(z));
maxz = max(abs(z));
if maxz == 0
    maxz = 1;
end
rab2 = abs(z)/maxz;
if strncmpi(FigShape,'Square',1)
    % ����
    if strncmpi(FigSize,'Full',3)
        r = rab1;
    else
        r = sqrt(rab2);
    end
    SquareVertices(x,y,z,r);
elseif strncmpi(FigShape,'Circle',1)
    % Բ��
    if strncmpi(FigSize,'Full',3)
        r = 0.5*rab1;
    else
        r = 0.5*sqrt(rab2);
    end
    CircleVertices(x,y,z,r);
elseif strncmpi(FigShape,'Ellipse',1)
    % ��Բ��
    a = 0.48 + rab2*(0.57-0.48);
    b = (1-rab2).*a;
    EllipseVertices(x,y,z,a,b);
elseif strncmpi(FigShape,'Hexagon',1)
    % ������
    if strncmpi(FigSize,'Full',3)
        r = 0.5*rab1;
    else
        r = 0.5*sqrt(rab2);
    end
    HexagonVertices(x,y,z,r);
else
    % ������
    if strncmpi(FigSize,'Full',3)
        r = 0.45*rab1;
    else
        r = 0.45*sqrt(rab2);
    end
    DialVertices(x,y,z,r);
end
end
%--------------------------------------------------
% ��ɫ�鶥�����겢����ɫ����Ӻ���
%--------------------------------------------------
function SquareVertices(x,y,z,r)
% ����
hx = r/2;
hy = hx;
Xp = [x-hx;x-hx;x+hx;x+hx;x-hx];
Yp = [y-hy;y+hy;y+hy;y-hy;y-hy];
Zp = repmat(z,[5,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor','flat');
end


function CircleVertices(x,y,z,r)
% Բ��
t = linspace(0,2*pi,30)';
m = numel(t);
Xp = repmat(x,[m,1])+cos(t)*r;
Yp = repmat(y,[m,1])+sin(t)*r;
Zp = repmat(z,[m,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor','flat');
end


function EllipseVertices(x,y,z,a,b)
% ��Բ��
t = linspace(0,2*pi,30)';
m = numel(t);
t0 = -sign(z)*pi/4;
t0 = repmat(t0,[m,1]);
x0 = cos(t)*a;
y0 = sin(t)*b;
Xp = repmat(x,[m,1]) + x0.*cos(t0) - y0.*sin(t0);
Yp = repmat(y,[m,1]) + x0.*sin(t0) + y0.*cos(t0);
Zp = repmat(z,[m,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor','flat');
end


function HexagonVertices(x,y,z,r)
% ������
t = linspace(0,2*pi,7)';
m = numel(t);
Xp = repmat(x,[m,1])+cos(t)*r;
Yp = repmat(y,[m,1])+sin(t)*r;
Zp = repmat(z,[m,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor','flat');
end


function DialVertices(x,y,z,r)
% ������
% ���Ʊ�������
maxz = max(abs(z));
t0 = z*2*pi/maxz-pi/2;
t0 = cell2mat(arrayfun(@(x)linspace(-pi/2,x,30)',t0,'UniformOutput',0));
m = size(t0,1);
r0 = repmat(r,[m,1]);
Xp = [x;repmat(x,[m,1]) + r0.*cos(t0);x];
Yp = [y;repmat(y,[m,1]) + r0.*sin(t0);y];
Zp = repmat(z,[m+2,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor',[0,0,0]);


% ���Ʊ���Բ��
t = linspace(0,2*pi,30)';
m = numel(t);
Xp = repmat(x,[m,1])+cos(t)*r;
Yp = repmat(y,[m,1])+sin(t)*r;
Zp = repmat(z,[m,1]);
Xp = [Xp;flipud(Xp)];
Yp = [Yp;flipud(Yp)];
Zp = [Zp;flipud(Zp)];
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor',[0,0,0]);
end
%--------------------------------------------------------------------------
%  ������������Ӻ���1
%--------------------------------------------------------------------------
function [FigShape,FigSize,FigStyle,FillStyle,DisplayOpt,TextColor,...
    XVarNames,YVarNames,ColorBar,GridOpt] = parseInputs(varargin)


if mod(nargin,2)~=0
    error('��������������ԣ�ӦΪ�ɶԳ���');
end
pnames = {'FigShape','FigSize','FigStyle','FillStyle','DisplayOpt',...
    'TextColor','XVarNames','YVarNames','ColorBar','Grid'};
dflts =  {'Square','Full','Auto','Fill','On','k','','','Off','On'};
[FigShape,FigSize,FigStyle,FillStyle,DisplayOpt,TextColor,XVarNames,...
    YVarNames,ColorBar,GridOpt] = parseArgs(pnames, dflts, varargin{:});


validateattributes(FigShape,{'char'},{'nonempty'},mfilename,'FigShape');
validateattributes(FigSize,{'char'},{'nonempty'},mfilename,'FigSize');
validateattributes(FigStyle,{'char'},{'nonempty'},mfilename,'FigStyle');
validateattributes(FillStyle,{'char'},{'nonempty'},mfilename,'FillStyle');
validateattributes(DisplayOpt,{'char'},{'nonempty'},mfilename,'DisplayOpt');
validateattributes(TextColor,{'char','numeric'},{'nonempty'},mfilename,'TextColor');
validateattributes(XVarNames,{'char','cell'},{},mfilename,'XVarNames');
validateattributes(YVarNames,{'char','cell'},{},mfilename,'YVarNames');
validateattributes(ColorBar,{'char'},{'nonempty'},mfilename,'ColorBar');
validateattributes(GridOpt,{'char'},{'nonempty'},mfilename,'Grid');
if ~any(strncmpi(FigShape,{'Square','Circle','Ellipse','Hexagon','Dial'},1))
    error('��״����ֻ��ΪSquare, Circle, Ellipse, Hexagon, Dial ֮һ');
end
if ~any(strncmpi(FigSize,{'Full','Auto'},3))
    error('ͼ�δ�С����ֻ��ΪFull, Auto ֮һ');
end
if ~any(strncmpi(FigStyle,{'Auto','Tril','Triu'},4))
    error('ͼ����ʽ����ֻ��ΪAuto, Tril, Triu ֮һ');
end
if ~any(strncmpi(FillStyle,{'Fill','NoFill'},3))
    error('ͼ�������ʽ����ֻ��ΪFill, NoFill ֮һ');
end
if ~any(strncmpi(DisplayOpt,{'On','Off'},2))
    error('��ʾ��ֵ����ֻ��ΪOn��Off ֮һ');
end
if ~any(strncmpi(ColorBar,{'On','Off'},2))
    error('��ʾ��ɫ������ֻ��ΪOn��Off ֮һ');
end
if ~any(strncmpi(GridOpt,{'On','Off'},2))
    error('��ʾ�������ֻ��ΪOn��Off ֮һ');
end
end
%--------------------------------------------------------------------------
%  ������������Ӻ���2
%--------------------------------------------------------------------------
function [varargout] = parseArgs(pnames,dflts,varargin)
%   Copyright 2010-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/05/09 01:27:26 $


% Initialize some variables
nparams = length(pnames);
varargout = dflts;
setflag = false(1,nparams);
unrecog = {};
nargs = length(varargin);


dosetflag = nargout>nparams;
dounrecog = nargout>(nparams+1);


% Must have name/value pairs
if mod(nargs,2)~=0
    m = message('stats:internal:parseArgs:WrongNumberArgs');
    throwAsCaller(MException(m.Identifier, '%s', getString(m)));
end


% Process name/value pairs
for j=1:2:nargs
    pname = varargin{j};
    if ~ischar(pname)
        m = message('stats:internal:parseArgs:IllegalParamName');
        throwAsCaller(MException(m.Identifier, '%s', getString(m)));
    end
    
    mask = strncmpi(pname,pnames,length(pname)); % look for partial match
    if ~any(mask)
        if dounrecog
            % if they've asked to get back unrecognized names/values, add this
            % one to the list
            unrecog((end+1):(end+2)) = {varargin{j} varargin{j+1}};
            continue
        else
            % otherwise, it's an error
            m = message('stats:internal:parseArgs:BadParamName',pname);
            throwAsCaller(MException(m.Identifier, '%s', getString(m)));
        end
    elseif sum(mask)>1
        mask = strcmpi(pname,pnames); % use exact match to resolve ambiguity
        if sum(mask)~=1
            m = message('stats:internal:parseArgs:AmbiguousParamName',pname);
            throwAsCaller(MException(m.Identifier, '%s', getString(m)));
        end
    end
    varargout{mask} = varargin{j+1};
    setflag(mask) = true;
end


% Return extra stuff if requested
if dosetflag
    varargout{nparams+1} = setflag;
    if dounrecog
        varargout{nparams+2} = unrecog;
    end
end
end