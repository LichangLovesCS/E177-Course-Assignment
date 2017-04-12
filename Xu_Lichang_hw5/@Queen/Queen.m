classdef Queen < ChessPiece
    %%QUEEN is a subclass of ChessPiece.
    %   It inherits all properties of its upperclass.
    %   It implements getSymbol(chesspiece) method specific to Queen.
    %   It implements getMoveArray(chesspiece) method specific to Queen.
    
    properties
    end
    
    methods
        function obj = Queen(position,board,teamnumber)
            obj = obj@ChessPiece(position,board,teamnumber); % Call upperclass constructor
        end
            
        function move_array = getMoveArray(self)
            move_array = {};
            % initialize horizontal and vertical arrays
            right_dir = []; left_dir = []; top_dir = []; down_dir = [];
            % initialize diagonal arrays
            top_left = []; top_right = []; bot_left = []; bot_right = [];
            % obtain x and y coord
            x_pos = self.Position(1);
            y_pos = self.Position(2);
            % fill horizontal arrays first
            for i = 1:8
                if(i < x_pos) % fill in left array first
                    left_dir = [i,y_pos; left_dir]; % stack rows
                elseif(i > x_pos) % fill in right array now
                    right_dir = [right_dir; i,y_pos]; % stack rows
                end
            end
            % fill vertical arrays now
            for j = 1:8
                if(j < y_pos) % fill in down array first
                    down_dir = [x_pos,j; down_dir]; % stack rows
                elseif(j > y_pos) % fill in down array now
                    top_dir = [top_dir; x_pos,j]; % stack rows
                end
            end
            % fill diagonal arrays now
            for i = 1:8
                for j = 1:8
                    if((x_pos+y_pos)==(i+j)) % fill in left diagonal first
                        if(i < x_pos)
                            bot_left = [i,j; bot_left]; % stack rows
                        elseif(i > x_pos)
                            top_left = [top_left; i,j]; % stack rows
                        end
                    elseif((x_pos-y_pos)==(i-j)) % fill in right diagonal now
                        if(i < x_pos)
                            bot_right = [i,j; bot_right]; % stack rows
                        elseif(i > x_pos)
                            top_right = [top_right; i,j]; % stack rows
                        end
                    end
                end
            end
            % add direction arrays into output cell array
            move_array{1} = right_dir;
            move_array{2} = left_dir;
            move_array{3} = top_dir;
            move_array{4} = down_dir;
            move_array{5} = top_right;
            move_array{6} = top_left;
            move_array{7} = bot_right;
            move_array{8} = bot_left;
            % delete any empty double arrays if necessary
            move_array = move_array(~cellfun('isempty',move_array));
        end         
    end
    
    methods(Static = true)
        function symbol = getSymbol()
            symbol = 'Q';
        end
    end
    
end