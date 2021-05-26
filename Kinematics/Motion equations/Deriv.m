function result = Deriv(eq,X,Z,dX,dZ,ddX,ddZ)
    %NOTE: this only takes it to the second derivative and not any higher
    result = diff(eq,dX)*ddX + diff(eq,dZ)*ddZ + diff(eq,X)*dX + diff(eq,Z)*dZ;
end