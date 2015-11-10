% ROTINA PARA CORRELACIONAR DADOS DE CONDUTIVIDADE/SALINIDADE ENTRE SENSORES DISTINTOS
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
% de condutividade/salinidade do CTD da mesma profundidade onde foram cole-
% tadas as informações de TSG (saber de que profundidade o equipamento está
% coletando água - geralmente é o calado do navio). Os dados de TSG devem 
% ter o mesmo data-hora da coleta de CTD. Para tanto, utilizar o dia-juliano
%  como referencia.


%% COMPARAÇÃO ENTRE DADOS DO CTD E SALINOMETRO
% Criar um arquivo nomeado como 'ctdxpts.txt' (linha 56), contendo os dados
% de CTD da mesma profundidade onde foram coletadas as amostras de água.
% Para tanto, utilizar o arquivo .btl (sumário das garrafas).

clc; clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             ABERTURA DOS ARQUIVOS QUE CONTÉM OS DADOS                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %% DADOS PARA COMPARAÇÃO DOS SENSORES DO CTD (.CNV)

% letras= 10; %MODIFICAR
% nest=input('Entre com o numero de arquivos que deseja juntar: ');
% fid=fopen('ctd1ctd2.txt','r');
% name=fscanf(fid,'%s',[letras nest]);
% name=name';
% final=[];
% dados=[];
% for j=1:nest;
% esta=name(j,1:letras);    
% dados=readflat(esta,0);
% final=[final;dados];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %% DADOS TABELADOS PARA COMPARAÇÃO DOS SENSORES DO CTD COM O TSG E SALI-
%      NOMETRO(.TXT)

% dados='ctdxtsg.txt';
dados='ctdxpts.txt';
final=load(dados);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          DEFINIÇÃO DO INTERVALO DE VALORES DOS EIXOS X E Y            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf
x1=axes;
% Deve-se verificar o intervalo de valores em que os dados se encontram pa-
% ra ajustar XLim e YLim
set(x1,'YLim',[2 6]);  % MODIFICAR
set(x1,'XLim',[2 6]);  % MODIFICAR
% set(x1,'YLim',[34 37]);  % MODIFICAR
% set(x1,'XLim',[34 37]);  % MODIFICAR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  TÍTULO DA FIGURA E NOME NOS EIXOS X E Y              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %%% TÍTULO
% t=title(['Comparação de valores de condutividade - CTD1 X CTD2']);
 t=title(['Comparação de valores de condutividade - CTD1 X TSG']);
% t=title(['Comparação de valores de condutividade - CTD2 X TSG']);

% t=title(['Comparação de valores de salinidade - CTD X Salinometro']); 
% t=title(['Comparação de valores de salinidade - CTD1 X Salinometro']);
% t=title(['Comparação de valores de salinidade - CTD2 X Salinometro']);
% t=title(['Comparação de valores de salinidade - CTD X TSG']);
% t=title(['Comparação de valores de salinidade - CTD1 X TSG']);
% t=title(['Comparação de valores de salinidade - CTD2 X TSG']);

%   %%% EIXO X 
% x=xlabel('Condutividade - CTD ');  % CASO DE UM SENSOR
x=xlabel('Condutividade - CTD1 ');
% x=xlabel('Condutividade - CTD2');

% x=xlabel('Salinidade - CTD ');  % CASO DE UM SENSOR
% x=xlabel('Salinidade - CTD1 ');
% x=xlabel('Salinidade - CTD2 ');

%   %%% EIXO Y 
% y=ylabel('Condutividade - CTD');  % CASO DE UM SENSOR
% y=ylabel('Condutividade - CTD2');
 y=ylabel('Condutividade - TSG');

% y=ylabel('Salinidade - CTD2');
% y=ylabel('Salinidade - Salinometro ');
%  y=ylabel('Salinidade - TSG ');

%--------------------------------------------------------------------------
set(t,'FontWeight','Bold');
set(y,'FontWeight','Bold'); set(x,'FontWeight','Bold');
grid on; hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   VETOR GUIA PARA PLOTAGEM DAS RETAS DE REGRESSÃO (ACORDO PERFEITO -   %
%%        preta tracejada E LIMITES ACEITÁVEIS - linhas verdes           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deve-se ajustar o intervalo de valores em que os dados se encontram 

tt=2:6;  % MODIFICAR (condutividade)
% tt=30:35;  % MODIFICAR (salinidade)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   VALOR DO INTERVALO MÁXIMO ACEITAVEL COMO DADO BOM                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kk1=input('Tempo decorrido da ultima calibração do sensor 1º(em MESES)- eixo x :');
kk2=input('Tempo decorrido da ultima calibração do sensor 2º(em MESES)- eixo y :');
kk=(kk1*0.0003)+ (kk2*0.0003);

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
% salctd00=final(:,7);   % MODIFICAR COLUNA
% salctd11=final(:,8);   % MODIFICAR COLUNA
% dif=salctd00-salctd11;
% k=find(abs(dif)<=kk);   
% p1=plot(salctd00,salctd11,'r*'); %plotando todos os dados
% p2=plot(salctd00(k),salctd11(k),'b*'); %plotando os dados sem spikes 
% pp1=plot(tt,tt+kk,'g-');   
% pp2=plot(tt,tt-kk,'g-');   
% p3=plot(tt,tt,'k--'); % perfect agreement
% [P,S] = polyfit(salctd00,salctd11,1); % coeficientes da função de regressão de todos os dados
% [PP,SS] = polyfit(salctd00(k),salctd11(k),1); % coeficientes da função de regressão dos dados sem spikes
% p4=plot(tt,tt*P(1)+P(2),'r');% reta da função de regressão de todos os dados 
% p5=plot(tt,tt*PP(1)+PP(2),'b'); % reta da função de regressão dos dados sem spikes 
% c=min(corrcoef(salctd00,salctd11)); % coeficiente de correlação de todos os dados
% cc=min(corrcoef(salctd00(k),salctd11(k))); % coeficiente de correlação dos dados sem spikes
%%-------------------------------------------------------------------------
%%      Todos os dados (CTD2-CTD1) 
%%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%%   e 2 (valor de Y) da função text)
% t1=text(2.1,5.8,['Coeficiente de correlação: ' num2str(c(1),4)]); 
% set(t1,'Color',[1 0 0],'FontWeight','Bold');
%     if P(2)>=0
%        t2=text(2.1,5.65, ['Função de Regressão: ' num2str(P(1),4) ' * t + ' num2str(P(2),4)]);
%     else
%        t2=text(2.1,5.65, ['Função de Regressão: ' num2str(P(1),4) ' * t - ' num2str(abs(P(2)),4)]);
%     end
% set(t2,'Color',[1 0 0],'FontWeight','Bold');
% % Dados sem spikes (CTD2-CTD1)
% t3=text(2.1,5.5,['Coeficiente de correlação: ' num2str(cc(1),4)]);
% set(t3,'Color',[0 0 1],'FontWeight','Bold');
%     if PP(2)>=0
%        t4=text(2.1,5.35, ['Função de Regressão: ' num2str(PP(1),4) ' * t + ' num2str(PP(2),4)]);
%     else
%        t4=text(2.1,5.35, ['Função de Regressão: ' num2str(PP(1),4) ' * t - ' num2str(abs(PP(2)),4)]);
%     end
% set(t4,'Color',[0 0 1],'FontWeight','Bold');
% %--------------------------------------------------------------------------
% todos=size(dif,1); bons=size(k,1); 
% porcentagem=(bons/todos)*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          COMPARAÇÃO ENTRE CTD E TSG (arquivo tabelado .txt)           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-------------------------------------------------------------------------
%%% SENSOR PRIMÁRIO
salctd00=final(:,1);   % MODIFICAR COLUNA
saltsg=final(:,2);      % MODIFICAR COLUNA
dif0t=salctd00-saltsg; 
i=find(abs(dif0t)<=kk);    
p1t=plot(salctd00,saltsg,'r*'); %plotando todos os dados (sensor primário)
p2t=plot(salctd00(i),saltsg(i),'b*'); %plotando os dados sem spikes
pp1t=plot(tt,tt+kk,'g-');   
pp2t=plot(tt,tt-kk,'g-');   
p3=plot(tt,tt,':'); % perfect agreement
[P00t,S00t] = polyfit(salctd00,saltsg,1); % coeficientes da função de regressão de todos os dados
[PP00t,SS00t] = polyfit(salctd00(i),saltsg(i),1); % coeficientes da função de regressão dos dados sem spikes
p4=plot(tt,tt*P00t(1)+P00t(2),'r');% reta da função de regressão de todos os dados
p5=plot(tt,tt*PP00t(1)+PP00t(2),'b'); % reta da função de regressão dos dados sem spikes
c00t=min(corrcoef(salctd00,saltsg)); % coeficiente de correlação de todos os dados
cc00t=min(corrcoef(salctd00(i),saltsg(i))); % coeficiente de correlação dos dados sem spikes
%-------------------------------------------------------------------------
%      Todos os dados (CTD1-TSG) 
%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%  e 2 (valor de Y) da função text)
t1=text(2.1,5.9,['Coeficiente de correlação: ' num2str(c00t(1),4)]); 
% t1=text(34.1,37.3,['Coeficiente de correlação: ' num2str(c00t(1),4)]); 
set(t1,'Color',[1 0 0],'FontWeight','Bold');
    if P00t(2)>=0
        t2=text(2.1,5.7, ['Função de Regressão: ' num2str(P00t(1),4) ' * t + ' num2str(P00t(2),4)]);
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P00t(1),4) ' * t + ' num2str(P00t(2),4)]);
    else
        t2=text(2.1,5.7, ['Função de Regressão: ' num2str(P00t(1),4) ' * t - ' num2str(abs(P00t(2)),4)]);
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P00t(1),4) ' * t - ' num2str(abs(P00t(2)),4)]);
    end
set(t2,'Color',[1 0 0],'FontWeight','Bold');
%  Dados sem spikes (CTD00-TSG)
t3=text(2.1,5.5,['Coeficiente de correlação: ' num2str(cc00t(1),4)]);
% t3=text(34.1,36.8,['Coeficiente de correlação: ' num2str(cc00t(1),4)]);
set(t3,'Color',[0 0 1],'FontWeight','Bold');
    if PP00t(2)>=0
       t4=text(2.1,5.3, ['Função de Regressão: ' num2str(PP00t(1),4) ' * t + ' num2str(PP00t(2),4)]);
%        t4=text(34.1,36.6, ['Função de Regressão: ' num2str(PP00t(1),4) ' * t + ' num2str(PP00t(2),4)]);
    else
       t4=text(2.1,5.3, ['Função de Regressão: ' num2str(PP00t(1),4) ' * t - ' num2str(abs(PP00t(2)),4)]);
%       t4=text(34.1,36.6, ['Função de Regressão: ' num2str(PP00t(1),4) ' * t - ' num2str(abs(PP00t(2)),4)]);
    end
set(t4,'Color',[0 0 1],'FontWeight','Bold');
%calculo da porcentagem de dados validos
todos0=size(dif0t,1); bons0=size(i,1);
porcentagem=(bons0/todos0)*100;
% 
%%-------------------------------------------------------------------------
%%% SENSOR SECUNDÁRIO
% salctd11=final(:,2);   % MODIFICAR COLUNA
% saltsg=final(:,3);      % MODIFICAR COLUNA
% dif1t=salctd11-saltsg;  
% j=find(abs(dif1t)<=kk);    
% p11t=plot(salctd11,saltsg,'r*'); %plotando todos os dados (sensor secundário)
% p22t=plot(salctd11(j),saltsg(j),'b*'); %plotando os dados sem spikes
% pp1t=plot(tt,tt+kk,'g-');  
% pp2t=plot(tt,tt-kk,'g-');  
% p3=plot(tt,tt,':'); % perfect agreement
% [P11t,S11t] = polyfit(salctd11,saltsg,1); % coeficientes da função de regressão de todos os dados
% [PP11t,SS11t] = polyfit(salctd11(j),saltsg(j),1); % coeficientes da função de regressão dos dados sem spikes
% p4=plot(tt,tt*P11t(1)+P11t(2),'r');% reta da função de regressão de todos os dados  
% p5=plot(tt,tt*PP11t(1)+PP11t(2),'b'); % reta da função de regressão dos dados sem spikes
% c11t=min(corrcoef(salctd11,saltsg)); % coeficiente de correlação de todos os dados 
% cc11t=min(corrcoef(salctd11(j),saltsg(j))); % coeficiente de correlação dos dados sem spikes
%%-------------------------------------------------------------------------
%%      Todos os dados (CTD1-TSG) 
%%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%%  e 2 (valor de Y) da função text)
% % t1=text(2.1,5.9,['Coeficiente de correlação: ' num2str(c11t(1),4)]); 
% t1=text(34.1,37.3,['Coeficiente de correlação: ' num2str(c11t(1),4)]); 
% set(t1,'Color',[1 0 0],'FontWeight','Bold');
%     if P11t(2)>=0
%%        t2=text(2.1,5.7, ['Função de Regressão: ' num2str(P11t(1),4) ' * t + ' num2str(P11t(2),4)]);
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P11t(1),4) ' * t + ' num2str(P11t(2),4)]);
%     else
%%        t2=text(2.1,5.7, ['Função de Regressão: ' num2str(P11t(1),4) ' * t - ' num2str(abs(P11t(2)),4)]);
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P11t(1),4) ' * t - ' num2str(abs(P11t(2)),4)]);
%     end
% set(t2,'Color',[1 0 0],'FontWeight','Bold');
% %  Dados sem spikes (CTD11-TSG)
%% t3=text(2.1,5.5,['Coeficiente de correlação: ' num2str(cc11t(1),4)]); 
% t3=text(34.1,37.3,['Coeficiente de correlação: ' num2str(cc11t(1),4)]); 
% set(t3,'Color',[1 0 0],'FontWeight','Bold');
%     if P11t(2)>=0
%%        t4=text(2.1,5.3, ['Função de Regressão: ' num2str(PP11t(1),4) ' * t + ' num2str(PP11t(2),4)]);
%        t4=text(34.1,37.1, ['Função de Regressão: ' num2str(PP11t(1),4) ' * t + ' num2str(PP11t(2),4)]);
%     else
%%        t4=text(2.1,5.3, ['Função de Regressão: ' num2str(PP11t(1),4) ' * t - ' num2str(abs(PP11t(2)),4)]);
%        t4=text(34.1,37.1, ['Função de Regressão: ' num2str(PP11t(1),4) ' * t - ' num2str(abs(PP11t(2)),4)]);
%     end
% set(t4,'Color',[1 0 0],'FontWeight','Bold');
% %calculo da porcentagem de dados validos
% todos1=size(dif1t,1); bons1=size(j,1); 
% porcentagem=(bons1/todos1)*100;
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       COMPARAÇÃO ENTRE CTD E SALINOMETRO (arquivo tabelado .txt)      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%-------------------------------------------------------------------------
% %%%     SENSOR PRIMÁRIO
% salctd00=final(:,1);   % MODIFICAR COLUNA
% salpts=final(:,2);     % MODIFICAR COLUNA
% dif0p=salctd00-salpts;  
% i=find(abs(dif0p)<=kk);   
% p1p=plot(salctd00,salpts,'r*'); %plotando todos os dados (sensor primário)
% p2p=plot(salctd00(i),salpts(i),'b*'); %plotando os dados sem spikes
% p3=plot(tt,tt,':'); % perfect agreement
% pp1p=plot(tt,tt+kk,'g-');   
% pp2p=plot(tt,tt-kk,'g-');   
% [P00p,S00p] = polyfit(salctd00,salpts,1); % coeficientes da função de regressão de todos os dados
% [PP00p,SS00p] = polyfit(salctd00(i),salpts(i),1); % coeficientes da função de regressão dos dados sem spikes
% p4=plot(tt,tt*P00p(1)+P00p(2),'r');% reta da função de regressão de todos os dados  
% p5=plot(tt,tt*PP00p(1)+PP00p(2),'b'); % reta da função de regressão dos dados sem spikes  
% c00p=min(corrcoef(salctd00,salpts)); % coeficiente de correlação de todos os dados
% cc00p=min(corrcoef(salctd00(i),salpts(i))); % coeficiente de correlação dos dados sem spikes
% %%-------------------------------------------------------------------------
% %%      Todos os dados (CTD1-SALINOMETRO) 
% %%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
% %%  e 2 (valor de Y) da função text)
% t1=text(34.1,37.3,['Coeficiente de correlação: ' num2str(c00p(1),4)]); 
% set(t1,'Color',[1 0 0],'FontWeight','Bold');
%     if P00p(2)>=0
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P00p(1),4) ' * t + ' num2str(P00p(2),4)]);
%     else
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P00p(1),4) ' * t - ' num2str(abs(P00p(2)),4)]);
%     end
% set(t2,'Color',[1 0 0],'FontWeight','Bold');
% %  Dados sem spikes (CTD1-SALINOMETRO)
% t3=text(34.1,36.8,['Coeficiente de correlação: ' num2str(cc00p(1),4)]);
% set(t3,'Color',[0 0 1],'FontWeight','Bold');
%     if PP00p(2)>=0
%        t4=text(34.1,36.6, ['Função de Regressão: ' num2str(PP00p(1),4) ' * t + ' num2str(PP00p(2),4)]);
%     else
%        t4=text(34.1,36.6, ['Função de Regressão: ' num2str(PP00p(1),4) ' * t - ' num2str(abs(PP00p(2)),4)]);
%     end
% set(t4,'Color',[0 0 1],'FontWeight','Bold');
% %calculo da porcentagem de dados validos
% todos0=size(dif0p,1); bons0=size(i,1);
% porcentagem=(bons0/todos0)*100;

%%-------------------------------------------------------------------------
%%%     SENSOR SECUNDÁRIO
% salctd11=final(:,2);   % MODIFICAR COLUNA
% salpts=final(:,3);     % MODIFICAR COLUNA
% dif1p=salctd11-salpts; 
% j=find(abs(dif1p)<=kk);     
% p11p=plot(salctd11,salpts,'r*'); %plotando todos os dados (sensor secundário)
% p22p=plot(salctd11(j),salpts(j),'b*'); %plotando os dados sem spikes
% p3=plot(tt,tt,':'); % perfect agreement
% l1=legend('Todos os dados','Sem spikes',4);
% set(l1,'position',[0.6   0.17   0.23   0.10]);
% pp1p=plot(tt,tt+kk,'g-');   
% pp2p=plot(tt,tt-kk,'g-');   
% [P11p,S11p] = polyfit(salctd11,salpts,1); % coeficientes da função de regressão de todos os dados
% [PP11p,SS11p] = polyfit(salctd11(j),salpts(j),1); % coeficientes da função de regressão dos dados sem spikes
% p4=plot(tt,tt*P11p(1)+P11p(2),'r');% reta da função de regressão de todos os dados  
% p5=plot(tt,tt*PP11p(1)+PP11p(2),'b'); % reta da função de regressão dos dados sem spikes  
% c11p=min(corrcoef(salctd11,salpts)); % coeficiente de correlação de todos os dados 
% cc11p=min(corrcoef(salctd11(j),salpts(j))); % coeficiente de correlação dos dados sem spikes
%--------------------------------------------------------------------------
%%      Todos os dados (CTD1-SALINOMETRO) 
%%      Ajustar localização do texto no gráfico (parametros 1 (valor de X)
%%  e 2 (valor de Y) da função text)
% t1=text(34.1,37.3,['Coeficiente de correlação: ' num2str(c11p(1),4)]); 
% set(t1,'Color',[1 0 0],'FontWeight','Bold');
%     if P11p(2)>=0
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P11p(1),4) ' * t + ' num2str(P11p(2),4)]);
%     else
%        t2=text(34.1,37.1, ['Função de Regressão: ' num2str(P11p(1),4) ' * t - ' num2str(abs(P11p(2)),4)]);
%     end
% set(t2,'Color',[1 0 0],'FontWeight','Bold');
% %     Dados sem spikes (CTD2-SALINOMETRO)
% t3=text(34.1,37.3,['Coeficiente de correlação: ' num2str(cc11p(1),4)]); 
% set(t3,'Color',[1 0 0],'FontWeight','Bold');
%     if P11p(2)>=0
%        t4=text(34.1,37.1, ['Função de Regressão: ' num2str(PP11p(1),4) ' * t + ' num2str(PP11p(2),4)]);
%     else
%        t4=text(34.1,37.1, ['Função de Regressão: ' num2str(PP11p(1),4) ' * t - ' num2str(abs(PP11p(2)),4)]);
%     end
% set(t4,'Color',[1 0 0],'FontWeight','Bold');
% 
% %calculo da porcentagem de dados validos
% todos1=size(dif1p,1); bons1=size(j,1);
% porcentagem=(bons1/todos1)*100;
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                             LEGENDA                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l1=legend('Todos os dados','Sem spikes',4);
set(l1,'position',[0.6   0.17   0.23   0.10]);

%% Ajustar localização do texto no gráfico (parametros 1 (valor de X) e 2 
%% (valor de Y) da função text
t5=text(2.1,5.1, ['Porcentagem de Dados Válidos:  ' num2str(porcentagem,4) ' %' ]); 
% t5=text(34.1,36.9, ['Porcentagem de Dados Válidos:  ' num2str(porcentagem,4) ' %' ]); 

set(t5,'Color',[0 0 1],'FontWeight','Bold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                       GRAVAÇÃO DAS FIGURAS                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fname2=(['CTD1 X CTD2' ]);
% fname2=(['CTD1 X TSG' ]);
% fname2=(['CTD2 X TSG' ]);
fname2=(['CTD1 X SALINOMETRO' ]);
% fname2=(['CTD2 X SALINOMETRO' ]);

% fname2=input('Gravar Figura da Estaçao: ','s');
print('-djpeg', fname2)
