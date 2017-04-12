classdef King < ChessPiece
    %%KING is a subclass of ChessPiece.
    %   It inherits all properties of its upperclass.
    %   It implements getSymbol(chesspiece) method specific to King.
    %   It has a different constructor from its upperclass.
    %   It implements getMoveArray(chesspiece) method specific to King.
    %   It overrides the die(chesspiece) method to take care of checkmate.
    
    properties
        Game; % store the ChessGame the king is part of
    end
    
    methods
        function obj = King(position,board,teamnumber,chessgame) % Different constructor
            obj = obj@ChessPiece(position,board,teamnumber); % call superclass constructor
            obj.Game = chessgame; % set Game property
            obj.Game.addKing(obj);
        end
        
        function die(self)
            self.Board.removePiece(self);
            self.Game.checkmate(self);
        end
        
        function move_array = getMoveArray(self)
            % King can move only one space but in any direction
            move_array = {};
            % initialize horizontal and vertical direction arrays
            left = []; right = []; top = []; bot = [];
            % initialize diagonal direction arrays
            top_left = []; top_right = []; bot_left = []; bot_right = [];
            % obtain x and y coord
            x_pos = self.Position(1); 
            y_pos = self.Position(2);
            % add left space first
            if((x_pos-1) > 0)
                left = [x_pos-1,y_pos];
            end
            % add right space now
            if((x_pos+1) < 9)
                right = [x_pos+1,y_pos];
            end
            % add bottom space now
            if((y_pos-1) > 0)
                bot = [x_pos,y_pos-1];
            end
            % add top space now
            if((y_pos+1) < 9)
                top = [x_pos,y_pos+1];
            end
            % add top_left space now
            if((x_pos-1) > 0 && (y_pos+1) < 9)
                top_left = [x_pos-1,y_pos+1];
            end
            % add bot_left space now
            if((x_pos-1) > 0 && (y_pos-1) > 0)
                bot_left = [x_pos-1,y_pos-1];
            end
            % add top_right space now
            if((x_pos+1) < 9 && (y_pos+1) < 9)
                top_right = [x_pos+1,y_pos+1];
            end
            % add bot_right space now
            if((x_pos+1) < 9 && (y_pos-1) > 0)
                bot_right = [x_pos+1,y_pos-1];
            end
            % add direction arrays into output cell array
            move_array{1} = left;
            move_array{2} = right;
            move_array{3} = top;
            move_array{4} = bot;
            move_array{5} = top_right;
            move_array{6} = bot_right;
            move_array{7} = top_left;
            move_array{8} = bot_left;
            % delete any empty double arrays if necessary
            move_array = move_array(~cellfun('isempty',move_array));
        end
                
    end
    
    methods(Static = true)
        function symbol = getSymbol()
            symbol = 'K';
        end
    end
    
end