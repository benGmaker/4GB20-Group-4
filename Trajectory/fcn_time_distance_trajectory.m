function [coords, L] = fcn_time_distance_trajectory(coords, vel, fs)
len = length(coords(1,:));
samples = zeros(1,len);
L = zeros(1,len);

for i = 1:len-1
    r_0 = coords(1,i);
    r_1 = coords(1,i+1);
    th_0 = coords(2,i);
    th_1 = coords(2,i+1);
    z_0 = coords(3,i);
    z_1 = coords(3,i+1);
    
    L(i+1) = fcn_path_Length(r_0, r_1, th_0, th_1, z_0, z_1);
    samples(i+1) = round(L(i+1)/vel*fs);
end

coords = [coords; samples];

end