classdef Bishop < ChessPiece
    %BISHOP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function bishop = Bishop(pos,team)
            bishop = bishop@ChessPiece(pos,team);
        end
        
        function moveArray = getMoveArray(piece)
            pos = piece.Position;
            x = pos(1);
            y = pos(2);
            moveArray = {};
            if x < 8 && y < 8
                toAdd = zeros(min(8-x,8-y),2);
                for i = 1:min(8-x,8-y)
                    toAdd(i,:) = [x+i,y+i];
                end
                moveArray{end+1}=toAdd;
            end
            if x < 8 && y > 1
                toAdd = zeros(min(8-x,y-1),2);
                for i = 1:min(8-x,y-1)
                    toAdd(i,:) = [x+i,y-i];
                end
                moveArray{end+1}=toAdd;
            end
            if x > 1 && y > 1
                toAdd = zeros(min(x-1,y-1),2);
                for i = 1:min(x-1,y-1)
                    toAdd(i,:) = [x-i,y-i];
                end
                moveArray{end+1}=toAdd;
            end
            if x > 1 && y < 8
                toAdd = zeros(min(x-1,8-y),2);
                for i = 1:min(x-1,8-y)
                    toAdd(i,:) = [x-i,y+i];
                end
                moveArray{end+1}=toAdd;
            end
        end
    end
    
    methods (Static)        
        function sym = getSymbol()
            sym = 'B';
        end
    end
    
end

