function playui(game)
%PLAYUI Summary of this function goes here:
%   playui(game) will create a programmatic GUi that allows users to add
%   chess pieces to the board before he or she starts the game instead of
%   using the normal chess setup. 

%   Detailed explanation goes here:
%   The GUI contains two panels, each of 50% width of the figure. The left
%   panel contains an axes object for the board to display on. The right
%   panel contains nine elements. There are two static text labels, one
%   pop-up menu, one edit text box, a radio button group with two radio
%   buttons, and two push buttons. The pop-up munu for the piece contains
%   the full names of the pieces. The position text box takes a string
%   array with the format "[X,Y]." 
%   After the user clicks on the submit button, appropriate piece will be
%   added to the chessboard and the board on the figure will update
%   accordingly. 
%   After the user clicks on the play button, the board figure will be
%   centralized (it will take up the entire figure) and normal game play
%   will commence. If the GUI play button is pressed and each team does not
%   have a king, the game will generate an error. If no pieces have been
%   added, a standard game should be initialized and play begun. 

if isempty(game.Playing) || game.Playing == 0
    if game.Playing == 0
        disp('Game has ended. Resetting board.');
    end
    game.Directions = [];
    game.Board = ChessBoard();
    game.KingList = {};
    piece_counter = 0;
    game.Playing = 1;
    bd = game.Board;

    % initialize ui
    if isempty(game.Figure)
        game.Figure = figure('Name','Chess game');
    end
    fpos = get(game.Figure,'Position');
    set(game.Figure,'Position',[fpos(1:2),560,300]);


    % Fill in the code to assign to the following variables:
    
    boardPanel = uipanel('Parent',game.Figure,'Units','Normalized',...
        'Position',[0,0,0.5,1]); % the left panel
    boardAxes = axes('Parent',boardPanel); % the axes for the board display
    buttonPanel = uipanel('Parent',game.Figure,'Units','Normalized',...
        'Position',[0.5,0,0.5,1]); % the panel for the buttons

    pieceText = uicontrol('Parent',buttonPanel,'Units','Normalized',...
        'HorizontalAlignment','Center','Position',[0.35,0.86,0.3,0.1],...
        'Style','text','String','Select a piece'); % the text above the piece menu
    pieceMenu = uicontrol('Parent',buttonPanel,'Units','normalized',...
        'Position',[0.35,0.80,0.3,0.1],'Style','popup','String',...
        {'Bishop','King','Knight','Pawn','Queen','Rook'}); % the piece menu
    
    positionText = uicontrol('Parent',buttonPanel,'Units','Normalized',...
        'Position',[0.35,0.68,0.25,0.12],'Style','text','String','Enter a position'); % the text above the position box
    positionEdit = uicontrol('Parent',buttonPanel,'Units','Normalized',...
        'Position',[0.36,0.62,0.25,0.09],'Style','edit'); % the position box
    
    teamGroup = uibuttongroup(buttonPanel,'Units','Normalized',...
        'Position',[0.32,0.34,0.38,0.26],'Title','Select a team'); % the radio button group for team selection
    teamButtons{1} = uicontrol('Parent',teamGroup,'Units','Normalized',...
        'Position',[0.15,0.6,0.7,0.3],'Style','radiobutton',...
        'String','Team 1'); % team 1 radio button
    teamButtons{2} = uicontrol('Parent',teamGroup,'Units','Normalized',...
        'Position',[0.15,0.21,0.7,0.3],'Style','radiobutton',...
        'String','Team 2'); % team 2 radio button

    submitButton = uicontrol(buttonPanel,'Units','Normalized',...
        'Position',[0.34,0.19,0.3,0.1],'Style','push','String','submit',...
        'Callback',@submit_callback); % the submit button

    playButton = uicontrol(buttonPanel,'Units','Normalized',...
        'Position',[0.34,0.09,0.3,0.1],'Style','push','String','Play',...
        'Callback',@play_callback); % the play button
    
    % put in code here to display the board
    display(bd,boardAxes);
    
else
    game.play();
end

    function submit_callback(hObject,eventdata)
        team = [];
        for i = 1:length(teamButtons)
            teamButton = teamButtons{i};
            if get(teamButton,'Value')==1
                team = i; %team is a double
                break;
            end
        end
        if isempty(team)
            error('No team selected!');
        end
        pcs = get(pieceMenu,'String');
        
        position = str2num(get(positionEdit,'String')); %1x2 double array
        piece = pcs{get(pieceMenu,'Value')}; %string of piece name
        
        % put in code here to create the appropriate piece
        if(isequal(piece,'King'))
            king = King(position,bd,team,game);
        elseif(isequal(piece,'Bishop'))
            bishop = Bishop(position,bd,team);
        elseif(isequal(piece,'Knight'))
            knight = Knight(position,bd,team);
        elseif(isequal(piece,'Pawn'))
            pawn = Pawn(position,bd,team);
        elseif(isequal(piece,'Queen'))
            queen = Queen(position,bd,team);
        elseif(isequal(piece,'Rook'))
            rook = Rook(position,bd,team);
        else
            error('Piece does not exist!');   
        end
        % update the piece counter
        piece_counter = piece_counter + 1;      
        % put in code here to update the display of the board
        display(bd,boardAxes);
    end

    function play_callback(hObject,eventdata)
        % if no pieces have been added, a standard Game will be initialized
        if(~piece_counter)
            initializeBoard(game);
        end
        % error if each team does not have a king
        if((numel(game.KingList) ~= 2)||(game.KingList{1}.Team == game.KingList{2}.Team))
            error('Each team must have a king!');
        end
        % visualize and center the figure's left panel
        set(buttonPanel,'visible','off');
        set(game.Figure,'position',[fpos(1:2),560,560]);
        set(boardPanel,'position',[0,0,1,1]);
        % call the play method here
        game.play();
    end

end
