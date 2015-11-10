%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                         %%%
%%%   Plot horizontal - Dados processados   %%%
%%%                                         %%%
%%%        1T(RM2-T) Simone Barem           %%%
%%%                                         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all;

load P1TRI_adp.mat % Carrega o arquivo adp.mat resultante do processamento do CODAS. Esse arquivo carrega uma variavel estrutural. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variavel estrutural no Matlab
%                                                 
% Esse tipo de variável armazena matrizes de diversos formatos em seu interior. 
% Para chamá-la dentro do MATLAB devemos dar um load na variável estrutural, 
% que possui internamente uma variável estrutural de nome qualquer (ex: adp) 
% aonde estarão armazenadas as diversas matrizes (ex: u, v, lon, lat, tday, depth). 
% Para chamarmos cada matriz, basta digitarmos:
% nome_da_variável_estrutural . nome_da_matriz (ex: adp.u / adp.lon / etc).
%
% adp = u: [44x2244 double]
%       v: [44x2244 double]
%     lon: [1x2244 double]
%     lat: [1x2244 double]
%    tday: [1x2244 double]
%   depth: [44x1 double]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lat=adp.lat;
lon=adp.lon;
u=adp.u;
v=adp.v;
prof=adp.depth;

% Preparando para plotar
m_proj('mercator','lon',[-42 -25],'lat',[-22 -19], 'on'); % coordenadas da região
figure(1)
hold on
m_gshhs_h('patch',[1 1 .5]);
m_grid('box','fancy','xtick',4,'ytick',4,'yaxislocation','left','xaxislocation','bottom','fontsize',8)

% Escolher a profundidade de interesse no vetor prof
p=prof(1);
uu=(u(1,:)/100);% dividimos por 100 para transformar para m/s
vv=(v(1,:)/100);

% artificio para plotar dados com intervalo
a=[1:1:length(uu)];

% Plotando...
m_vec(3,lon(a),lat(a),uu(a),vv(a),'shaftwidth', 0.01, 'headlength', 2);

% alterar o titulo do grafico de acordo com a profundidade escolhida
title('Campo de Correntes (m/s) - 30 m de profundidade ','FontSize',12,'FontAngle','normal','FontWeight','normal','color',[0,0,0],'fontname','garamond')

xlabel('Longitude','FontSize',10,'FontAngle','normal','FontWeight','normal','color',[0,0,0],'fontname','garamond')
ylabel('Latitude','FontSize',10,'FontAngle','normal','FontWeight','normal','color',[0,0,0],'fontname','garamond')

% Plotando o vetor de referencia de 1 m/s
m_vec(3,-27.5000,-21.500,1,0,'shaftwidth', 0.01, 'headlength', 2);
m_text(-27.4500,-21.2000,'1 m/s','FontSize',7,'FontAngle','normal','FontWeight','normal','color',[.01,.01,.01]);


%isobatas 50, 200, 1000 e 3000 m
load etopo2_E_751x901.xyz;

x=etopo2_E_751x901(:,1);
y=etopo2_E_751x901(:,2);
z=etopo2_E_751x901(:,3);

x = reshape(x,751,901);
y = reshape(y,751,901);
z = reshape(z,751,901);

% contour(x,y,z); close(1);
z=smoo2(z,-9999,7,0.1);

m_contour(x,y,z,[-3000 -1000 -200 -50],'color',[1 .5 .01]);


