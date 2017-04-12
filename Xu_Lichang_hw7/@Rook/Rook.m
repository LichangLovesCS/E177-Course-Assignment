classdef Rook < ChessPiece
    %ROOK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function rook = Rook(pos,team)
            rook = rook@ChessPiece(pos,team);
        end
        
        function moveArray = getMoveArray(piece)
            pos = piece.Position;
            x = pos(1);
            y = pos(2);
            moveArray = {};
            %Check x
            if x < 8
                toAdd = zeros(8-x,2);
                toAdd(:,2) = y;
                toAdd(:,1) = [x+1:8]';
                moveArray{end+1} = toAdd;
            end
            if x > 1
                toAdd = zeros(x-1,2);
                toAdd(:,2) = y;
                toAdd(:,1) = [x-1:-1:1]';
                moveArray{end+1} = toAdd;
            end
            
            %Check y
            if y < 8
                toAdd = zeros(8-y,2);
                toAdd(:,1) = x;
                toAdd(:,2) = [y+1:8]';
                moveArray{end+1} = toAdd;
            end
            if y > 1
                toAdd = zeros(y-1,2);
                toAdd(:,1) = x;
                toAdd(:,2) = [y-1:-1:1]';
                moveArray{end+1} = toAdd;
            end
        end
    end
    
    methods (Static)        
        function sym = getSymbol()
            sym = 'R';
        end
    end
end
