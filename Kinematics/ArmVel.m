classdef ArmVel
    properties (Constant)
        dX = [0,0];
        dZ = [0,0];
    end
    
    properties 
        dt = 0;
        dtheta = 0;
        dA = [0,0];
        dB = [0,0];
        dC = [0,0];
        dD = [0,0];
        dE = [0,0];
        dphiX = [0,0];
        dphiZ = [0,0];
        dphi1 = [0,0];
    end
    
    methods 
        function obj = ArmVel(dt,pos1,pos2)
            obj.dt = dt;
            obj = obj.deltaPos(pos1,pos2);
        end
        
        function obj = deltaPos(obj,pos1,pos2)
            obj.dtheta = (pos2.theta - pos1.theta)/obj.dt;
            obj.dA = (pos2.A - pos1.A)/obj.dt;
            obj.dB = (pos2.B - pos1.B)/obj.dt;
            obj.dC = (pos2.C - pos1.C)/obj.dt;
            obj.dD = (pos2.D - pos1.D)/obj.dt;
            obj.dE = (pos2.E - pos1.E)/obj.dt;
            obj.dphiX = (pos2.phiX - pos1.phiX)/obj.dt;
            obj.dphiZ = (pos2.phiZ - pos1.phiZ)/obj.dt;
            obj.dphi1 = (pos2.phi1 - pos1.phi1)/obj.dt;
        end
    end
    
end
