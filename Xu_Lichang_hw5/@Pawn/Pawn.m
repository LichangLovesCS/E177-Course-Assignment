classdef Pawn < ChessPiece
    %%PAWN is a subclass of ChessPiece.
    %   It inherits all properties of its upperclass.
    %   It implements getSymbol(chesspiece) method specific to Pawn.
    %   It overrides getMoves(chesspiece) method since moves do not fit
    %   within the framework used by the superclass. The method checks if
    %   position+Direction is occupied, and also if Position+Attack1 and/or
    %   position+Attack2 are occupied by pieces of the opposing team. It
    %   will return an appropriate 3-column array that fits the contract
    %   established by ChessPiece. 
    %   getMoveArray(chesspiece) method is not used for Pawn but it still
    %   needs to be explicitly defined for Pawn to be a concrete subclass.
    %   In this case, it will simply return an empty array.
    
    properties
        Direction = []; % a 1x2 double array - potential move position
        Attack1 = []; % a 1x2 double array - potential attack position
        Attack2 = []; % a 1x2 double array - potential attack position
    end
    
    methods
        function obj = Pawn(position,board,teamnumber)
            obj = obj@ChessPiece(position,board,teamnumber); % Call superclass constructor
            initializeProperties(obj,teamnumber) % set pawn properties
        end
            
        function move_array = getMoveArray(chesspiece)
            move_array = [];
        end
        
        function moves = getMoves(self)
            occupied = 1;
            moves = []; % a 3-column array with x and y coord and an attacker indicator
            for i = 1:numel(self.Board.ActiveList)
                % Check if position+Direction is occupied
                dummy_piece = self.Board.ActiveList{i};
                if(isequal(dummy_piece,self.Position+self.Direction))
                    occupied = 0;
                end
                % Check if position+Attack1 is occupied
                if(isequal(dummy_piece.Position,self.Position+self.Attack1))
                    moves = [moves; [self.Position+self.Attack1,1]]; % the third entry should be 1; stack rows
                end
                % Check if position+Attack2 is occupied
                if(isequal(dummy_piece.Position,self.Position+self.Attack2))
                    moves = [moves; [self.Position+self.Attack2,1]]; % the third entry should be 1; stack rows
                end
            end
            if(occupied)
                moves = [moves; [self.Position+self.Direction,0]]; % the third entry should be 0
            end    
        end
    end
    
    methods(Static = true)
        function symbol = getSymbol()
            symbol = 'P';
        end
    end
    
end