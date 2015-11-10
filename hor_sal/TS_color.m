% ROTINA PARA CONFECÇÃO DE DIAGRAMA TS (COLORIDO POR FROFUNDIDADE)
% Elaborado por 1T(RM2-T) Carina Novak Laprea

% Criar um arquivo nomeado como 'estaçoes.txt' (linha 29),
% contendo o nome dos arquivos .cnv (CTD), em sequencia, das estações que 
% que ser plotadas.
% Cada nome deve estar em uma linha, e todos os nomes devem ter o mesmo
% número de letras.
% Ex.: CEII001.cnv
%      CEII002.cnv
%      CEII003.cnv

% MODIFICAR A LINHA 21 DA ROTINA COM O NÚMERO DE LETRAS DO NOME DO ARQUIVO
% DE CTD (CONTANDO O PONTO E A EXTENSÃO).

clear all, close all,

nest=input('Qual o número total de estações a serem plotadas?? ');
letras= 10; % MODIFICAR

fid=fopen('estaçoes.txt', 'r');
name=fscanf(fid,'%s',[letras inf]);
name=name';

%%% Plotagem das isopcnais (linhas de mesma densidade)
Se=23:39; Te=-1.5:33;
[Sg,Tg]=meshgrid(Se,Te);
dens=sw_dens0(Sg,Tg)-1000;

for j=1:nest;
esta=name(j,1:letras);    
readflat(esta,1);
        t1=ans(:,11); % MODIFICAR
        s1=ans(:,13); % MODIFICAR
        prof=ans(:,10); % MODIFICAR
%figure
        for m=1:size(prof);
                if prof(m)<= 200;
         plot(s1(m),t1(m),'*r');hold on;
                elseif prof(m)> 200 & prof(m)<= 500;
         plot(s1(m),t1(m),'*g');hold on;
                elseif prof(m)> 500 & prof(m)<= 1000;
         plot(s1(m),t1(m),'*b');hold on;
                elseif prof(m)>1000 & prof(m)<= 1500;
         plot(s1(m),t1(m),'*c');hold on;
                else
         plot(s1(m),t1(m),'*m');hold on;
                end
        end
% l1=legend('< 200m','201-500m','501-1000m','1001-1500m','> 1501m',4);
% set(l1,'position',[0.6   0.17   0.23   0.10]);
end

axis([34 37 0 30]); % MODIFICAR
     set(gca,'xtick',[34 :.5: 37]);hold on; % MODIFICAR
    % set(gca,'xtick',[33 33.5 34 34.5 38]);hold on; % MODIFICAR

     contour(Se,Te,dens,[13:.5:30],':k');hold on; % MODIFICAR  
%      contour(Se,Te,dens,[25 25.5 26 26.5 27 27.5 28],'--k'); hold on;  

% Insere nome nos eixos
x1=xlabel('SALINIDADE','fontsize',10 ,'fontweight', 'bold'); y1=ylabel('TEMPERATURA POTENCIAL - (°C)', 'fontsize',10 ,'fontweight', 'bold');
l1=legend('< 200m','201-500m','501-1000m','1001-1500m','> 1501m',4);
set(l1,'position',[0.6   0.17   0.23   0.10]);

% Insere titulo com numero da estacao
    txt=['\bfOCEANO NORTE II - TS ']; title(txt); % MODIFICAR
    handle = get(gca,'title');
    set(handle,'visible','on');
    namest=['TS_COLOR.png']; % MODIFICAR
    print ('-dpng',namest);

