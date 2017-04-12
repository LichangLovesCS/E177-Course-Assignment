%% Set the corresponding row, coln, diagonal of a queen to be invalid.
% @First input: the original 8*8 board logical array.
% @Second input: a given board coordinate (x,y) of the queen.
% @Output: the updated 8*8 board array with invalid squares set to 0.
function updated_board = set_queen(board,x,y)
    updated_board = board; % copy over original board
    updated_board(x,:) = 0; % set all row to be invalid
    updated_board(:,y) = 0; % set all coln to be invalid
    if(x==1 && y==1) % upper left corner
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c+1;
        end
    elseif(x==1 && y==8) % upper right corner
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c-1;
        end
    elseif(x==8 && y==1) % lower left corner
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c+1;
        end
    elseif(x==8 && y==8) % lower right corner
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c-1;
        end
    elseif(x==1 && y>1 && y<8) % first row
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c-1;
        end
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c+1;
        end
    elseif(x==8 && y>1 && y<8) % last row
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c-1;
        end
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c+1;
        end
    elseif(y==1 && x>1 && x<8) % first coln
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c+1;
        end
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c+1;
        end
    elseif(y==8 && x>1 && x<8) % last coln
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c-1;
        end
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c-1;
        end
    else % middle squares
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c-1;
        end
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c+1;
        end
        r=x; c=y; % copy over original coordinates
        while(r<=8 && c>=1) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r+1; c=c-1;
        end
        r=x; c=y; % copy over original coordinates
        while(r>=1 && c<=8) % set diagonals to be invalid
            updated_board(r,c) = 0;
            r=r-1; c=c+1;
        end
    end
end