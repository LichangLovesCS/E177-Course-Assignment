classdef ChessGame < handle
    %CHESSGAME A class for playing and replaying chess games
    %   Create an instance and use the PLAY() or PLAYUI methods to play manually,
    %   or use the static method REPLAY() to replay a previous game.
    %   See the help for each method (e.g., "help ChessGame.play")
    %   for details.
    
    
    properties (Access = private, Hidden = true)
        KingList = {}; %index is team.  Note that if a team doesn't have a king, that position will be empty
        Figure;
    end
    
    properties (SetAccess = private)
        Board;
        Playing = []; %empty or 0 if not playing, otherwise the team currently moving.
        Directions = [];
        NumTeams = 0;
    end
    
    methods
        function game = ChessGame()
            game.Board = ChessBoard();
        end
        
        function addPiece(game,piece)
            % if piece is a Pawn, register a listener for the
            % ReachedBoardEdge Event
            sym = piece.getSymbol();
            if(isequal(sym,'P'))
                % pawnToQueen as callback
                board = game.Board;
                lh = addlistener(piece,'ReachedBoardEdge',@board.pawnToQueen);
            end
            if piece.Team > game.NumTeams
                if piece.Team > game.NumTeams + 1
                    error(['Must add pieces for team ',...
                        num2str(game.NumTeams + 1), ' first!']);
                else
                    game.NumTeams = piece.Team;
                end
            end
            
            if isa(piece,'King')
                game.addKing(piece);
            end
            
            game.Board.addPiece(piece);
            piece.Game = game;
        end
        
        function directions = play(game)
            %DIRECTIONS = PLAY(GAME) play() allows you play a chess game manually
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
                    game.Board = ChessBoard();
                    game.NumTeams = 0;
                    game.KingList = {};
                end
                game.Directions = [];
                game.initializeBoard();
                game.Playing = 1;
            end
            if length(game.KingList) < 1
                error('Not enough kings!');
            end
            bd = game.Board;
            display(bd);
            while game.Playing ~= 0
                team = game.Playing;
                disp('');
                disp(['Team ' num2str(team) '''s turn']);
                disp('Pick a piece to move');
                pieces = bd.Pieces{team};
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
                    [occ,pc] = game.Board.checkPosition(in);
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
                    [occ,piece] = game.Board.checkPosition(kills(i,:));
                    disp([piece.getSymbol()...
                            ' at ' num2str(piece.Position(1))...
                            ',' num2str(piece.Position(2))]);
                end
                move = input('Enter move (in square brackets): ');
                if move == -1
                    directions = game.Directions;
                    return;
                end
                game.Directions(end+1,:) = [selected.Position move];
                game.Playing = mod(game.Playing,game.NumTeams)+1;
                selected.move(move);
                display(game.Board);
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
    
    methods(Access = private, Hidden = true)
        function addKing(game,king)
            %TODO: add code
            % note: you must check if the team already has a king, and give
            % an error if it does
            % add to the KingList
            if(numel(game.KingList) == 0)
                if(king.Team == 1)
                    game.KingList{1} = king;
                elseif(king.Team == 2)
                    game.KingList{2} = king;
                end
            elseif(numel(game.KingList) == 1)
                if((king.Team == 1))
                    error('The team already has a king!');
                elseif((king.Team == 2))
                    game.KingList{2} = king;
                end
            elseif(numel(game.KingList) == 2)
                if((king.Team == 1)&&(isempty(game.KingList{1})))
                    game.KingList{1} = king;
                elseif((king.Team == 2)&&(isempty(game.KingList{2})))
                    game.KingList{2} = king;
                else
                    error('The team already has a king!');
                end
            end
            % register a listener for the king's Death event
            lh = addlistener(king,'Death',@game.checkmate); % checkmate method as callback
        end
        
        function checkmate(game,king,eventData)
            disp(['Game over! Team ' num2str(king.Team) ' loses!']);
            game.Playing = 0;
        end
    end
    
    methods (Access = private, Hidden = true)
        function initializeBoard(game)
            game.addPiece(King([5 1],1));
            game.addPiece(Queen([4 1],1));
            game.addPiece(Bishop([3 1],1));
            game.addPiece(Bishop([6 1],1));
            game.addPiece(Knight([2 1],1));
            game.addPiece(Knight([7 1],1));
            game.addPiece(Rook([1 1],1));
            game.addPiece(Rook([8 1],1));
            for i = 1:8
                game.addPiece(Pawn([i 2],1));
            end
            game.addPiece(King([5 8],2));
            game.addPiece(Queen([4 8],2));
            game.addPiece(Bishop([3 8],2));
            game.addPiece(Bishop([6 8],2));
            game.addPiece(Knight([2 8],2));
            game.addPiece(Knight([7 8],2));
            game.addPiece(Rook([1 8],2));
            game.addPiece(Rook([8 8],2));
            for i = 1:8
                game.addPiece(Pawn([i 7],2));
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

