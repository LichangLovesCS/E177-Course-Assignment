classdef Pawn < ChessPiece
    %PAWN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        Direction
        Attack1
        Attack2
    end
    
    events
        ReachedBoardEdge
    end
    
    methods
    function pawn = Pawn(pos,team)
            pawn = pawn@ChessPiece(pos,team);
            initializeProperties(pawn,team);
        end
        
        function moveArray = getMoveArray(piece)
            moveArray = [];
        end
        
        function moves = getMoves(piece)
            moves = [];
            [occ,pc] = piece.Game.Board.checkPosition( ...
                piece.Position+piece.Direction);
            if ~occ ...
                    && all(piece.Position+piece.Direction <= piece.Game.Board.Size)...
                    && all(piece.Position+piece.Direction >= [1 1])
                moves(end+1,:) = [piece.Position+piece.Direction,false];
            end
            [occ,pc] = piece.Game.Board.checkPosition( ...
                piece.Position+piece.Attack1);
            if occ && pc.Team ~= piece.Team ...
                    && all(piece.Position+piece.Direction <= piece.Game.Board.Size)...
                    && all(piece.Position+piece.Direction >= [1 1])
                moves(end+1,:) = [piece.Position+piece.Attack1,true];
            end
            [occ,pc] = piece.Game.Board.checkPosition( ...
                piece.Position+piece.Attack2);
            if occ && pc.Team ~= piece.Team ...
                    && all(piece.Position+piece.Direction <= piece.Game.Board.Size)...
                    && all(piece.Position+piece.Direction >= [1 1])
                moves(end+1,:) = [piece.Position+piece.Attack2,true];
            end
        end
        
        function move(piece,newPosition)
            %TODO: call super class method
            %TODO: if reached board edge, notify
            % Hint: test if newPosition+Direction is off the board
            move@ChessPiece(piece,newPosition);
            direction = piece.Direction;
            sum_pos = newPosition + direction;
            if(sum_pos(2)<1)
                % trigger the ReachedBoardEdge event
                notify(piece,'ReachedBoardEdge');
            elseif(sum_pos(2)>8)
                % trigger the ReachedBoardEdge event
                notify(piece,'ReachedBoardEdge');
            end
        end
        
    end
    
    methods (Static)
        function sym = getSymbol()
            sym = 'P';
        end
    end
        
end

