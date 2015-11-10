%read x and y data
x=textread('x.daa');
y=textread('y.daa');
y1=transpose(y);
% read u and density; note that the semicolon suppresses screen display
u=textread('uflow.daa');
uflow=u(:,1:26);
r=textread('dens.daa');
dens=r(:,1:26);

contourf(x,y1,uflow,20); axis([23.99 24.49 1.5 10])
set(gca,'YDir','reverse') ; xlabel('Time (day of Feb 1998)') ; ylabel('Depth (m)')
figure
contourf(x,y1,dens,20)
set(gca,'YDir','reverse') ; xlabel('Time (day of Feb 1998)') ; ylabel('Depth (m)')
m=zeros(18,1) ; d=zeros(18,1);
figure
for k=1:18 ; d(k)=mean(dens(k,:)) ; end
plot(d,y1)
set(gca,'YDir','reverse'); xlabel('Density (kg/m3)') ; ylabel('Depth (m)')
figure
for k=1:18 ; m(k)=mean(uflow(k,:)) ; end
plot(m,y1)
set(gca,'YDir','reverse'); xlabel('Mean Flow (cm/s)') ; ylabel('Depth (m)')