function array = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving)
    if length(r_s)>=length(r_p)
        r_p(1:length(r_s));
    elseif length(r_s)<=length(r_p)
        r_s(1:length(r_p));
    end
    array=[r_init r_init;theta_init theta_init;z_init z_moving];
    for i=1:length(r_s)
        array=[array,[r_s(i) r_s(i) r_s(i) r_p(i) r_p(i) r_p(i);theta_s(i) theta_s(i) theta_s(i) theta_p(i) theta_p(i) theta_p(i);z_moving z_pickup z_moving z_moving z_pickup z_moving]];
    end
end