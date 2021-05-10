function path = FourStopLinearPath(startpos,endpos, height)
    pos1 = startpos;
    pos1.D(2) = pos1.D(2) + height;
    pos2 = endpos;
    pos2.D(2) = pos2.D(2) + height;
    
    path = LinearPath(startpos, pos1, 200);
    path = [path, LinearPath(pos1, pos2, 200)];
    path = [path, LinearPath(pos2, endpos, 200)]; 
end