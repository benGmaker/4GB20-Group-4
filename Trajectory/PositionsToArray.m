function array = PositionsToArray(initR,initTheta,initZ,r_s,theta_s,r_p,theta_p,z)
    if length(r_s)>=length(r_p)
        r_p(1:length(r_s));
    elseif length(r_s)<=length(r_p)
        r_s(1:length(r_p));
    end
    array=[initR;initTheta;initZ];
    for i=1:length(r_s)
        array=[array,[r_s(i) r_p(i);theta_s(i) theta_p(i);z z]];
    end
end