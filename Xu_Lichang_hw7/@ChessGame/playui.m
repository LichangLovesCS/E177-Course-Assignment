function playui(game)
%PLAYUI Manually set up the board and then play the game
%   See help for PLAY method for details on how to play the game

if isempty(game.Playing) || game.Playing == 0
    if game.Playing == 0
        disp('Game has ended. Resetting board.');
        game.Board = ChessBoard();
        game.NumTeams = 0;
        game.KingList = {};
    end
    game.Directions = [];
    game.Playing = 1;

    bd = game.Board;
    
    %initialize ui
    if isempty(game.Figure)
        game.Figure = figure('Name','Chess game');
    end
    fpos = get(game.Figure,'Position');
    set(game.Figure,'Position',[fpos(1:2),560,300]);

    boardPanel = uipanel('Parent',game.Figure,'Position',[0,0,.5,1]);
    boardAxes = axes('Parent',boardPanel);
    buttonPanel = uipanel('Parent',game.Figure,'Position',[.5,0,.5,1]);

    pieceText = uicontrol(buttonPanel,'Style','text',...
        'String','Select a piece',...
        'Units','normalized',...
        'Position',[0,.85,1,.1]);
    pieceMenu = uicontrol(buttonPanel,'Style','popupmenu',...
        'String',{'Pawn','Rook','Bishop','Knight','Queen','King'},...
        'Value',1,...
        'BackgroundColor','white',...
        'Units','normalized',...
        'Position',[.36,.8,.3,.1]);
    
    positionText = uicontrol(buttonPanel,'Style','text',...
        'String','Enter a position',...
        'Units','normalized',...
        'Position',[0,.68,1,.1]);
    positionEdit = uicontrol(buttonPanel,'Style','edit',...
        'Max',1,'Min',1,...
        'BackgroundColor','white',...
        'Units','normalized',...
        'Position',[.35,.66,.3,.07]);
    
    teamGroup = uibuttongroup('Parent',buttonPanel,...
        'Title','Select a team',...
        'Units','normalized',...
        'Position',[.3,.36,.4,.25]);
    teamButtons{1} = uicontrol(teamGroup,'Style','radiobutton',...
        'String','Team 1',...
        'Value',0,...
        'Position',[15,40,80,14]);
    teamButtons{2} = uicontrol(teamGroup,'Style','radiobutton',...
        'String','Team 2',...
        'Value',0,...
        'Position',[15,10,80,14]);

    submitButton = uicontrol(buttonPanel,'Style','pushbutton',...
        'String','Submit',...
        'Units','normalized',...
        'Position',[.35,.22,.3,.07],...
        'Callback',{@submit_callback});

    playButton = uicontrol(buttonPanel,'Style','pushbutton',...
        'String','Play',...
        'Units','normalized',...
        'Position',[.35,.1,.3,.07],...
        'Callback',{@play_callback});
    
    display(bd,boardAxes);
    
else
    game.play();
end

    function play_callback(hObject,eventdata)
        if (length(bd.Pieces))==0
            game.initializeBoard();
        end
        if length(game.KingList)==2
            if ((game.KingList{1}.Team==1) || (game.KingList{2}.Team==1)) &&...
                    ((game.KingList{1}.Team==2) || (game.KingList{2}.Team==2))
            else
                error('There are two kings but not on teams 1 and 2')
            end
        else
            error('There needs to be a king for each team')
        end

        set(buttonPanel,'Visible','off');
        set(game.Figure,'Position',[fpos(1:2),560,560])
        set(boardPanel,'Position',[0,0,1,1])
        game.play()
       
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
        
        %add the piece
        pcFh=str2func(piece);
        game.addPiece(pcFh(position,team));
        
        
        % put in code here to update the display of the board
        bd.display(boardAxes)
       
    end

end