function [Rx, Rz] = fcn_IK(r, z, IK)

for i = 1:length(r)
    [sRxa sRz] = vpasolve([IK.er == r(i), IK.ez == z(i)], [IK.Rxa, IK.Rz]);
    Rx(i) = rad2deg(pi - double(sRxa));
    Rz(i) = rad2deg(double(sRz));
end

end