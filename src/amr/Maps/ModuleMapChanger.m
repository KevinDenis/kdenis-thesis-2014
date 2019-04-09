function [nextMapID, nextModuleID] = ModuleMapChanger(robotPos,currentMap,currentModule,destModule,incr)
%[nextMapID, nextModuleID] = ModuleMapChanger(robotPos,currentMap,currentModule,destModule,incr)
%   This function makes it possible to allert the main function to change
%   its map. The "physical map changing" still has to be performed by the
%   main function.
%
%   For practical reasons, there is only two points where a map change is
%   needed for inter module navigation :
%   1) if you want to go from module  1 to module  2 (visa versa)
%   2) if you want to go from module 13 to module 14 (visa versa)
%
%   Another MapChange should be executed when the robot arrives at module
%   destination, this should be done in the main program.
%
%   MapID info
%   MapID = 0 : Groundfloor : Modules : -1, 0, 1, 2
%   MapID = 1 : Firstfloor  : Modules :  3, 4, 5, 6 
%   MapID = 2 : Secondfloor : Modules :  7, 8, 9,10     
%   MapID = 3 : Thridfloor  : Modules : 11,12,13,14

%% Parameters
switchPos1 = Module2Pos(3);
switchPos2 = Module2Pos(4);
switchPos3 = Module2Pos(5);
switchPos4 = Module2Pos(6);

shortModuleID=ShortModuleID(currentModule);
nextMapID=currentMap;
nextModuleID=currentModule;
d_thr_map = 2;

dr1=DistanceCalculator(robotPos,switchPos1);
dr2=DistanceCalculator(robotPos,switchPos2);
dr3=DistanceCalculator(robotPos,switchPos3);
dr4=DistanceCalculator(robotPos,switchPos4);

if     incr>0                % going up
    if     dr1 < d_thr_map && shortModuleID==2
        nextModuleID=currentModule+incr;
        if currentMap ~= 1
            nextMapID=currentMap+incr;
        end
        
    elseif dr2 < d_thr_map && shortModuleID==-1
        nextModuleID=currentModule+incr;
        
    elseif dr3 < d_thr_map && shortModuleID==0
        nextModuleID=currentModule+incr;
        if currentMap == 1
            nextMapID=currentMap+incr;
        end
        
    elseif dr4 < d_thr_map && shortModuleID==1
        nextModuleID=currentModule+incr;
    end      
    
elseif incr<0 % going down
    if     dr1 < d_thr_map && shortModuleID==0
        nextModuleID=currentModule+incr;
           if (currentMap ~= 1 && (destModule ~= currentModule+incr)) 
            nextMapID=currentMap+incr;
           end
        
        
    elseif dr2 < d_thr_map && shortModuleID==1
        nextModuleID=currentModule+incr;
     
    elseif dr3 < d_thr_map && shortModuleID==2
        nextModuleID=currentModule+incr;
        if currentMap == 2   % FROM 1 -> 2 change to 1 if problems
            nextMapID=currentMap+incr;
        end
        
    elseif dr4 < d_thr_map && shortModuleID==-1
        nextModuleID=currentModule+incr;    
end

end