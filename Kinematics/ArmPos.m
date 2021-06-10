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
        L8 = 28;
        X = [0,81]; %=[0,L1]
        Z = [0,246]; %=[0,L1+L2]
        %{
        %less constraint
        phiXmin = -1;
        phiXmax = pi/2;
        phiZmin = -1;
        phiZmax = 0.3;
        phi1min = -pi*3/4;
        phi1max = pi*3/4;
        %}
        %
        %normal constraints
        phiXmin = -0.2;
        phiXmax = pi/2+0.1;
        phiZmin = -0.4;
        phiZmax = 0.3;
        phi1min = -pi*3/4;
        phi1max = pi*3/4;
        %}
    end
    
    %object for describing the current position of the arm
    properties 
        %all the variables describing all the positions of the joints
        %_ = [r,z]
        theta = 0;
        A = [0,0];
        B = [0,0];
        C = [0,0];
        D = [0,0];
        E = [0,0];  
        phiX = 0;
        phiZ = 0;
        phi1 = 0;
        isvalid = false; %be carefull this variable is not changed with the validate() function 
    end
    
    methods
        
        function obj = ArmPos()
            %constructor of the position object
        end 
        
        function obj = setD(obj)
            %computes the position of D given 
            obj.D = [obj.C(1),obj.C(2)-obj.L8];
        end
        
        function obj = DtoC(obj)
            obj.C = [obj.D(1),obj.D(2)+obj.L8];
        end
        
        function obj = ACtoB(obj)
            %computes the position of point B from A and C 
            
            c = distance(obj.A,obj.C);
            a = abs(obj.A(1) - obj.C(1));
            b = abs(obj.A(2) - obj.C(2));
            f = obj.L6/c;
            x = a*f;
            y = b*f;
            sign_a = sign(obj.A(1) - obj.C(1));
            Br = obj.A(1) - sign_a * x;
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
               if obj.checkPhi1() %if phi1 is oke than we have a valid B position
                   correctObj = obj;
                   correctPosCount = correctPosCount + 1;
                   if correctPosCount == 2
                       if verbose %this should basically never happen
                           disp("two correct pos found at" +obj.phiX + ' and ' + obj.phiZ);
                       end
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
            xlim([-10,350]);
            ylim([-10,350]);
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
        
        function succes = validate(obj, verbose)
            %this function checks if the robot arm has a valid position
            %given the constraints
            succes = true;
            obj.getAngles;
            if obj.checkPhiZ(verbose) == false
                if verbose
                    disp("Phi Z is incorrect");
                end
                succes = false;
            end
            if obj.checkPhiX() == false
                if verbose
                    disp("Phi X is incorrect");
                end
                succes = false;
            end
            if obj.checkPhi1() == false
                if verbose
                    disp("phi 1 is incorrect");
                end
                succes = false;
            end
            
            EX = distance(obj.E,obj.X);
            if round(EX) ~= obj.L3
                if verbose
                    disp("|EX| != L3");
                end
                succes = false;
            end
            
            BE = distance(obj.B,obj.E);
            if round(BE) ~= obj.L4
                if verbose
                    disp("|BE| != L4");
                end
                succes = false;
            end
            AZ = distance(obj.Z,obj.A);
            if round(AZ) ~= obj.L5
                if verbose
                    disp("|AZ| != L5");
                end
                succes = false;
            end
            
            AB = distance(obj.A,obj.B);
            if round(AB) ~= obj.L6
                if verbose
                    disp("|AB| != L6");
                end
                succes = false;
            end
            
            BC = distance(obj.B,obj.C);
            if round(BC) ~= obj.L7
                if verbose 
                    disp("|BC| != L7");
                end
                succes = false;
            end
            
            CD = distance(obj.C,obj.D);
            if round(CD) ~= obj.L8
                if verbose 
                    disp("|CD| != L8");
                end
                succes = false;
            end
        end
        
        function succes = checkPhiZ(obj, verbose)
            if (obj.phiZ >= obj.phiZmin) && (obj.phiZ <= obj.phiZmax)
                succes = true;
            else
                succes = false;
                if verbose
                   disp("PhiZ is invalid"); 
                end
            end 
        end
        
        function succes = checkPhiX(obj)
            if (obj.phiX >= obj.phiXmin) && (obj.phiX <= obj.phiXmax)
                succes = true;
            else
                succes = false;
            end 
        end
        
        function succes = checkPhi1(obj)
            %returns true if phi1 is in the wrong position or if the arm EB
            %is in an impossible position (needs further improvements)
            succes = true;
            
            if (obj.phi1 >= obj.phi1min) && (obj.phi1 <= obj.phi1max)
                succes = true;
            else
                succes = false; 
                return
            end
            
            %if point B is behind point E the position is impossible
            if obj.B(1) < obj.E(1)+5
                succes = false;
                return
            end
            
            
        end
        
    end
    
    methods (Static)
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