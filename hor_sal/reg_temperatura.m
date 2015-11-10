% ROTINA PARA CORRELACIONAR DADOS DE TEMPERATURA ENTRE SENSORES DISTINTOS
% Elaborado por 1T(RM2-T) Carina Novak Laprea

%% COMPARAÇÃO ENTRE SENSORES EM DUPLICIDADE DO CTD
% Criar um arquivo nomeado como 'ctd1ctd2.txt' (linha 40),
% contendo o nome dos arquivos .cnv (CTD), em sequencia, das estações que 
% que ser plotadas.
% Cada nome deve estar em uma linha, e todos os nomes devem ter o mesmo
% número de letras.
% Ex.: dCEII001.cnv
%      uCEII002.cnv
%      uCEII003.cnv
% MODIFICAR A LINHA 38 DA ROTINA COM O NÚMERO DE LETRAS DO NOME DO ARQUIVO
% DE CTD (CONTANDO O PONTO E A EXTENSÃO).


%% COMPARAÇÃO ENTRE DADOS DO CTD E TERMOSAL
% Criar um arquivo nomeado como 'ctdxtsg.txt' (linha 55), contendo os dados
% de temperatura do CTD da mesma profundidade onde foram coletadas as in-
% formações de TSG (saber de que profundidade o equipamento está coletando 
% água - geralmente é o calado do navio). Os dados de TSG devem ter o mesmo
% data-hora da coleta de CTD. Para tanto, utilizar o dia-juliano como refe-
% rencia.


clc; clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             ABERTURA DOS ARQUIVOS QUE CONTÉM OS DADOS                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %% DADOS PARA COMPARAÇÃO DOS SENSORES DO CTD (ARQUIVOS DE CTD *.CNV)

letras= 10; %MODIFICAR
nest=input('Entre com o numero de arquivos de CTD: ');
fid=fopen('ctd1ctd2.txt','r');
name=fscanf(fid,'%s',[letras inf]);
name=name';
final=[];
dados=[];
for j=1:nest;
esta=name(j,1:letras);    
dados=readflat(esta,0);
final=[final;dados];
end
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %% DADOS TABELADOS PARA COMPARAÇÃO DOS SENSORES DO CTD COM O TSG 
%%  (TABELA CONFECCIONADA EM *.TXT)

% dados='ctdxtsg.txt';
% final=load(dados);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          DEFINIÇÃO DO INTERVALO DE VALORES DOS EIXOS X E Y            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf
x1=axes;
% Deve-se verificar o intervalo de valores em que os dados se encontram pa-
% ra ajustar XLim e YLim
set(x1,'YLim',[0 30]);  % MODIFICAR
set(x1,'XLim',[0 30]);  % MODIFICAR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  TÍTULO DA FIGURA E NOME NOS EIXOS X E Y              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %%% TÍTULO
% t=title(['Comparação de valores de temperatura - CTD1 X CTD2']);
 t=title(['Comparação de valores de temperatura - CTD X TSG']);
% t=title(['Comparação de valores de temperatura - CTD1 X TSG']);
% t=title(['Comparação de valores de temperatura - CTD2 X TSG']);

%   %%% EIXO X 
% x=xlabel('Temperatura - CTD ');  % CASO DE UM SENSOR
x=xlabel('Temperatura - CTD1 ');
% x=xlabel('Temperatura - CTD2');

%   %%% EIXO Y 
% y=ylabel('Temperatura - CTD');  % CASO DE UM SENSOR
% y=ylabel('Temperatura - CTD2');
y=ylabel('Temperatura - TSG ');

%--------------------------------------------------------------------------
set(t,'FontWeight','Bold');
set(y,'FontWeight','Bold'); set(x,'FontWeight','Bold');
grid on; hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   VETOR GUIA PARA PLOTAGEM DAS RETAS DE REGRESSÃO (ACORDO PERFEITO - 
%%        preta tracejada E LIMITES ACEITÁVEIS - linhas verdes           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deve-se ajustar o intervalo de valores em que os dados se encontram 

tt=0:30;  % MODIFICAR (temperatura)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   VALOR DO INTERVALO MÁXIMO ACEITAVEL COMO DADO BOM                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kk1=input('Tempo decorrido da ultima calibração do sensor 1º(em MESES)- eixo x :');
kk2=input('Tempo decorrido da ultima calibração do sensor 2º(em MESES)- eixo y :');
kk=(kk1*0.0002)+ (kk2*0.0002);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     A PARTIR DAQUI COMENTAR DE ACORDO COM O QUE QUER PLOTAR         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          COMPARAÇÃO ENTRE CTD1 E CTD2 (arquivos .cnv do CTD)          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temctd00=final(:,11);   % MODIFICAR COLUNA
temctd11=final(:,12);   % MODIFICAR COLUNA
dif=temctd00-temctd11;
k=find(abs(dif)<=kk);  
p1=plot(temctd00,temctd11,'r*'); %plotando todos os dados
p2=plot(temctd00(k),temctd11(k),'b*'); %plotando os dados sem spikes 
pp1=plot(tt,tt+kk,'g-'); 
pp2=plot(tt,tt-kk,'g-');  
p3=plot(tt,tt,'k--'); % perfect agreement
[P,S] = polyfit(temctd00,temctd11,1); % coeficientes da função de regressão de todos os dados
[PP,SS] = polyfit(temctd00(k),temctd11(k),1); % coeficientes da função de regressão dos dados sem spikes
p4=plot(tt,tt*P(1)+P(2),'r');% reta da função de regressão de todos os dados 
p5=plot(tt,tt*PP(1)+PP(2),'b'); % reta da função de regressão dos dados sem spikes 
c=min(corrcoef(temctd00,temctd11)); % coeficiente de correlação de todos os dados
cc=min(corrcoef(temctd00(k),temctd11(k))); % coeficiente de correlação dos dados sem spikes
%-------------------------------------------------------------------------
%      Todos os dados (CTD2-CTD1) 
%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%   e 2 (valor de Y) da função text)
t1=text(1.5,28.5,['Coeficiente de correlação: ' num2str(c(1),4)]); 
set(t1,'Color',[1 0 0],'FontWeight','Bold');
    if P(2)>=0
       t2=text(1.5,27, ['Função de Regressão: ' num2str(P(1),4) ' * t + ' num2str(P(2),4)]);
    else
       t2=text(1.5,27, ['Função de Regressão: ' num2str(P(1),4) ' * t - ' num2str(abs(P(2)),4)]);
    end
set(t2,'Color',[1 0 0],'FontWeight','Bold');
% Dados sem spikes (CTD2-CTD1)
t3=text(1.5,25.5,['Coeficiente de correlação: ' num2str(cc(1),4)]);
set(t3,'Color',[0 0 1],'FontWeight','Bold');
    if PP(2)>=0
       t4=text(1.5,24, ['Função de Regressão: ' num2str(PP(1),4) ' * t + ' num2str(PP(2),4)]);
    else
       t4=text(1.5,24, ['Função de Regressão: ' num2str(PP(1),4) ' * t - ' num2str(abs(PP(2)),4)]);
    end
set(t4,'Color',[0 0 1],'FontWeight','Bold');
%--------------------------------------------------------------------------
todos=size(dif,1); bons=size(k,1); 
porcentagem=(bons/todos)*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          COMPARAÇÃO ENTRE CTD E TSG (arquivo tabelado .txt)           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-------------------------------------------------------------------------
%%% SENSOR PRIMÁRIO
% temctd00=final(:,1);   % MODIFICAR COLUNA
% temtsg=final(:,2);      % MODIFICAR COLUNA
% dif0t=temctd00-temtsg; 
% i=find(abs(dif0t)<=kk);   
% p1t=plot(temctd00,temtsg,'r*'); %plotando todos os dados (sensor primário)
% p2t=plot(temctd00(i),temtsg(i),'b*'); %plotando os dados sem spikes
% pp1t=plot(tt,tt+kk,'g-');   
% pp2t=plot(tt,tt-kk,'g-');  
% p3=plot(tt,tt,':'); % perfect agreement
% [P00t,S00t] = polyfit(temctd00,temtsg,1); % coeficientes da função de regressão de todos os dados
% [PP00t,SS00t] = polyfit(temctd00(i),temtsg(i),1); % coeficientes da função de regressão dos dados sem spikes
% p4=plot(tt,tt*P00t(1)+P00t(2),'r');% reta da função de regressão de todos os dados
% p5=plot(tt,tt*PP00t(1)+PP00t(2),'b'); % reta da função de regressão dos dados sem spikes
% c00t=min(corrcoef(temctd00,temtsg)); % coeficiente de correlação de todos os dados
% cc00t=min(corrcoef(temctd00(i),temtsg(i))); % coeficiente de correlação dos dados sem spikes
%%-------------------------------------------------------------------------
%%      Todos os dados (CTD1-TSG) 
%%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%%  e 2 (valor de Y) da função text)
% t1=text(1.5,28.5,['Coeficiente de correlação: ' num2str(c00t(1),4)]); 
% set(t1,'Color',[1 0 0],'FontWeight','Bold');
%     if P00t(2)>=0
%        t2=text(1.5,27, ['Função de Regressão: ' num2str(P00t(1),4) ' * t + ' num2str(P00t(2),4)]);
%     else
%        t2=text(1.5,27, ['Função de Regressão: ' num2str(P00t(1),4) ' * t - ' num2str(abs(P00t(2)),4)]);
%     end
% set(t2,'Color',[1 0 0],'FontWeight','Bold');
% %  Dados sem spikes (CTD1-TSG)
% t3=text(1.5,25.5,['Coeficiente de correlação: ' num2str(cc00t(1),4)]);
% set(t3,'Color',[0 0 1],'FontWeight','Bold');
%     if PP00t(2)>=0
%        t4=text(1.5,24, ['Função de Regressão: ' num2str(PP00t(1),4) ' * t + ' num2str(PP00t(2),4)]);
%     else
%        t4=text(1.5,24, ['Função de Regressão: ' num2str(PP00t(1),4) ' * t - ' num2str(abs(PP00t(2)),4)]);
%     end
% set(t4,'Color',[0 0 1],'FontWeight','Bold');
% %calculo da porcentagem de dados validos
% todos0=size(dif0t,1); bons0=size(i,1);
% porcentagem=(bons0/todos0)*100;
% 
%%-------------------------------------------------------------------------
%%% SENSOR SECUNDÁRIO
% temctd11=final(:,2);   % MODIFICAR COLUNA
% temtsg=final(:,3);      % MODIFICAR COLUNA
% dif1t=temctd11-temtsg;  
% j=find(abs(dif1t)<=kk);   
% p11t=plot(temctd11,temtsg,'r*'); %plotando todos os dados (sensor secundário)
% p22t=plot(temctd11(j),temtsg(j),'b*'); %plotando os dados sem spikes
% pp1t=plot(tt,tt+kk,'g-');  
% pp2t=plot(tt,tt-kk,'g-'); 
% p3=plot(tt,tt,':'); % perfect agreement
% [P11t,S11t] = polyfit(temctd11,temtsg,1); % coeficientes da função de regressão de todos os dados
% [PP11t,SS11t] = polyfit(temctd11(j),temtsg(j),1); % coeficientes da função de regressão dos dados sem spikes
% p4=plot(tt,tt*P11t(1)+P11t(2),'r');% reta da função de regressão de todos os dados  
% p5=plot(tt,tt*PP11t(1)+PP11t(2),'b'); % reta da função de regressão dos dados sem spikes
% c11t=min(corrcoef(temctd11,temtsg)); % coeficiente de correlação de todos os dados 
% cc11t=min(corrcoef(temctd11(j),temtsg(j))); % coeficiente de correlação dos dados sem spikes
%%-------------------------------------------------------------------------
%%      Todos os dados (CTD1-TSG) 
%%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%%  e 2 (valor de Y) da função text)
% t1=text(1.5,28.5,['Coeficiente de correlação: ' num2str(c11t(1),4)]); 
% set(t1,'Color',[1 0 0],'FontWeight','Bold');
%     if P11t(2)>=0
%        t2=text(1.5,27, ['Função de Regressão: ' num2str(P11t(1),4) ' * t + ' num2str(P11t(2),4)]);
%     else
%        t2=text(1.5,27, ['Função de Regressão: ' num2str(P11t(1),4) ' * t - ' num2str(abs(P11t(2)),4)]);
%     end
% set(t2,'Color',[1 0 0],'FontWeight','Bold');
% %  Dados sem spikes (CTD2-TSG)
% t3=text(1.5,25.5,['Coeficiente de correlação: ' num2str(cc11t(1),4)]); 
% set(t3,'Color',[1 0 0],'FontWeight','Bold');
%     if P11t(2)>=0
%        t4=text(1.5,24, ['Função de Regressão: ' num2str(PP11t(1),4) ' * t + ' num2str(PP11t(2),4)]);
%     else
%        t4=text(1.5,24, ['Função de Regressão: ' num2str(PP11t(1),4) ' * t - ' num2str(abs(PP11t(2)),4)]);
%     end
% set(t4,'Color',[1 0 0],'FontWeight','Bold');
% %calculo da porcentagem de dados validos
% todos1=size(dif1t,1); bons1=size(j,1); 
% porcentagem=(bons1/todos1)*100;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                             LEGENDA                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l1=legend('Todos os dados','Sem spikes',4);
set(l1,'position',[0.6   0.17   0.23   0.10]);

%% Ajustar localização do texto no gráfico (parametros 1 (valor de X) e 2 
%% (valor de Y) da função text
t5=text(1.5,22.5, ['Porcentagem de Dados Válidos:  ' num2str(porcentagem,4) ' %' ]); %%AJUSTAR

set(t5,'Color',[0 0 1],'FontWeight','Bold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                       GRAVAÇÃO DAS FIGURAS                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname2=(['CTD1 X CTD2' ]);
% fname2=(['CTD1 X TSG' ]);
% fname2=(['CTD2 X TSG' ]);

% fname2=input('Gravar Figura da Estaçao: ','s');
print('-djpeg', fname2)
