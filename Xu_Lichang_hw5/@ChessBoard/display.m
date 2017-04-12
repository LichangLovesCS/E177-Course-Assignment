function display(board)
   X=0.5:8.5;
   Y=X;
   Z=ones(9,9);
   Z(1:2:end,1:2:end)=-1;
   Z(2:2:end,2:2:end)=-1;
   pcolor(X,Y,Z);
   colormap(gray(2));
   axis xy;
   axis square;
   for x = 1:8
       for y = 1:8
           [occ,pc] = board.checkPosition([x y]);
           if occ
               colors = {'green','red','blue','yellow'};
               text(x-0.2,y,[num2str(pc.Team) pc.getSymbol()],...
                   'Color',colors{mod(pc.Team,4)+1});
               %{
               % Alternate squares coloring
               if mod(x+y,2) == 1
                   text(x-0.2,y, ...
                       [num2str(pc.Team) pc.getSymbol()]);
               else
                   text(x-0.2,y, ...
                       [num2str(pc.Team) pc.getSymbol()],'Color','white');
               end
               %}
           end
       end
   end
end