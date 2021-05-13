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
        L8 = 28;
    end
    
    properties 
        %Variable properties of the kinematic model
        phiXmin = -10;
        phiXmax = 140;
        phiZmin = -45;
        phiZmax = 80;
        PrevPos; %array or single value which contains history of positions
        CurPos; 
    end
    %{
    methods %Functions that can change the variable properties of the kinematic model
        function obj = KineMod()
            %This is the constructor class, here the variable properties of
            %the kinematic model can be set for the first time
        end
    end
    %}
    methods (Static) %function that cannot change the variable properties (state) of
        %kinematic model
        function pos = IK_MAU(C_coord,verbose)
            %Inverse Kinematic Middle Arm Up
            %Given the coordinate of C computes the IK 
            %Perfroms inverse kinematic computation with the assumption
            %that the middle arm is always pointings upwards
            pos = ArmPos();
            pos.C = C_coord;
            [r1, error1] = KineMod.CtoA(pos);
            if error1
                if verbose 
                    disp('failed to find A coordinate');
                end
                return
            end
            [r2, error2] = KineMod.BtoE(r1);
            if error2
                if verbose 
                    disp('failed to find E coordinate');
                end
                return 
            end
            pos = KineMod.negativePhi1(r2);
        end
        
        
        function r = negativePhi1(pos)
            %returns the 
            for i=1:length(pos)
                if pos(i).phi1 <= 0 
                    r = pos(i);
                end
            end 
        end
        
        function f = kinDist(prevPos, posArray)
            %returns a factor describing the total sum of distance between
            %the previous position and potential new position
            L = length(posArray);
            f = zeros(1,L);
            for i=1:L
                s = 0;
                s = s + distance(prevPos.A,posArray(i).A);
                s = s + distance(prevPos.B,posArray(i).B);
                s = s + distance(prevPos.E,posArray(i).E);
                f(i) = s;
            end
            
        end
        
        function [finalPos, error] = CtoA(CurPos)
            %given position C is known in CurPos returns possible valid
            %positions of A and B in their respective ArmPos (this can be at most 2)
            error = false;
            A_pos = CircCirc(CurPos.C,CurPos.Z,CurPos.L6+CurPos.L7,CurPos.L5,false); %find possible positions for A
            pos = [CurPos; CurPos]; %creating position array
            j = 1;
            for i=1:length(A_pos) %itterating over position array
                A = A_pos(i,:); 
                pos(i).A = A; %assinging new A value to a position
                pos(i) = pos(i).getPhiZ(); %computing phiZ
                if pos(i).checkPhiZ() %if phiZ is valid will return this solution
                    finalPos(j) = pos(i).ACtoB(); 
                    j = j + 1;
                end
            end
            
            if j == 1 %no positions are found
                finalPos = [];
                error = true;
            end
        end
        
        function [finalPos, error]= BtoE(positions)
            %for given one or more possitions returns possible positions of
            %the robot arm
            error = false;
            L = length(positions);
            k = 1;
            for i=1:L %itterating over the input positions
                CurPos = positions(i); %setting the current position
                E_pos = CircCirc(CurPos.X,CurPos.B,CurPos.L3,CurPos.L4,false); %finding possible positions for E
                pos = [CurPos; CurPos]; %creating position array
                for j=1:length(E_pos) %itterating over position array
                    E = E_pos(j,:); 
                    pos(j).E = E;%assinging new position
                    pos(j) = pos(j).getAngles; %computing angles
                    pos(j) = pos(j).setD;
                    %pos(j).draw();
                    if pos(j).validate(false) %check if a valid position has been created
                        finalPos(k) = pos(j); %add valid position to result
                        k = k + 1;
                    end
                end
            end
            
            if k == 1
                finalPos = [];
                error = true;
            end
        end
        
        
        
        
    end
end

