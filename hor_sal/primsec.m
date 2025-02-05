% ROTINA PARA COMPARA�AO ENTRE OS PERFIS PRIM�RIOS E SECUND�RIOS
% Elaborado por 1T(RM2-T) Carina Novak Laprea

% Criar um arquivo nomeado como 'descida.txt' (linha 29),
% contendo o nome dos arquivos .cnv (CTD), em sequencia, das esta��es que 
% que ser plotadas.
% Cada nome deve estar em uma linha, e todos os nomes devem ter o mesmo
% n�mero de letras.
% Ex.: dCEII001.cnv
%      dCEII002.cnv
%      dCEII003.cnv

% Criar um arquivo nomeado como 'subida.txt' (linha 33),
% contendo o nome dos arquivos .cnv (CTD), em sequencia, das esta��es que 
% que ser plotadas.
% Cada nome deve estar em uma linha, e todos os nomes devem ter o mesmo
% n�mero de letras.
% Ex.: uCEII001.cnv
%      uCEII002.cnv
%      uCEII003.cnv

% MODIFICAR A LINHA 28 DA ROTINA COM O N�MERO DE LETRAS DO NOME DO ARQUIVO
% DE CTD (CONTANDO O PONTO E A EXTENS�O).

clear all, close all,

nest=input('Qual o n�mero total de esta��es a serem plotadas?? ');
letras= 10   % MODIFICAR
fid=fopen('descida.txt', 'r');
named=fscanf(fid,'%s',[letras inf]);
named=named';

fid=fopen('subida.txt', 'r');
names=fscanf(fid,'%s',[letras inf]);
names=names';

for j=1:nest;
estad=named(j,1:letras);  %DESCIDA   
dados=readflat(estad,1);
        td1=dados(:,11);  % temp descida prim  MODIFICAR COLUNA
        sd1=dados(:,13);  % sal descida prim   MODIFICAR COLUNA
        dd1=dados(:,17);  % dens descida prim  MODIFICAR COLUNA
        td2=dados(:,12);  % temp descida sec  MODIFICAR COLUNA
        sd2=dados(:,14);  % sal descida sec   MODIFICAR COLUNA
        dd2=dados(:,18);  % dens descida sec  MODIFICAR COLUNA
        profd=dados(:,10)*-1;

estas=names(j,1:letras);  %SUBIDA
dados=readflat(estas,1);
        ts1=dados(:,11); % temp subida prim   MODIFICAR COLUNA
        ss1=dados(:,13); % sal subida prim    MODIFICAR COLUNA
        ds1=dados(:,17); % dens subida prim   MODIFICAR COLUNA
        ts2=dados(:,12); % temp subida sec   MODIFICAR COLUNA
        ss2=dados(:,14); % sal subida sec    MODIFICAR COLUNA
        ds2=dados(:,18); % dens subida sec   MODIFICAR COLUNA
        profs=dados(:,10)*-1;
figure



%%%% DESCIDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Modificar os limites de T e S dos eixos (axis) usados nas esta�oes
%%%% rasas e profundas
subplot(131) %%TEMPERATURA
    plot(td1,profd,'r',td2,profd,'b');
    xlabel('\bfTemp');
    ylabel('\bfProfundidade (m)');

         if min(profd) >= -200; %esta�oes rasas
             axis ([20 29 min(profd) 0]);
             set(gca,'xtick',[20:2:29]); grid on;
%          elseif min(profd) < -200 & min(profd) >= -500;
%              axis ([10 29 min(profd) 0]);
%              set(gca,'xtick',[10:4:29]); grid on;
         else
             axis ([0 29 min(profd) 0]);
             set(gca,'xtick',[0:5:25]); grid on;
%             set(gca,'xtick',[22.5:1.25:27.5]); grid on;
         end
         
subplot(132)  %SALINIDADE
    plot(sd1,profd,'r',sd2,profd,'b');
    xlabel('\bfSal');

         if min(profd) >= -200; %esta�oes rasass
             axis ([32 37 min(profd) 0]);
             set(gca,'xtick',[34:37]); grid on;
%          elseif min(profd) < -200 & min(profd) >= -500;
%              axis ([33 37 min(profd) 0]);
%              set(gca,'xtick',[28:2:37]); grid on;
         else
             axis ([34 37 min(profd) 0]);
             set(gca,'xtick',[34:1:37]); grid on;
%             set(gca,'xtick',[22.5:1.25:27.5]); grid on;
         end
         
subplot(133)  %DENSIDADE
    plot(dd1,profd,'r',dd2,profd,'b');
             xlabel('\bfSigma-t');

         if min(profd) >= -200; %esta�oes rasas
             axis ([22 27 min(profd) 0]);
             set(gca,'xtick',[22:2:27]); grid on;
%          elseif min(profd) < -200 & min(profd) >= -500;
%              axis ([22 29 min(profd) 0]);
%              set(gca,'xtick',[16:3:29]); grid on;
         else
             axis ([22 29 min(profd) 0]);
             set(gca,'xtick',[22:3:29]); grid on;
         end

% Insere titulo central com numero da estacao
    axes('position',[.1 .88 .8 .05],'Box','off','Visible','off');
    txt=['\bfESTA�AO ' named(j,1) named(j,5:6) ' - red(prim) blue(sec)']; title(txt); % MODIFICAR COLUNAS
    handle = get(gca,'title');
    set(handle,'visible','on');
    namest=['esta��o_' named(j,5:6) '_down.png']; % MODIFICAR COLUNAS
    print ('-dpng',namest);
%     
%%%% SUBIDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Modificar os limites de T e S dos eixos (axis) usados nas esta�oes 
%%%% rasas e profundas
figure
subplot(131)  %TEMPERATURA
    plot(ts1,profs,'r',ts2,profs,'b');
    xlabel('\bfTemp');
    ylabel('\bfProfundidade (m)');

         if min(profs) >= -200; %esta�oes rasas
             axis ([20 29 min(profs) 0]);
             set(gca,'xtick',[20:2:29]); grid on;
%          elseif min(profs) < -200 & min(profs) >= -500;
%              axis ([10 29 min(profs) 0]);
%              set(gca,'xtick',[10:4:29]); grid on;
         else
             axis ([0 30 min(profs) 0]);
             set(gca,'xtick',[0:5:25]); grid on;
         end

subplot(132)  %SALINIDADE
    plot(ss1,profs,'r',ss2,profs,'b');
    xlabel('\bfSal');

         if min(profs) >= -200; %esta�oes rasas
             axis ([33 37 min(profs) 0]);
             set(gca,'xtick',[34:37]); grid on;
%          elseif min(profs)s < -200 & min(profs) >= -500;
%              axis ([28 37 min(profs) 0]);
%              set(gca,'xtick',[28:2:37]); grid on;
         else
             axis ([34 37 min(profs) 0]);
             set(gca,'xtick',[34:1:37]); grid on;
%             set(gca,'xtick',[22.5:1.25:27.5]); grid on;
         end
         
subplot(133)  %DENSIDADE
    plot(ds1,profs,'r',ds2,profs,'b');
    xlabel('\bfSigma-t');
    
         if min(profs) >= -200; %esta�oes rasas
             axis ([22 27 min(profs) 0]);
             set(gca,'xtick',[22:2:27]); grid on;
%          elseif min(profs) < -200 & min(profs) >= -500;
%              axis ([16 29 min(profs) 0]);
%              set(gca,'xtick',[16:3:29]); grid on;
         else
             axis ([22 29 min(profs) 0]);
             set(gca,'xtick',[22:3:29]); grid on;
%            set(gca,'xtick',[22.5:1.25:27.5]); grid on;
         end

% Insere titulo central com numero da estacao
    axes('position',[.1 .88 .8 .05],'Box','off','Visible','off');
    txt=['\bfESTA�AO ' names(j,1) names(j,5:6) ' - red(prim) blue(sec)']; title(txt); % MODIFICAR COLUNAS
    handle = get(gca,'title');
    set(handle,'visible','on');
    namest=['esta��o_' names(j,5:6) '_up.png']; % MODIFICAR COLUNAS
    print ('-dpng',namest);
end
