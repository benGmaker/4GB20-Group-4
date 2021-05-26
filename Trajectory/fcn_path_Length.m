function L = fcn_path_Length(r_0, r_1, th_0, th_1, z_0, z_1)

    if th_1 - th_0 == 0
        L = sqrt((r_1 - r_0)^2 + (z_1 - z_0)^2);
    elseif th_1 ~= th_0 && r_0 == r_1 && z_0 == z_1
        L = sqrt((z_1 - z_0)^2 + ((th_0 - th_1)*r_0)^2);
    else
        L_z = log(((r_0*th_1 - r_1*th_1 - r_0*th_1 + r_1*th_0)^2/(th_0 - th_1)^2 + (r_0 - r_1)^2/(th_0 - th_1)^2)^(1/2) + (r_0*(th_1 - th_1))/(th_0 - th_1) - (r_1*(th_1 - th_0))/(th_0 - th_1))*(r_0/(2*(th_0 - th_1)) - r_1/(2*(th_0 - th_1))) + (((r_0*(th_1 - th_1))/(th_0 - th_1) - (r_1*(th_1 - th_0))/(th_0 - th_1))*((r_0/(th_0 - th_1) - r_1/(th_0 - th_1))^2 + ((r_0*(th_1 - th_1))/(th_0 - th_1) - (r_1*(th_1 - th_0))/(th_0 - th_1))^2)^(1/2))/(2*(r_0/(th_0 - th_1) - r_1/(th_0 - th_1))) - (log(((r_0*th_0 - r_1*th_0 - r_0*th_1 + r_1*th_0)^2/(th_0 - th_1)^2 + (r_0 - r_1)^2/(th_0 - th_1)^2)^(1/2) + (r_0*(th_0 - th_1))/(th_0 - th_1) - (r_1*(th_0 - th_0))/(th_0 - th_1))*(r_0/(2*(th_0 - th_1)) - r_1/(2*(th_0 - th_1))) + (((r_0*(th_0 - th_1))/(th_0 - th_1) - (r_1*(th_0 - th_0))/(th_0 - th_1))*((r_0/(th_0 - th_1) - r_1/(th_0 - th_1))^2 + ((r_0*(th_0 - th_1))/(th_0 - th_1) - (r_1*(th_0 - th_0))/(th_0 - th_1))^2)^(1/2))/(2*(r_0/(th_0 - th_1) - r_1/(th_0 - th_1))));
        L = sqrt(L_z^2 + (z_1 - z_0)^2);
    end
    
end

