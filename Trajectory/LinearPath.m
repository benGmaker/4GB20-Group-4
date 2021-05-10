function path = LinearPath(point1,point2,nsteps)
    r = linspace(point1(1), point2(1), nsteps);
    z = linspace(point1(2), point2(2), nsteps);

    posArray = ArmPos.empty([0,n]);
    for i=1:nsteps
        posArray(i) = ArmPos;
        posArray(i).D = [r(i),z(i)];
        posArray(i) = posArray(i).DtoC();
        posArray(i) = KineMod.IK_MAU(posArray(i).C);
    end
end