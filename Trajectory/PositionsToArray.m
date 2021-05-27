function array = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving)
    % Making the lengths of the source array and the print array the same
    if length(r_s)<=length(r_p)
        r_p=r_p(1:length(r_s));
    elseif length(r_s)>=length(r_p)
        r_s=r_s(1:length(r_p));
    end
    
    % Putting everything into an array
    array=[r_init r_init;theta_init theta_init;z_init z_moving;0 0];
    for i=1:length(r_s)
        array=[array,[r_s(i) r_s(i) r_s(i) r_p(i) r_p(i) r_p(i);theta_s(i) theta_s(i) theta_s(i) theta_p(i) theta_p(i) theta_p(i);z_moving z_pickup z_moving z_moving z_pickup z_moving;0 1 1 1 0 0]];
    end
end