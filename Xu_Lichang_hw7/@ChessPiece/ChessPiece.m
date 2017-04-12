classdef ChessPiece < handle
    %CHESSPIECE Abstract base class for chess pieces
    
    properties (SetAccess = private)
        Position
        Team
    end
    
    properties
        Game = [];
        % ChessPiece needs to know the ChessGame it is in, so that it can
        % know things like the size of the board and whether given squares
        % are occupied.
    end
    
    events
        Death; % this event gets trigged when the die method is called
    end
    
    methods
        function piece = ChessPiece(pos,team)
            piece.Position = pos;
            piece.Team = team;
        end
        
        function die(piece)
            %TODO add code
            % Trigger Death Event here
            notify(piece,'Death');
        end
        
        function move(piece,newPosition)
            moves = piece.getMoves();
            for i = 1:size(moves,1)
                row = moves(i,:);
                if all(row==[newPosition,false])
                    piece.Position = newPosition;
                    return;
                elseif all(row==[newPosition,true])
                    [occ,pc]=piece.Game.Board.checkPosition(newPosition);
                    pc.die();
                    piece.Position = newPosition;
                    return;
                end
            end
            error('Invalid move!');
        end
        
        function set.Game(piece,game)
            if isempty(piece.Game)
                piece.Game = game;
            else
                error('This piece already has a game!');
            end
        end
    end
    
    methods (Abstract)
        moveArray = getMoveArray(piece)
    end
    
    methods (Static, Abstract)
        sym = getSymbol()
    end
    
end

