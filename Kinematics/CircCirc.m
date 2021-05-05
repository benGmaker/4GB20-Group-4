function [result, error] = CircCirc (C1, C2, R1, R2, verbose)
%source: 
%https://stackoverflow.com/questions/3349125/circle-circle-intersection-points#:~:text=Intersection%20of%20two%20circles&text=First%20calculate%20the%20distance%20d,is%20contained%20within%20the%20other.
    error = false;
    result = [];
    d = ( (C1(1)-C2(1))^2 + (C1(2)-C2(2))^2 )^0.5; %distance between the two circles
    if d == R1+R2
        if verbose
            disp("Only 1 intersection point")
        end
    end
    
    if d > R1 + R2
        if verbose
            disp("No intersection possible");
        end
        error = true;
        return
    end 
    
    if R1 == R2
       if C1 == C2
          disp("circles are concentric"); 
       end
    end
    
    a = (R1^2 - R2^2 + d^2)/(2*d);
    h = (R1^2 - a^2)^0.5;
    P2 = C1 + a * (C2-C1)/d;
    
    int1 = [P2(1) + h * ( C2(2) - C1(2) )/d, P2(2) - h * ( C2(1) - C1(1) )/d];
    int2 = [P2(1) - h * ( C2(2) - C1(2) )/d, P2(2) + h * ( C2(1) - C1(1) )/d];
    result = [int1;int2];
    
end