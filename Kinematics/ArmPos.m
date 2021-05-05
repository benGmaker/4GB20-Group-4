classdef ArmPos
    %The properties of this class are ment to store 
    properties (Constant) 
        %L1 = 81;
        %L2 = 165;
        %L3 = 80;
        %L4 = 130;
        %L5 = 130;
        %L6 = 120;
        %L7 = 65;
        L8 = 50;
        A = [0,81]; %=[0,L1]
        B = [0,246]; %=[0,L1+L2]
    end
    
    %object for describing the current position of the arm
    properties 
        %all the variables describing all the positions of the joints
        %_ = [r,z]
        C = [0,0];
        D = [0,0];
        E = [0,0];
        F = [0,0];
        G = [0,0];  
        phiX = 0;
        phiZ = 0;
    end
    
    methods 
        function obj = ArmPos()
            %constructor of the position object
        end 
        
        function obj = setF(obj)
            obj.F = [obj.E(1),obj.E(2)-obj.L8];
        end
        
    end
    
    
    
end