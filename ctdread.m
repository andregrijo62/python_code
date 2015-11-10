clear all 
close all

for g=10:31
     la=int2str(g);
     filen=['0910070',la,'.cnv'];
     x=textread(filen,'%f','headerlines',88);
 col=7;
 n=length(x);
 row=n/col;
 a=zeros(row,col);
 p=1 ;
 for k=1:row
     for j=1:col
         a(k,j)=x(p);
         p=p+1;
     end
 end
 %------------------------------------------------------------------------
ii=find(a(:,4) > 300 & a(:,2) > 0.75);

 figure
subplot(1,2,1) ; plot(a(ii,3),a(ii,2))
set(gca,'YDir','reverse'); xlabel('Temperature') ; ylabel('Depth (m)')

subplot(1,2,2) ; plot(a(ii,4),a(ii,2))
set(gca,'YDir','reverse'); xlabel('Conductivity') ; ylabel('Depth (m)')
%------------------------------------------------------------------------

end