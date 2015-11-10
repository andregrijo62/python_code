% ROTINA PARA CRIAR ARQUIVO CONTENDO DADOS DA MESMA PROFUNDIDADE PARA PLOTAGEM DAS
% SE��ES HORIZONTAIS.
% Elaborado por Carina Novak

% Criar um arquivo com o nome 'esta�oes.txt',
% contendo o nome dos arquivos de CTD (.cnv) das esta��es que ser�o plotadas.
% Cada nome deve estar em uma linha, e todos os nomes devem ter o mesmo
% n�mero de letras.
% Ex.: dCEII001.cnv
%      uCEII002.cnv
%      uCEII003.cnv
% MODIFICAR A LINHA 46 DA ROTINA COM O N�MERO DE LETRAS DO NOME DO ARQUIVO
% DE CTD (CONTANDO O PONTO E A EXTENS�O).

% Criar um arquivo com o nome 'coordenadas.txt', contendo a posi�ao das
% esta�oes, em ordem sequencial conforme o arquivo esta�oes.txt.
% O arquivo deve obrigatoriamente, conter 6 colunas com as informa��es na 
% seguinte ordem (RETIRAR DA PLANILHA DIGITAL):
% - n� esta��o  
% - graus de latitude 
% - minutos de latitude
% - graus de longitude 
% - minutos de longitude
% - profundidade local (m)
%
% Ex: 1  -02  00  53  20     56 (SUL-LESTE)
%     2  -01  10  52  29    271 (SUL-LESTE)
%     3   00  02  51  35    953 (NORTE-LESTE)
%     4   01  20  50  56   1845 (NORTE-LESTE)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       IMPORTANTE: NAS LATITUDES SUL E LONGITUDES OESTE       %
    %            DEVE-SE ACRESCENTAR O SINAL NEGATIVO              %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%   IMPORTANT�SSIMO: TODOS OS ARQUIVOS DEVEM ESTAR DENTRO DA   %%%
  %%%      MESMA PASTA, OU SEJA, A ROTINA, OS ARQUIVOS DE CTD E    %%%
  %%%                       OS ARQUIVOS .txt                       %%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear all, close all,

letras= 10; %MODIFICAR

prof_hor=input('Qual a profundidade voce quer plotar em uma se��o horizontal?');

fid1=fopen('esta�oes.txt', 'r');
name=fscanf(fid1,'%s',[letras inf]);
name=name';
nest=length(name);
matriz_dados=zeros(nest,1);
ncoord='coordenadas.txt';
posi=load(ncoord);

mat=['sechor_' num2str(prof_hor) '.dat'];
fid2 = fopen(mat,'w');

k=0;
for j=1:nest;
esta=name(j,1:letras);    
dados=readflat(esta,1);

profi=dados(1,10); %%% MODIFICAR N� DA COLUNA ONDE EST� A PROFUNDIDADE 
proff=dados(end,10); %%% MODIFICAR N� DA COLUNA ONDE EST� A PROFUNDIDADE
% % % profarq=abs(proff-profi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Condi��o para localizar a linha onde o valor da profundidade a ser plotada
%% est�. A localiza��o � dependente do valor inicial da profundidade de aquisi��o
%% e se o perfil � de descida ou subida.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if length(dados) >= prof_hor
        if profi < proff
            if profi <= prof_hor
            linha=(prof_hor-profi+1);
            else 
            linha=1;
            end
        else
            if proff <= prof_hor
            linha=length(dados)-(prof_hor-proff);
            else 
            linha=length(dados);
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localiza��o das colunas contendo os par�metros temperatura potencial, salinidade,
%% densidade e oxigenio no arquivo de CTD. Modificar colunas e comentar as linhas
%% contendo dados desnecess�rios.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    temp=dados(linha,11);  %%% MODIFICAR
    sali=dados(linha,13);  %%% MODIFICAR
    sigt=dados(linha,17);  %%% MODIFICAR
    oxig=dados(linha,19);  %%% MODIFICAR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cria��o das matrizes contendo os valores dos parametros. Comentar as linhas
%% contendo os dados desnecess�rios.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    matriz_T(k+1,1)=matriz_dados(j,1)+temp;
    matriz_S(k+1,1)=matriz_dados(j,1)+sali;
    matriz_Sig(k+1,1)=matriz_dados(j,1)+sigt;
    matriz_Oxi(k+1,1)=matriz_dados(j,1)+oxig;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localiza��o das colunas contendo os par�metros latitude e longitude do arquivo
%% "coordenadas.txt". Modificar colunas caso necess�rio.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latg(j)=posi(j,2); latm(j)=posi(j,3);
    long(j)=posi(j,4); lonm(j)=posi(j,5);
%% Condi��o para o c�lculo das latitude e longitudes em decimais utilizando os 
%% valores de latitude NORTE e longitude LESTE (positivo) ou latitude SUL e 
%% longitude OESTE (negativo)
        if latg(j) > 0 | long(j) > 0
        lat(j)=(latg(j)+latm(j)/60);
        lon(j)=(long(j)+lonm(j)/60);
        else 
        lat(j)=(-latg(j)+latm(j)/60)*-1;
        lon(j)=(-long(j)+lonm(j)/60)*-1;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cria��o das matrizes contendo os valores de latitude e longitudes
%% decimais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    matriz_lat(k+1,1)=matriz_dados(j,1)+lat(j);
    matriz_lon(k+1,1)=matriz_dados(j,1)+lon(j);
    k=k+1;
    else
    disp(['arquivo ' esta ' n�o tem essa profundidade - aperte ENTER para continuar'])
    pause
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cria��o de uma matriz contendo todos os parametros obtidos. Observar
%% sequencia caso haja algum par�metro que n�o foi criado. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mat_sechor=[matriz_lat matriz_lon matriz_T matriz_S matriz_Sig matriz_Oxi ];
% mat_sechor=[matriz_lat matriz_lon matriz_T matriz_S matriz_Sig];

fprintf(fid2,'%9.5    %9.5    %7.3f    %7.3f    %7.4f   %8.6f\n',mat_sechor');
fclose(fid1); fclose(fid2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LIMPEZA DO WORKSPACE DAS VARI�VEIS CRIADAS QUE N�O SER�O MAIS UTILIZADAS 
% clear matriz_T matriz_S matriz_Sig matriz_Oxi matriz_lat matriz_lon
% clear lat lon temp salin sigt oxig latg latm long lonm prof



