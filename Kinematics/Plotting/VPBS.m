classdef VPBS
    
    methods (Static)
        function result = r_right(min,max,z,acc)
            mid = (min + max)/2;
            if abs(min - max) < acc 
                %if the difference between the min and max is smaller than
                %the desired accuracy the we have found the valid position
                %edge
                result = mid;
                return
            end
            pos = KineMod.IK_MAU([mid,z],false);
            
            if pos.isvalid
                newmin = mid;
                newmax = max;
            else
                newmin = min;
                newmax = mid;
            end
            
            result = VPBS.r_right(newmin,newmax,z,acc); %recursive functions baby!
        end
        
       function result = r_left(min,max,z,acc)
            mid = (min + max)/2;
            if abs(min - max) < acc 
                %if the difference between the min and max is smaller than
                %the desired accuracy the we have found the valid position
                %edge
                result = mid;
                return
            end
            pos = KineMod.IK_MAU([mid,z],false);
            
            if pos.isvalid
                newmin = min;
                newmax = mid;
            else
                newmin = mid;
                newmax = max;
            end
            
            result = VPBS.r_left(newmin,newmax,z,acc); %recursive functions baby!
       end
       
       function result = r_valid_guess(min,max,z,acc)
           mid = (min + max)/2;
           if abs(min - max) < acc 
              result = -100; %returning a stupid value such that we can filter it out
              return
           end
           
           pos = KineMod.IK_MAU([mid,z],false);
           if pos.isvalid
               result = mid;
               return
           end
           
           r_left = VPBS.r_valid_guess(min,mid,z,acc);
           r_right = VPBS.r_valid_guess(mid,max,z,acc);
           %r_left = parfeval(@VPBS.r_valid_guess,1,min,mid,z,acc);
           %r_right = parfeval(@VPBS.r_valid_guess,1,mid,max,z,acc);
           %wait(r_left);
           %wait(r_right);
           if r_left ~= -100 %left result is valid
               result = r_left;
               return
           elseif r_right ~= -100 %right result is valid
               result = r_right;
               return 
           else
               result = -50; %no result is valid wtf
               %disp("no valid start pos found");
               return
           end
       end
        
        
        
    end
    
end