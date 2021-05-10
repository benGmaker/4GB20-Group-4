classdef ArmAcc
    properties (Constant)
        ddX = 0;
        ddZ = 0;
    end
    
    properties 
        dt = 0;
        ddA = [0,0];
        ddB = [0,0];
        ddC = [0,0];
        ddD = [0,0];
        ddE = [0,0];
        ddphiX = [0,0];
        ddphiZ = [0,0];
        ddphi1 = [0,0];
    end
    
    methods 
        function obj = ArmAcc(dt,v1,v2)
            obj.dt = dt;
            obj = obj.deltaV(v1,v2);
        end
        
        function obj = deltaV(obj,v1,v2)
            obj.ddA = (v2.dA - v1.dA)/obj.dt;
            obj.ddB = (v2.dB - v1.dB)/obj.dt;
            obj.ddC = (v2.dC - v1.dC)/obj.dt;
            obj.ddD = (v2.dD - v1.dD)/obj.dt;
            obj.ddE = (v2.dE - v1.dE)/obj.dt;
            obj.ddphiX = (v2.dphiX - v1.dphiX)/obj.dt;
            obj.ddphiZ = (v2.dphiZ - v1.dphiZ)/obj.dt;
            obj.ddphi1 = (v2.dphi1 - v1.dphi1)/obj.dt;
        end
       
        
        
    end
    
end
