function moves = getMoves(piece)
    %GETMOVES Returns the possible moves for a ChessPiece.
    %   MOVES = GETMOVES(PIECE) This method returns a 3 column array
    %   representing the possible moves for a piece.  The first two entries
    %   in a row are the x and y values of the position, and the third
    %   column is 1 if the position is occupied by a piece of the opposing
    %   team (that is, it is an attack move), or 0 if the space is
    %   unoccupied.
    
   moveArray = piece.getMoveArray();
   moves = [];
   for i = 1:length(moveArray)
       thisDir = moveArray{i};
       for j = 1:size(thisDir,1)
           [occ,pc] = piece.Board.checkPosition(thisDir(j,:));
           if occ
               if pc.Team ~= piece.Team
                   moves(end+1,:) = [thisDir(j,:),true];
               end
               break;
           else
               moves(end+1,:) = [thisDir(j,:),false];
           end
       end
   end
   
end

