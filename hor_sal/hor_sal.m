% ROTINA PARA PLOTAGEM DAS SEÇÕES HORIZONTAIS DE TEMPERATURA.
% Elaborado por Carina Novak

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%   IMPORTANTÍSSIMO: TODOS OS ARQUIVOS DEVEM ESTAR DENTRO DA   %%%
  %%%      MESMA PASTA, OU SEJA, A ROTINA, OS ARQUIVOS DE CTD E    %%%
  %%%                       OS ARQUIVOS .txt                       %%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear all, close all,

prof_hor=input('Qual a profundidade voce vai plotar?');

mat=['sechor_' num2str(prof_hor) '.dat'];
mat_sechor=load(mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% PLOTAGEM DA SEÇÃO HORIZONTAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Observar sequencia caso haja algum parâmetro que não foi criado e
%% comentar linha.

lat=mat_sechor(:,1);
lon=mat_sechor(:,2);
sal=mat_sechor(:,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cria a grade (GRID) para interpolaçao
x=input(['Qual a resolução da GRADE a ser usada no eixo x?? ' '\n' ...
    'ex: -52:1/8:-40 == ']);
y=input(['Qual a resolução da GRADE a ser usada no eixo y?? ' '\n' ...
    'ex: -30:1/8:-20 == ']);
[xi,yi]=meshgrid(x,y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interpolação dos dados no grid criado
%% Comentar linhas caso haja algum parâmetro que não foi criado.
gridsal=griddata(lon,lat,sal,xi,yi,'cubic');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carregamento dos dados de costa (Pladepo)
    load C:\MATLAB7\toolbox\apoc\costabrasil.dat; %%% MODIFICAR DIRETÓRIO
    long=costabrasil(:,1);
    lati=costabrasil(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% SALINIDADE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(long,lati,'k'); hold on;
set(gca,'AspectRatio',[a,s],'box','on','xlim',lonn,'ylim',latt,'FontSize',10,...
   'FontWeight','normal');
set (gca, 'xtick', [min(x):inclon:max(x)]);
set (gca, 'ytick', [min(y):inclat:max(y)]);

txt=['SALINIDADE (PSU) - ' num2str(prof_hor) 'm'];
title(txt,'fontsize',10,'fontweight', 'bold');
x1=xlabel('LONGITUDE','fontsize',10 ,'fontweight', 'bold'); y1=ylabel('LATITUDE', 'fontsize',10 ,'fontweight', 'bold');

% Plotagem colorida
disp(['VALORES MÍNIMO E MÁXIMO DE SALINIDADE DOS DADOS'])
disp([min(sal) max(sal)])
barmins=input(['Qual o valor mínimo de salinidade ' '\n' ...
    'a ser plotado na BARRA DE CORES?? == ']);
barmaxs=input(['Qual o valor máximo de salinidade ' '\n' ...
    'a ser plotado na BARRA DE CORES?? == ']);
lim=[barmins barmaxs];
pcolorc(gridsal,x,y,lim);
grid on; hold on; shading interp;

% Plota as isohalinas
inc=input('Qual o valor do intervalo entre as ISOHALINAS?? == ');
salt=[barmins:inc:barmaxs];
c=extcontour(xi,yi,gridsal,salt,'label',100,'fontsize',8,'color',[0.1 0.1 0.1]);

name=['salinidade_' num2str(prof_hor) 'm.png'];
% print ('-dpng',name);

% % Plota as isobatas 
% plot(x200,y200,'k'); plot(x1000,y1000,'k'); plot(x2000,y2000,'k'); hold on

% % Coloca preenchimento em terra e textos
% % fill(nc1_fill(:,1), nc1_fill(:,2), [0.1 0.1 0.1]);
% text(-44.20,-22.85,'Cabo Frio','fontsize',7,'color',[1 1 1]); plot(-42.02,-22.87,'w.');%%%%%%
% text(-41.8,-20.3,'Vitória','fontsize',7,'color',[1 1 1]); plot(-40.4,-20.32,'w.'); %%%%%%
% text(-47.95,-23.95,'Santos','fontsize',7,'color',[1 1 1]); plot(-46.4,-23.95,'w.');%%%%%%

