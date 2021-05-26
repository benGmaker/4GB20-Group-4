function [alpha,beta] = calibrationalphabeta(ticsX,ticsZ,ticsR)
tpr=4000; % tics per revolution

% tics to radians
radX=ticsX/tpr*2*pi*0.09;
radZ=ticsZ/tpr*2*pi*0.09;
radR=ticsR/tpr*2*pi*9/105;

% expected range of phiX and phiZ
n=100;
phiX=linspace(1,1.3,n);
phiZ=linspace(-0.18,-0.22,n);

for i=1:n
    for j=1:n
        posA(100*(i-1)+j) = ArmPos;
        posA(100*(i-1)+j).phiX = phiX(i);
        posA(100*(i-1)+j).phiZ = phiZ(j);
        posA(100*(i-1)+j) = posA(100*(i-1)+j).phiZXtoFullpos(false);
    end
end


for i=1:n
    for j=1:n
        rA(i,j)=posA(100*(i-1)+j).D(1);
        zA(i,j)=posA(100*(i-1)+j).D(2);
    end
end

for i=1:n
    for j=1:n
        posB(100*(i-1)+j) = ArmPos;
        posB(100*(i-1)+j).phiX = phiX(i)+radX;
        posB(100*(i-1)+j).phiZ = phiZ(j)+radZ;
        posB(100*(i-1)+j) = posB(100*(i-1)+j).phiZXtoFullpos(false);
    end
end

for i=1:n
    for j=1:n
        rB(i,j)=posB(100*(i-1)+j).D(1);
        zB(i,j)=posB(100*(i-1)+j).D(2);
    end
end
factor=(max(rA(:))-min(rA(:)))/(max(zA(:))-min(zA(:)));
error=abs(rB-rA-65)+factor*abs(zB-zA);
[cx,cz]=find(error==min(error(:)));
alpha=rA(cx,cz)-75;
beta=rA(cx,cz)*cos(pi/2-radR-asin(rA(cx,cz)/75*sin(radR)));