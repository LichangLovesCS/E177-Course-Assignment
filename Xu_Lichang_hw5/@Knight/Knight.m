classdef Knight < ChessPiece
    %%PAWN is a subclass of ChessPiece.
    %   It inherits all properties of its upperclass.
    %   It implements getSymbol(chesspiece) method specific to Knight.
    %   It implements getMoveArray(chesspiece) method specific to Knight.
    
    properties
    end
    
    methods
        function obj = Knight(position,board,teamnumber)
            obj = obj@ChessPiece(position,board,teamnumber); % Call upperclass constructor
        end
        
        function move_array = getMoveArray(self)
            move_array = {};
            % initialize one-vertical-two-horizontal direction arrays
            one_v_top_left = []; one_v_top_right = []; one_v_bot_left = []; one_v_bot_right = [];
            % initialize one-horizontal-two-vertical direction arrays
            one_h_top_left = []; one_h_top_right = []; one_h_bot_left = []; one_h_bot_right = [];
            % obtain x and y coord
            x_pos = self.Position(1);
            y_pos = self.Position(2);
            % fill 1-v top_left direction arrays first
            if((x_pos-2) > 0 && (y_pos+1) < 9)
                one_v_top_left = [x_pos-2,y_pos+1];
            end
            % fill 1-v bot_left direction arrays now
            if((x_pos-2) > 0 && (y_pos-1) > 0)
                one_v_bot_left = [x_pos-2,y_pos-1];
            end
            % fill 1-v top_right direction arrays now
            if((x_pos+2) < 9 && (y_pos+1) < 9)
                one_v_top_right = [x_pos+2,y_pos+1];
            end
            % fill 1-v bot_right direction arrays now
            if((x_pos+2) < 9 && (y_pos-1) > 0)
                one_v_bot_right = [x_pos+2,y_pos-1];
            end
            % fill 1-h top_left direction array first
            if((x_pos-1) > 0 && (y_pos+2) < 9)
                one_h_top_left = [x_pos-1,y_pos+2];
            end
            % fill 1-h bot_left direction array now
            if((x_pos-1) > 0 && (y_pos-2) > 0)
                one_h_bot_left = [x_pos-1,y_pos-2];
            end
            % fill 1-h top_right direction array now
            if((x_pos+1) < 9 && (y_pos+2) < 9)
                one_h_top_right = [x_pos+1,y_pos+2];
            end
            % fill 1-h bot_right direction array now
            if((x_pos+1) < 9 && (y_pos-2) > 0)
                one_h_bot_right = [x_pos+1,y_pos-2];
            end
            % add direction arrays into output cell array
            move_array{1} = one_v_top_left;
            move_array{2} = one_v_top_right;
            move_array{3} = one_v_bot_left;
            move_array{4} = one_v_bot_right;
            move_array{5} = one_h_top_left;
            move_array{6} = one_h_top_right;
            move_array{7} = one_h_bot_left;
            move_array{8} = one_h_bot_right;
            % delete any empty double arrays if necessary
            move_array = move_array(~cellfun('isempty',move_array));
        end
    end
    
    methods(Static = true)
        function symbol = getSymbol()
            symbol = 'N';
        end
    end
    
end