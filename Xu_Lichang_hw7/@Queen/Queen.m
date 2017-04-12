classdef Queen < ChessPiece
    %QUEEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function queen = Queen(pos,team)
            queen = queen@ChessPiece(pos,team);
        end
        
        function moveArray = getMoveArray(piece)
            pos = piece.Position;
            x = pos(1);
            y = pos(2);
            moveArray = {};
            if y < 8
                toAdd = zeros(8-y,2);
                toAdd(:,1) = x;
                toAdd(:,2) = [y+1:8]';
                moveArray{end+1} = toAdd;
            end
            if x < 8 && y < 8
                toAdd = zeros(min(8-x,8-y),2);
                for i = 1:min(8-x,8-y)
                    toAdd(i,:) = [x+i,y+i];
                end
                moveArray{end+1}=toAdd;
            end
            if x < 8
                toAdd = zeros(8-x,2);
                toAdd(:,2) = y;
                toAdd(:,1) = [x+1:8]';
                moveArray{end+1} = toAdd;
            end
            if x < 8 && y > 1
                toAdd = zeros(min(8-x,y-1),2);
                for i = 1:min(8-x,y-1)
                    toAdd(i,:) = [x+i,y-i];
                end
                moveArray{end+1}=toAdd;
            end
            if y > 1
                toAdd = zeros(y-1,2);
                toAdd(:,1) = x;
                toAdd(:,2) = [y-1:-1:1]';
                moveArray{end+1} = toAdd;
            end
            if x > 1 && y > 1
                toAdd = zeros(min(x-1,y-1),2);
                for i = 1:min(x-1,y-1)
                    toAdd(i,:) = [x-i,y-i];
                end
                moveArray{end+1}=toAdd;
            end
            if x > 1
                toAdd = zeros(x-1,2);
                toAdd(:,2) = y;
                toAdd(:,1) = [x-1:-1:1]';
                moveArray{end+1} = toAdd;
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
            sym = 'Q';
        end
    end
    
end

