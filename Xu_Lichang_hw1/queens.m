%% Author: Lichang Xu
% The function returns all the possible solutions to eight-queen problem.
% The implementation uses backtracking techniques for pruning.
% It starts from the upper left position and tries to put each queen
% respectively so that it will not attack previous queen positions.
% When a dead end is hit, the program backtracks to the previous setting to
% consider other possibilities. In this way, the program will avoid many
% obviously impossible combinations, significantly reduicing the overall
% runtime. For more details, consult the wiki page:
% https://en.wikipedia.org/wiki/Eight_queens_puzzle
% Pseudocode can be found in the provided homework handout.
% @Input: N/A
% @Output: a 8*8*N logical array where N is the number of solutions.
function mat_soln = queens()
    cur_board = ones(8,8); % Initialize the current chess board
    prev_board = ones(8,8); % Initialize the previous chess board before update
    comp_board = zeros(8,8); % Initialize the comparison board
    queen_board = zeros(8,8); % Initialize the postion of each queen board
    soln_array = zeros(8,8,92); % Initialize the solution array
    N = 0; % Initilize total number of valid solutions 
    row = 1; 
    mat_soln = logical(put_queen(row,cur_board,prev_board,comp_board,queen_board)); % convert to logical type
    function soln = put_queen(row,cur_board,prev_board,comp_board,queen_board) % a nested function to find each soln
        for coln = 1:8 % for every position coln on the same row
            if(cur_board(row,coln)==1)
                prev_board = cur_board; % save before update
                cur_board = set_queen(cur_board,row,coln); % place the queen
                queen_board(row,coln) = 1; % update the position of the queen
                comp_board = (prev_board~=cur_board); 
                if(row < 8)
                    put_queen(row+1,cur_board,prev_board,comp_board,queen_board); % recursively put another queen
                    cur_board = cur_board + comp_board; % remove the queen and reset the board
                    queen_board(row,coln) = 0; % update the position of each queen
                else
                    N = N+1; % found a sucessful solution
                    soln_array(:,:,N) = queen_board; % Fill in a solution
                end
            end
        end
        soln = soln_array;
    end
end
                    
                