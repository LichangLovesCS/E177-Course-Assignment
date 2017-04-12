%% Name: Lichang Xu    SID: 24501267
% Create a Point class with properties "X" and "Y", both with a default
% value of 0. The functionality of the class allows the following calls:
% >> pt = Point --- create an instance of the class with default properties
% >> pt = Point(xval,yval) --- create an object and assigns property values
% >> distance(pt1,pt2) --- return the Euclidean distance between two points
% >> pt1 + pt2 --- return a point whose X and Y are the sum of respective
% properties in pt1 and pt2
% >> pt1 - pt2 --- return a point whose X and Y are the difference of the
% respective properties in pt1 and pt2
% >> display(pt1) --- displays the point object as an ordered pair. 

classdef Point 
    properties
        X = 0; % default X value set to 0
        Y = 0; % default Y value set to 0
    end
    methods
        function obj = Point(xval,yval) % a constructor of the Point class
            if nargin >= 1
                if isnumeric(xval) && isnumeric(yval) % inputs must be numeric
                    obj.X = xval; 
                    obj.Y = yval;
                else
                    error('Value must be numeric.')
                end
            end
        end
        function dist = distance(obj1,obj2) % return Euclidean distance between two points
            if nargin > 1
                x_euc = (obj1.X - obj2.X)^2;
                y_euc = (obj1.Y - obj2.Y)^2;
                dist = sqrt(x_euc + y_euc);
            end
        end
        function obj3 = plus(obj1,obj2) % an overload method to add properties of two points 
            if nargin > 1
                obj3 = Point; % create an empty object
                obj3.X = obj1.X + obj2.X; % new point's X property is the sum of that of two inputs
                obj3.Y = obj1.Y + obj2.Y; % new point's Y property is the sum of that of two inputs
            end
        end
        function obj3 = minus(obj1,obj2) % an overload method to minus properties of two points
            if nargin > 1
                obj3 = Point; % create an empty object
                obj3.X = obj1.X - obj2.X; % new point's X property is the difference of that of two inputs
                obj3.Y = obj1.Y - obj2.Y; % new point's Y property is the difference of that of two inputs
            end
        end
        function display(obj) % an overload method to display the point object as an ordered pair
            name = inputname(1); % get the name of the created object
            msg = [name,' = ','<',num2str(obj.X),',',num2str(obj.Y),'>'];
            disp(msg)
        end
    end
end