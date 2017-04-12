classdef Rook < ChessPiece
    %%ROOk is a subclass of ChessPiece.
    %   It inherits all properties of its upperclass.
    %   It implements getSymbol(chesspiece) method specific to Rook.
    %   It implements getMoveArray(chesspiece) method specific to Rook.
    
    properties
    end
    
    methods
        function obj = Rook(position,board,teamnumber)
            obj = obj@ChessPiece(position,board,teamnumber); % Call upperclass constructor
        end
        
        function move_array = getMoveArray(self)
            move_array = {};
            top_dir = []; down_dir = []; left_dir = []; right_dir = [];
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
                if(j > y_pos) % fill in top array first
                    top_dir = [top_dir; x_pos,j]; % stack rows
                elseif(j < y_pos) % fill in down array now
                    down_dir = [x_pos,j; down_dir]; % stack rows
                end
            end
            % add direction arrays into output cell array
            move_array{1} = right_dir;
            move_array{2} = left_dir;
            move_array{3} = top_dir;
            move_array{4} = down_dir;
            % delete any empty double arrays if necessary
            move_array = move_array(~cellfun('isempty',move_array));
        end                       
    end
    
    methods(Static = true)
        function symbol = getSymbol()
            symbol = 'R';
        end
    end
    
end