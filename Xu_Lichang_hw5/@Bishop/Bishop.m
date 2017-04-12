classdef Bishop < ChessPiece
    %%BISHOP is a subclass of ChessPiece.
    %   It inherits all properties of its upperclass.
    %   It implements getSymbol(chesspiece) method specific to Bishop.
    %   It implements getMoveArray(chesspiece) method specific to Bishop.
    
    properties
    end
    
    methods
        function obj = Bishop(position,board,teamnumber)
            obj = obj@ChessPiece(position,board,teamnumber); % Call upperclass constructor
        end
        
        function move_array = getMoveArray(self)
            % Bishop can only move along its diagonals
            move_array = {};
            top_left = []; top_right = []; bot_left = []; bot_right = [];
            x_pos = self.Position(1);
            y_pos = self.Position(2);
            for i = 1:8
                for j = 1:8
                    % fill in left diagonals first
                    if((x_pos+y_pos)==(i+j))
                        if(i < x_pos)
                            bot_left = [i,j; bot_left]; % stack rows
                        elseif(i > x_pos)
                            top_left = [top_left; i,j]; % stack rows
                        end
                    % fill in right diagonals now
                    elseif((x_pos-y_pos)==(i-j))
                        if(i < x_pos)
                            bot_right = [i,j; bot_right]; % stack rows
                        elseif(i > x_pos)
                            top_right = [top_right; i,j]; % stack rows
                        end
                    end
                end
            end
            % add direction arrays into output cell array
            move_array{1} = top_left;
            move_array{2} = top_right;
            move_array{3} = bot_left;
            move_array{4} = bot_right;
            % delete any empty arrays
            move_array = move_array(~cellfun('isempty',move_array));
        end
    end
    
    methods(Static = true)
        function symbol = getSymbol()
            symbol = 'B';
        end
    end
    
end