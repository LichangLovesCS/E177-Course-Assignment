classdef ChessGame < handle
    %CHESSGAME A class for playing and replaying chess games
    %   Create an instance and use the PLAY() method to play manually,
    %   or use the static method REPLAY() to replay a previous game.
    %   See the help for each method (e.g., "help ChessGame.play")
    %   for details.
    %   Updated Febuary 13, 2015 by Daniel Driver
    %   Fixed Bug in play method so games ends at checkmate
    %   Added output of game to replay and put more data in
    %   game object so can resume game
	%   Update Febuary 20, 2015 by Daniel Driver
    %   Bug with Direction be added for invalid move fixed
    
    properties (Access = private, Hidden = true)
        Board
        KingList = {}
        Playing = []
    end
    
    properties
        Directions = []
    end
    
    methods
        function game = ChessGame()
            game.Board = ChessBoard();
            game.initializeBoard();
        end
        
        function directions = play(game)
            %DIRECTIONS = PLAY(GAME) play() allows you play a chess game
            %manually
            %   If a new game is already in progress, PLAY will continue
            %   it.  Otherwise, it starts a new game.  Team 1 goes first.
            %   It will first display a numbered list of the pieces that 
            %   are available to move along with their current position.
            %   You can enter the piece number, or the position as a 1x2
            %   array (remember the square brackets!).  Once you have
            %   selected a piece, it will display the positions it can move
            %   to and the pieces it can capture.  Enter the position to
            %   move to in square brackets.
            %
            %   The game does not detect checks or checkmates.  Therefore,
            %   it is necessary to actually capture the king to win.  Once
            %   this happens, the game is over.
            %
            %   At any prompt, you can enter -1 to exit the game.  The
            %   state of the game is saved.  The method returns an array of
            %   moves that can be used with the replay method.
            if isempty(game.Playing) || game.Playing == 0
                if game.Playing == 0
                    disp('Game has ended. Resetting board.');
                end
                game.Directions = [];
                game.Board = ChessBoard();
                game.initializeBoard();
                game.Playing = 1;
            end
            bd = game.Board;
            display(bd);
            while game.Playing ~= 0 
                team = game.Playing;
                disp('');
                disp(['Team ' num2str(team) '''s turn']);
                disp('Pick a piece to move');
                pieces = {};
                for y = 1:8
                    for x = 1:8
                        [occ pc] = bd.checkPosition([x y]);
                        if occ && pc.Team == team
                            pieces{end+1} = pc;
                        end
                    end
                end
                for i = 1:length(pieces)
                    piece = pieces{i};
                    if ~isempty(piece.getMoves())
                        disp([num2str(i,'%02u') ': ' piece.getSymbol()...
                            ' at ' num2str(piece.Position(1))...
                            ',' num2str(piece.Position(2))]);
                    end
                end
                in = input('Enter piece number or position (in square brackets): ');
                if in == -1
                    directions = game.Directions;
                    return;
                end
                if length(in) == 2
                    [~,pc] = game.Board.checkPosition(in);
                    if ~isempty(pc) && pc.Team == team
                        selected = pc;
                    else
                        error('Invalid position');
                    end
                else
                    selected = pieces{in};
                end
                allMoves = selected.getMoves();
                moves = [];
                kills = [];
                for i = 1:size(allMoves)
                    move = allMoves(i,:);
                    if move(3) == 0
                        moves(end+1,:) = move(1:2);
                    else
                        kills(end+1,:) = move(1:2);
                    end
                end
                disp('Moves:');
                for i = 1:size(moves,1)
                    disp([num2str(moves(i,1))...
                            ',' num2str(moves(i,2))]);
                end
                disp('Attack moves:');
                for i = 1:size(kills,1)
                    [~,piece] = game.Board.checkPosition(kills(i,:));
                    disp([piece.getSymbol()...
                            ' at ' num2str(piece.Position(1))...
                            ',' num2str(piece.Position(2))]);
                end
                move = input('Enter move (in square brackets): ');
                if move == -1
                    directions = game.Directions;
                    return;
                end
                
                PreviousPosition=selected.Position;
                selected.move(move);
                game.Directions(end+1,:) = [PreviousPosition move];
                
                display(game.Board);
                %Added logic so if checkmate called via a move the kills a 
                %King changes Game.Playine to 0 it is not undone and the
                %game can end
                if game.Playing~=0
                    game.Playing = mod(game.Playing,length(game.KingList))+1;
                end
            end
            directions = game.Directions;
        end
        
        function display(game)
            if isempty(game.Playing) || game.Playing == 0
                disp('This game is not currently active');
            else
                disp(['Team ' num2str(game.Playing) ' is playing next']);
            end
            if ~isempty(game.Directions)
                disp([num2str(size(game.Directions,1))...
                    ' moves have been made already']);
            end
        end
        
    end
    
    methods(Hidden = true)
        
        function addKing(game,king)
            if king.Team <= length(game.KingList) ...
                    && ~isempty(game.KingList{king.Team})
                error('That team already has a king!');
            else
                game.KingList{king.Team} = king;
            end
        end
        
        function checkmate(game,king)
            disp(['Game over! Team ' num2str(king.Team) ' loses!']);
            game.Playing = 0;
        end
        
        
    end
    methods (Access = private, Hidden = true)
        function initializeBoard(game)
            bd = game.Board;
            game.KingList = {};
            Rook([1 1],bd,1);
            Knight([2 1],bd,1);
            Bishop([3 1],bd,1);
            Queen([4 1],bd,1);
            King([5 1],bd,1,game);
            Bishop([6 1],bd,1);
            Knight([7 1],bd,1);
            Rook([8 1],bd,1);
            for i = 1:8
                Pawn([i 2],bd,1);
            end
            Rook([1 8],bd,2);
            Knight([2 8],bd,2);
            Bishop([3 8],bd,2);
            Queen([4 8],bd,2);
            King([5 8],bd,2,game);
            Bishop([6 8],bd,2);
            Knight([7 8],bd,2);
            Rook([8 8],bd,2);
            for i = 1:8
                Pawn([i 7],bd,2);
            end
        end
        
        
        
        
    end
    
    methods (Static)
        function game=replay(directions)
            %REPLAY(DIRECTIONS) Replays a saved chess game.
            %   This is a static method, so it is called using 
            %   ChessGame.replay(directions).  You don't need to create an
            %   instance of the game to play it.  You can use as input a 4
            %   column array of from-position to-position moves.  They must
            %   be valid, or you will get errors.  You can use the output
            %   of the PLAY() method, or either of the arrays in games.mat.
            
            %do a little check of 
            if (isnumeric(directions)) && (size(directions,2)==4) && (length(size(directions))==2)
            else
                error('For one input should be an Nx4 double or int array Array')
            end
            
            %Set Game properties
            game = ChessGame();
            game.Board = ChessBoard();
            game.initializeBoard();
            %calculated who the next player should be and set
            game.Playing=mod(size(directions,1),length(game.KingList))+1;
            %put directions in game property
            game.Directions=directions; 
            bd = game.Board;
            display(bd);
            pause(.5);
            
            %Move Pieces according to directions
            for i = 1:size(directions,1)
                move = directions(i,:);
                [~, pc] = bd.checkPosition(move(1:2));
                pc.move(move(3:4));
                display(bd);
                pause(.5);
            end
        end
    end
end
