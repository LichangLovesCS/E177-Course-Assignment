classdef (Abstract) ChessPiece < handle
    %%CHESSPIECE is an abstract handle class.
    %   It holds methods and properties common to each of the chess pieces.
    %   It has two properties as described in the following:
    %   Position is a 1x2 double array of the x and y coordinates
    %   Team is either 1 or 2 for which team the piece belongs to
    %   It has three concrete methods as described in the following:
    %   die(chesspiece) is called when the piece is captured. It removes
    %   the piece from the ChessBoard it is active in.
    %   getMoves(chesspiece) outputs a 3-column array of possible moves.
    %   The first two columns are x and y coordinates of the possible move,
    %   and the third column is 1 if this is an attack move or 0 if the
    %   position is unoccupied.
    %   move(chesspiece,position) checks if the given position is valid and
    %   if so, will update the Position property of the ChessPiece.
    %   It has two abstract methods described in the following:
    %   getSymbol(chesspiece) is an abstract method that returns the symbol
    %   (a single uppercase character) of the given chess piece.
    %   getMoveArray(chesspiece) is an abstract method that outputs a cell
    %   array which contains a double array of positions along a number of
    %   directions the chesspiece can move in. If a direction has no
    %   possible moves, that direction should not be included in the cell
    %   array. In other words, the cell array should never contain empty
    %   double arrays.
    
    properties 
        Position = []; % a 1x2 double array of the x and y coordinates
        Team; % should be either 1 or 2 for which team the piece belongs to
        Board; % store the ChessBoard that the piece is active in
    end
    
    methods
        function obj = ChessPiece(position,board,teamnumber) % Constructor
            % Set properties
            obj.Position = position;
            obj.Team = teamnumber;
            obj.Board = board;
            % Add the piece to the chessboard
            obj.Board.addPiece(obj);
        end
        
        function die(self) % remove the ChessPiece from the ChessBoard
            self.Board.removePiece(self); % remove the given piece off the board
        end
        
        function move(self,position) % update the Position property of the piece
            % check if the input position is valid
            if((~isa(position,'double')) || (numel(position) ~= 2))
                error('position must be a 1x2 double array.');
            end
            % compare against the output array of getMoves
            moves = self.getMoves();
            num_rows = size(moves,1); % number of rows of valid move array
            for i=1:num_rows
                if(isequal(moves(i,1:2),position))
                    % check if the move is an attack move
                    if(moves(i,3))
                        % find the piece occupying that position
                        for j=1:numel(self.Board.ActiveList)
                            dummy_piece = self.Board.ActiveList{j};
                            if(isequal(dummy_piece.Position,position))
                                % remove the occupying piece
                                dummy_piece.die();
                                break;
                            end
                        end
                    end
                    % update the Position property of the input piece
                    self.Position = position;
                    break;
                end
            end
        end
        
    end
    
    methods(Abstract = true)
        move_array = getMoveArray(chesspiece); % an abstract method needed to implement 
    end
    
    methods(Abstract = true, Static = true)
        symbol = getSymbol(); % an abstract and static method needed to implement
    end
        
        
end
        