classdef USDAGUI < USDA
    %A GUI for USDA database query
    %   USDAGUI class has no public properties
    %   USDAGUI class inherits USDA class and includes below methods:
    %   A constructor that takes a string api_key as input
    %   A StartGUI method that starts up the GUI
    %   The GUI is configured as the following:
    %   A field where a user inputs the string containing search keyword
    %   A button which initiates the Search which says 'Search'
    %   A uitable which shows GUI that searches the database and displays
    %   the nutritional facts for the first 7 results
    %   Pick any 5 nutritional facts to display in the table
    %   Also display ndbno number in uitable
    %   The rows are labeled by the Name of the food
    %   The columns are labeled by the nutrient name along with correct units
    %   To run the GUI, please type the following command (api_key is a string):
    %   >>> ui = USDAGUI(api_key);
    %   >>> ui.StartGUI();
    
    properties(Access = private)  
    end
    
    methods
        % Class Constructor that takes a string api_key
        function obj = USDAGUI(api_key)
            obj = obj@USDA(api_key);
        end
        
        % StartGUI method that starts up the GUI
        function StartGUI(gui_obj)
            f = figure('name','USDA API GUI');
            % partition the GUI into two parts
            table_panel = uipanel('Parent',f,'Position',[0,0,0.7,1]);
            button_panel = uipanel('Parent',f,'Position',[0.7,0,0.3,1]);
            table_text = uicontrol(table_panel,'Style','text',...
                'String','Data per 100g for substance','Units','Normalized',...
                'FontSize',15,'Position',[0,0.85,1,0.1]);
            % draw left side of the panel
            ui_table = uitable(f,'Data',zeros(8,7),'ColumnWidth','auto',...
                'Position',[100,100,500,200]);
            set(ui_table,'columnname',{'','ndbno Number','Nutrient 1','Nutrient 2',...
                'Nutrient 3','Nutrient 4','Nutrient 5'});
            % draw right side of the panel
            query_button = uicontrol(button_panel,'Style','edit',...
                'Max',1,'Min',1,'BackgroundColor','white','Units',...
                'Normalized','Position',[0.35,0.66,0.3,0.07]);
            search_button = uicontrol(button_panel,'Style','pushbutton',...
                'String','Search','Units','Normalized',...
                'Position',[0.35,0.22,0.3,0.07],...
                'Callback',@search_callback);
            
            % Search Callback function
            function search_callback(hObject,eventdata)
                % get user search keyword from the text box
                keyword = get(query_button,'String');
                % get the DOM object output
                cell_data = cell(1,7); cell_data_2 = cell(1,7);
                DOM = gui_obj.search(keyword);
                root_data = DOM.getDocumentElement;
                title_data = root_data.getElementsByTagName('name');
                num_data = root_data.getElementsByTagName('ndbno');
                % parse the DOM data
                for i = 1:7
                    dummy_data = char(title_data.item(i-1).getTextContent);
                    % parse name before the first comma
                    cell_data{i} = dummy_data(1:find(dummy_data == ','));
                end
                for j = 1:7
                    dummy_data = num_data.item(j-1).getTextContent;
                    cell_data_2{j} = char(dummy_data);
                end
                % get the reports data
                for k = 1:7
                    report(k,1) = gui_obj.reports(cell_data_2{k});
                end
                field_name = cell(7,5); field_unit = cell(7,5); 
                field_value = cell(7,5); field_catagory = cell(1,5);
                % loop through the cell array to extract field data
                for l = 1:7
                    for m = 1:5
                        file_root = report(l).getDocumentElement;
                        nut_data = file_root.getElementsByTagName('nutrient');
                        attr = nut_data.item(m-1).getAttributes;
                        field_name{l,m} = char(attr.item(1).getTextContent);
                        field_value{l,m} = char(attr.item(4).getTextContent);
                        field_unit{l,m} = char(attr.item(3).getTextContent);
                    end
                end
                % data cleanup and reorganization
                cell_data = cell_data'; cell_data_2 = cell_data_2';
                cell_data = [{' '};cell_data];
                field_name = field_name(1,:);
                field_unit = field_unit(1,:);
                for n = 1:5
                    field_catagory(n) = strcat(field_name(n),{' '},'(',field_unit(n),')');
                end
                % final cleanup
                field_value = [cell_data_2,field_value];
                field_catagory = [{'ndbno'},field_catagory];
                final_data = [field_catagory;field_value];
                final_data = [cell_data,final_data];
                % fill in the query table with organized data
                set(ui_table,'Data',final_data);
            end
            
        end
        
    end
    
end

