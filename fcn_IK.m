function [Rx, Rz] = fcn_IK(r, z, IK)

for i = 1:length(r)
    [sRxa sRz] = vpasolve([IK.er == r(i), IK.ez == z(i)], [IK.Rxa, IK.Rz]);
    Rx(i) = (1/2*pi-double(sRxa));
    Rz(i) = (double(sRz));
end

end