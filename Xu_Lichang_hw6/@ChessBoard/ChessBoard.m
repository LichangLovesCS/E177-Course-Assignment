classdef ChessBoard < handle
    %CHESSBOARD Represents the state of a game of chess
    %   It has a property ActiveList that contains all of the active pieces
    %   It has three methods, described fully in details as the following:
    %   addPiece(board,piece) will place a given piece on the chessboard at
    %   a specific location.
    %   removePiece(board,piece) will remove a given piece off chessboard.
    %   This method will be used when a piece has been captured.
    %   checkPosition(board,position) will check if a specific position on
    %   the chessboard is occupied.
    
    properties
        ActiveList = {}; % A cell array that contains all of the active pieces
    end
    
    methods
        function addPiece(board,piece)
            % Place a given piece on the chessboard at a specific position
            % Your code here
            % Check if the position is already occupied
            [occupied,output_piece] = checkPosition(board,piece.Position);
            if(~occupied)
                % Add the piece to the list of active pieces
                board.ActiveList(numel(board.ActiveList)+1) = {piece};
            else
                error('Position is already occupied!');
            end    
        end
        
        function removePiece(board,piece)
            % Remove a given piece off the chessboard
            % Your code here
            % Check if the piece is in the list of active pieces  
            for i = 1:numel(board.ActiveList)
                if isequal(board.ActiveList{i}.Position,piece.Position)
                    % remove the piece from the board
                    board.ActiveList(i) = [];
                    break;
                end
            end
        end
        
        function [occupied, piece] = checkPosition(self,position)
            % Check if a specific position on the board is occupied
            % Your code here
            exist = 0;
            for i = 1:numel(self.ActiveList)
                if(isequal(self.ActiveList{i}.Position,position))
                    % Found a piece with given position
                    exist = 1;
                    occupied = 1; % return true for occupied
                    piece = self.ActiveList{i}; % return an empty array for piece
                end
            end
            % Did not find a piece with given position
            if(~exist)
                occupied = 0; % return false for occupied
                piece = [];
            end
        end
        
    end
    
end
