function path = LinearPath(pos1,pos2,nsteps)
    r = linspace(pos1.D(1), pos2.D(1), nsteps);
    z = linspace(pos1.D(2), pos2.D(2), nsteps);
    theta = linspace(pos1.theta, pos2.theta, nsteps);

    path = ArmPos.empty([0,nsteps]);
    for i=1:nsteps
        path(i) = ArmPos;
        path(i).D = [r(i),z(i)];
        path(i).theta = theta(i);
        path(i) = path(i).DtoC();
        path(i) = KineMod.IK_MAU(path(i).C,false);
    end
end