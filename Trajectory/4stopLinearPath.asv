function path = 4stopLinearPath(startpos,endpos, height)
    pos1 = startpos;
    pos1.D(2) = pos1.D(2) + height;
    pos2 = endpos;
    pos2.D(2) = pos2.D(2) + height;
    
    path = [LinearPath(startpos.D, pos1.D, 200)];
    path = [path, LinearPath(pos1.D, pos2.D, 200)];
    path = [path, LinearPath(pos2.D, endpos.D, 200)]; 
end