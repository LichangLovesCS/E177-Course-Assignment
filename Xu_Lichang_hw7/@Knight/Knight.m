classdef Knight < ChessPiece
    %KNIGHT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function knight = Knight(pos,team)
            knight = knight@ChessPiece(pos,team);
        end
        
        function moveArray = getMoveArray(piece)
            pos = piece.Position;
            x = pos(1);
            y = pos(2);
            moveArray = {};
            ctr = 1;
            for i = [1 -1]
                for j = [2 -2]
                    toAdd = [x+i, y+j];
                    if all([toAdd>=1 toAdd<=8])
                        moveArray{ctr} = toAdd;
                        ctr = ctr + 1;
                    end
                end
            end
            for i = [2 -2]
                for j = [1 -1]
                    toAdd = [x+i, y+j];
                    if all([toAdd>=1 toAdd<=8])
                        moveArray{ctr} = toAdd;
                        ctr = ctr + 1;
                    end
                end
            end
        end
    end
    
    methods (Static)        
        function sym = getSymbol()
            sym = 'N';
        end
    end
    
end

