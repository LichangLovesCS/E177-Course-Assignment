classdef ChessBoard < handle
    %CHESSBOARD Represents the board
    %   The Pieces property is a cell array that contains a cell array for
    %   each team.  These inner cell arrays hold the pieces for the given
    %   team.
    
    properties (SetAccess = private)
        Pieces = {}; %Cell array of teams, teams are cell arrays of pieces
        Size = [8 8];
    end
    
    methods
        function addPiece(board,piece)
            for i = 1:length(board.Pieces)
                team = board.Pieces{i};
                for j = 1:length(team)
                    pc = team{j};
                    if all(pc.Position == piece.Position)
                        error('There is a piece already in that position!');
                    end
                end
            end
            if length(board.Pieces) >= piece.Team
                board.Pieces{piece.Team}{end+1} = piece;
            else
                board.Pieces{piece.Team}={piece};
            end
            % Register a Listner for the piece's Death event
            lh = addlistener(piece,'Death',@board.removePiece); % removePiece as callback
        end
        
        function removePiece(board,piece,eventData)
            team = board.Pieces{piece.Team};
            for j = 1:length(team)
                pc = team{j};
                if pc == piece
                    team(j) = [];
                    break;
                end
            end
            board.Pieces{piece.Team} = team;
        end
        
        function [occupied, piece] = checkPosition(board,position)
            piece = [];
            occupied = false;
            for i = 1:length(board.Pieces)
                team = board.Pieces{i};
                for j = 1:length(team)
                    pc = team{j};
                    if all(position == pc.Position)
                        occupied = true;
                        piece = pc;
                        return;
                    end
                end
            end
        end
        
        function pawnToQueen(board,pawn,eventData)
            % a callback function for Queening
            % The method kills the pawn
            team = pawn.Team; position = pawn.Position; game = pawn.Game;
            pawn.die();
            % replace pawn with a new Queen at the same position
            queen = Queen(position,team);
            game.addPiece(queen);    
        end
        
    end
    
end

