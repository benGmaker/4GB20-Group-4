classdef KineMod %KinematicModel 
    properties (Constant) 
        %Constant properties of the kinematic model
        L1 = 81;
        L2 = 165;
        L3 = 80;
        L4 = 130;
        L5 = 130;
        L6 = 120;
        L7 = 65;
        L8 = 50;
    end
    
    properties 
        %Variable properties of the kinematic model
        phiXmin = -10;
        phiXmax = 140;
        phiZmin = -45;
        phiZmax = 80;
        Positions;
        PrevPos;
        CurPos; 
    end
    
    methods %Functions that can change the variable properties of the kinematic model
        function obj = KineMod(startPos)
            %This is the constructor class, here the variable properties of
            %the kinematic model can be set for the first time
            CurrentPos = startPos;
        end
        
        
        function obj = setVal(obj, x)
            %example function of how to change a variable of the kinematic
            %model, this is also called a state change
            obj.phiXmax = x;
        end
    end
    
    methods (Static) %function that cannot change the variable properties (state) of
        %kinematic model
        function [r, z] = get_rz(X,Z)
           %returns the r and z position of the end-effector given the X
           %angle and Z angle of the drivers
           r = X;
           z = Z; 
        end
        
        function [X, Z] = get_inverse(r,z)
            X = r;
            Z = z;
        end

        
        
    end
end
