function initializeProperties(pawn,team)
  %INITIALIZEPROPERTIES Sets the Direction, Attack1 and Attack2 properties for a Pawn
  
   if mod(team,4) == 1
       pawn.Direction = [0,1];
   elseif mod(team,4) == 2
       pawn.Direction = [0,-1];
   elseif mod(team,4) == 3
       pawn.Direction = [1,0];
   else
       pawn.Direction = [-1,0];
   end
   att1 = pawn.Direction;
   att1(find(pawn.Direction==0))=1;
   att2 = pawn.Direction;
   att2(find(pawn.Direction==0))=-1;
   pawn.Attack1 = att1;
   pawn.Attack2 = att2;
   
end