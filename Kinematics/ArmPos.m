classdef ArmPos
    %This (class) object describes the current position of the robot arm. 
    
    %This class also containts some amount of functions to compute given
    %variables of the current position
    properties (Constant) 
        L1 = 81;
        L2 = 165;
        L3 = 80;
        L4 = 130;
        L5 = 130;
        L6 = 120;
        L7 = 65;
        L8 = 50;
        X = [0,81]; %=[0,L1]
        Z = [0,246]; %=[0,L1+L2]
        phiXmin = -10;
        phiXmax = 140;
        phiZmin = -45;
        phiZmax = 80;
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
        phi1 = 0;

    end
    
    methods
        
        function obj = ArmPos()
            %constructor of the position object
        end 
        
        function obj = setD(obj)
            obj.D = [obj.C(1),obj.C(2)-obj.L8];
        end
        
        function obj = ACtoB(obj)
            %computes the position of point B from A and C 
            c = obj.distance(obj.A,obj.C);
            a = abs(obj.A(1) - obj.C(1));
            b = abs(obj.A(2) - obj.C(2));
            f = obj.L6/c;
            x = a*f;
            y = b*f;
            
            Br = obj.A(1) + x;
            Bz = obj.A(2) - y;
            obj.B = [Br,Bz];
        end
        
        function [obj, error] = phiZXtoFullpos(obj, verbose)
            error = false;
            %computes all of the coordinates from phiZ and phiX
            obj.A = obj.L5 * [cos(obj.phiZ),sin(obj.phiZ)] + obj.Z;
            obj.E = obj.L3 * [cos(obj.phiX),sin(obj.phiX)] + obj.X;
            
            [Bpos, failed] = CircCirc(obj.A,obj.E,obj.L6,obj.L4,verbose);
            if failed == true
                if (verbose)
                    %this can happen quite a lot so this is only printed in
                    %verbose mode
                    disp("impossible pos");
                end
                error = true;
                return
            end
            correctPosCount = 0;
            for i=1:2
               obj.B = Bpos(i,:);
             
               obj = obj.getPhi1();
               %{
               %Uncomment to draw possible solutions for B
               obj = obj.setD;
               obj.draw()
               %}
               if obj.checkPhi1() == false %if this does not fail it means that phi1 is valid
                   correctObj = obj;
                   correctPosCount = correctPosCount + 1;
                   if correctPosCount == 2
                       %this is something we always want to print because
                       %this should basically never happen
                       disp("two correct pos found at" +obj.phiX + ' and ' + obj.phiZ);
                   end
                   if verbose
                       disp("correct pos found");
                   end
                   continue 
               end
            end
            
            if correctPosCount == 0
                error = true;
                if verbose
                    disp("no correct position found");
                end
                return
            end
            obj = correctObj;
            obj = obj.ABtoC;
            obj = obj.setD; %computing D
        end
        
        function obj = ABtoC(obj)
            phi = obj.getAngle(obj.A,obj.B);
            %{ 
            %Alternate way of calculating phi
            P1 = obj.A;
            P2 = obj.B;
            h = P2(2)-P1(2);
            w = P2(1)-P1(1);
            phi = atan(h/w);
            %}
            obj.C = obj.B + obj.L7*[cos(phi),sin(phi)];
        end
        
        function obj = draw(obj)
            fig = figure();
            clf;
            hold on
            plot([0,obj.X(1)],[0,obj.X(2)],'r'); %origin to X
            plot([obj.X(1),obj.Z(1)],[obj.X(2),obj.Z(2)],'r'); %X-Z
            plot([obj.E(1),obj.X(1)],[obj.E(2),obj.X(2)],'b');%EX
            plot([obj.E(1),obj.B(1)],[obj.E(2),obj.B(2)],'b');%EB
            plot([obj.A(1),obj.Z(1)],[obj.A(2),obj.Z(2)],'b');%AZ
            plot([obj.A(1),obj.B(1)],[obj.A(2),obj.B(2)],'g');%AB
            plot([obj.B(1),obj.C(1)],[obj.B(2),obj.C(2)],'g');%BC
            plot([obj.C(1),obj.D(1)],[obj.C(2),obj.D(2)],'g');%CD
        end
        
        function obj = getPhiX(obj)
            obj.phiX = obj.getAngle(obj.X,obj.E);
        end
        
        function obj = getPhiZ(obj)
            obj.phiZ = obj.getAngle(obj.Z,obj.A);
        end
        
        function obj = getPhi1(obj)
            theta = obj.getAngle(obj.E,obj.B);
            obj.phi1 = theta - obj.phiX;
        end
        
        function obj = getAngles(obj)
            obj = obj.getPhiX();
            obj = obj.getPhiZ();
            obj = obj.getPhi1();
        end
        
        function succes = validate(obj)
            %this function checks if the robot arm has a valid position
            %given the constraints
            obj.getAngles;
            if obj.checkPhiZ()
                disp("Phi Z is incorrect");
                succes = false;
            end
            if obj.checkPhiX()
                disp("Phi X is incorrect");
                succes = false;
            end
            if obj.checkPhi1()
               disp("phi 1 is incorrect");
               succes = false;
            end
            
            EX = obj.distance(obj.E,obj.X);
            if round(EX) ~= obj.L3
                disp("|EX| != L3");
                succes = false;
            end
            
            BE = obj.distance(obj.B,obj.E);
            if round(BE) ~= obj.L4
                disp("|BE| != L4");
                succes = false;
            end
            AZ = obj.distance(obj.Z,obj.A);
            if round(AZ) ~= obj.L5
                disp("|AZ| != L5");
                succes = false;
            end
            
            AB = obj.distance(obj.A,obj.B);
            if round(AB) ~= obj.L6
                disp("|AB| != L6");
                succes = false;
            end
            
            BC = obj.distance(obj.B,obj.C);
            if round(BC) ~= obj.L7
                disp("|BC| != L7");
                succes = false;
            end
                
        end
        
        function failure = checkPhiZ(obj)
            if (obj.phiZ >= obj.phiZmin) && (obj.phiZ <= obj.phiZmax)
                failure = false;
            else
                failure = true;
            end 
        end
        
        function failure = checkPhiX(obj)
            if (obj.phiX >= obj.phiXmin) && (obj.phiX <= obj.phiXmax)
                failure = false;
            else
                failure = true;
            end 
        end
        
        function failure = checkPhi1(obj)
            %returns true if phi1 is in the wrong position or if the arm EB
            %is in an impossible position (needs further improvements)
            failure = false;
            if abs(obj.phi1) > pi/2
                failure = true;
                return
            end
            
            %if point B is behind point E the position is impossible
            if obj.B(1) < obj.E(1)+5
                failure = true;
                return
            end
            
            
        end
        
    end
    
    methods (Static)
        function d = distance(P1,P2)
             d = ( (P1(1)-P2(1))^2 + (P1(2)-P2(2))^2 )^0.5;
        end
        
        function finalphi = getAngle(P1,P2)
            h = P2(2)-P1(2);
            w = P2(1)-P1(1);
            phi = atan(h/w);
            %converting the answer to the 180 to - 180 degree rank of
            %motion
            if w < 0
               if h < 0
                   finalphi = phi - pi;
               else
                   finalphi = pi + phi;
               end 
            else
                if h < 0
                    finalphi = phi;
                else
                    finalphi = phi;
                end
            end
            %deg = 360*finalphi/(2*pi) %for printing out degrees
            %disp(deg)
        end
        

    end
    
    
    
end