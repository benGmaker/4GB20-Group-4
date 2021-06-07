function [coords] = fcn_acceleration(pospath,aRmax,aXmax,aZmax,vmax,fs)
% The naming in this function is incorrect, but it still fullfills its
% function. R=r, X=theta, Z=z
% 
% aRmax=5;    % mm/s^2
% aXmax=5;    % mm/s^2
% aZmax=5;    % mm/s^2
% vmax=20;    % mm/s
% 
% pospath=CoordinatePath;

amax=[aRmax aXmax aZmax];
t_RXZ=[vmax/aRmax,vmax/aXmax,vmax/aZmax];
t_max=max(t_RXZ);
L_RXZ=[vmax^2/aRmax,vmax^2/aXmax,vmax^2/aZmax];

vR=[0];xR=[pospath(1,1)];vX=[0];xX=[pospath(2,1)];vZ=[0];xZ=[pospath(3,1)];
z=0;

for i=1:length(pospath)-1
    L=[pospath(1,i+1)-pospath(1,i) pospath(2,i+1)-pospath(2,i) pospath(3,i+1)-pospath(3,i)];
    
    frac_L=[abs(L(1))/abs(L_RXZ(1)) abs(L(2))/abs(L_RXZ(2)) abs(L(3))/abs(L_RXZ(3))];
    max_L=find(frac_L==max(frac_L));
    
    if max_L==1
        k=sign(L(1));
        m=sign(L(2))*frac_L(2)/frac_L(1);
        n=sign(L(3))*frac_L(3)/frac_L(1);
    elseif max_L==2
        k=sign(L(1))*frac_L(1)/frac_L(2);
        m=sign(L(2));
        n=sign(L(3))*frac_L(3)/frac_L(2);
    elseif max_L==3
        k=sign(L(1))*frac_L(1)/frac_L(3);
        m=sign(L(2))*frac_L(2)/frac_L(3);
        n=sign(L(3));
    end

    if L(max_L) <= L_RXZ(max_L)
        t=2*sqrt(abs(L(max_L))/amax(max_L));
        aR=[k*aRmax*ones(1,round(t/2*fs)) k*-aRmax*ones(1,round(t/2*fs))];
        aX=[m*aXmax*ones(1,round(t/2*fs)) m*-aXmax*ones(1,round(t/2*fs))];
        aZ=[n*aZmax*ones(1,round(t/2*fs)) n*-aZmax*ones(1,round(t/2*fs))];
    else
        t_flat=(L(max_L)-2*L_RXZ(max_L))/vmax;
        t=2*t_max+t_flat;
        aR=[k*aRmax*ones(1,round(t_max/2*fs)) zeros(1,round(t_flat*fs)) k*-aRmax*ones(1,round(t_max/2*fs))];
        aX=[m*aXmax*ones(1,round(t_max/2*fs)) zeros(1,round(t_flat*fs)) m*-aXmax*ones(1,round(t_max/2*fs))];
        aZ=[n*aZmax*ones(1,round(t_max/2*fs)) zeros(1,round(t_flat*fs)) n*-aZmax*ones(1,round(t_max/2*fs))];
    end
    z=length(xR)-1;
    for j=length(xR):length(xR)+length(aR)-1
        vR(j+1)=vR(j)+aR(j-z)/fs;
        vX(j+1)=vX(j)+aX(j-z)/fs;
        vZ(j+1)=vZ(j)+aZ(j-z)/fs;
        xR(j+1)=xR(j)+vR(j)/fs;
        xX(j+1)=xX(j)+vX(j)/fs;
        xZ(j+1)=xZ(j)+vZ(j)/fs;
    end
    
[xR(j), xX(j), xZ(j), pospath(1,i+1) pospath(2,i+1) pospath(3,i+1)]
end
coords=[xR;xX;xZ];

end

% figure()
% hold on
% plot(1:length(xR), xR)
% plot(1:length(xR), xZ)
% legend("xr","xz")
% 
% figure()
% plot(1:length(xR), xX)
% legend("xTheta")