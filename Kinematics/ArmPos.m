classdef ArmPos
    %This (class) object describes the current position of the robot arm. 
    
    %This class also containts some amount of functions to compute given
    %variables of the current position
    properties (Constant) 
        %L1 = 81;
        %L2 = 165;
        %L3 = 80;
        %L4 = 130;
        %L5 = 130;
        %L6 = 120;
        %L7 = 65;
        L8 = 50;
        X = [0,81]; %=[0,L1]
        Z = [0,246]; %=[0,L1+L2]
    end
    
    %object for describing the current position of the arm
    properties 
        %all the variables describing all the positions of the joints
        %_ = [r,z]
        A = [0,0];
        B = [0,0];
        C = [0,0];
        D = [0,0];
        E = [0,0];  
        phiX = 0;
        phiZ = 0;
    end
    
    methods 
        function obj = ArmPos()
            %constructor of the position object
        end 
        
       function obj = setD(obj)
            obj.D = [obj.C(1),obj.C(2)-obj.L8];
        end
        
    end
    
    
    
end