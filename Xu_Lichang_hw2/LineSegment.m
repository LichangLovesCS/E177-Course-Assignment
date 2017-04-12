%% Name: Lichang Xu    SID: 24501267
% Create a LineSegment class with properties "Start" and "Finish". These
% properties are only assigned to Point objects. 
% The class has a constructor that assigns two points, pt1 and pt2, to the
% properties "Start" and "Finish".
% The class has a method called length that returns the length of the line
% segment. It does not calculate the length directly, but rather use
% methods from the Point class. 
% The class also has a display method that plots the line connecting the
% Start and Finish.
% The functionality of the class allows the following calls:
% >> LineSegment = LineSegment(pt1,pt2) --- the constructor to 
% create a new LineSegment object with Start and Finish properties set to 
% Point object pt1 and pt2, respectively
% >> len = length(LineSegment) --- returns the length of a given
% LineSegment object with Start and Finish Point set properly
% >> display(LineSegment) --- plots the given LineSegment object by
% connecting the Start and Finish Points

classdef LineSegment
    properties
        Start
        Finish
    end
    methods
        function obj = LineSegment(pt1,pt2) % a constructor that assigns two points to the properties "Start" and "Finish"
            if nargin > 1 && isa(pt1,'Point') && isa(pt2,'Point') % Start and Finish must be of type Point
                obj.Start = pt1;
                obj.Finish = pt2;
            else
                error('Not enough arguments or input class is wrong.')
            end
        end
        function obj = set.Start(obj,val) % Change Start property
            if isa(val,'Point')
                obj.Start = val;
            else
                error('Property Start must be of class Point.')
            end
        end
        function obj = set.Finish(obj,val) % Change Finish property
            if isa(val,'Point')
                obj.Finish = val;
            else
                error('Property Finish must be of class Point.')
            end
        end     
        function len = length(obj) % a method that returns the length of the line segment
            len = obj.Start.distance(obj.Finish); % use methods from the Point class to calculate the length
        end
        function display(obj) % an overload method that plots the line connecting the Start and Finish Points
            figure;
            scatter(obj.Start.X,obj.Start.Y,'bo');
            hold on;
            scatter(obj.Finish.X,obj.Finish.Y,'bo');
            plot([obj.Start.X,obj.Finish.X],[obj.Start.Y,obj.Finish.Y],'r');
            xlabel('Property X'); ylabel('Property Y');
            title('Line Segment Connecting Start and Finish Point');
        end
    end
end
