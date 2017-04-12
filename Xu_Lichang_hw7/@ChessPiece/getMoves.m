function moves = getMoves(piece)
moveArray = piece.getMoveArray();
moves = [];
for i = 1:length(moveArray)
    thisDir = moveArray{i};
    for j = 1:size(thisDir,1)
        [occ,pc] = piece.Game.Board.checkPosition(thisDir(j,:));
        if occ
            if pc.Team ~= piece.Team
                moves(end+1,:) = [thisDir(j,:),true];
            end
            break;
        else
            moves(end+1,:) = [thisDir(j,:),false];
        end
    end
end
end

