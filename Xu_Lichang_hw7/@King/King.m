classdef King < ChessPiece
    %KING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function king = King(pos,team)
            king = king@ChessPiece(pos,team);
        end
        
        function moveArray = getMoveArray(piece)
            pos = piece.Position;
            x = pos(1);
            y = pos(2);
            moveArray = {};
            if y < 8
                moveArray{end+1} = [x,y+1];
            end
            if x < 8 && y < 8
                moveArray{end+1}=[x+1,y+1];
            end
            if x < 8
                moveArray{end+1} = [x+1,y];
            end
            if x < 8 && y > 1
                moveArray{end+1}=[x+1,y-1];
            end
            if y > 1
                moveArray{end+1} = [x,y-1];
            end
            if x > 1 && y > 1
                moveArray{end+1}=[x-1,y-1];
            end
            if x > 1
                moveArray{end+1} = [x-1,y];
            end
            if x > 1 && y < 8
                moveArray{end+1}=[x-1,y+1];
            end
        end
    end
    
    methods (Static)        
        function sym = getSymbol()
            sym = 'K';
        end
    end
end

