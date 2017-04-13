classdef USDA
    %CLass for Querying the USDA nutritional database
    %  The API url is http://api.nal.usda.gov/usda/ndb/
    %  Information on the api can be found at
    %           http://ndb.nal.usda.gov/ndb/api/doc
    %  
    % METHODS
    % Constructor:
    %    USDAobj=USDA(api_key)
    %    inputs: 
    %      api_key: (string) USDA api key obtained free at
    %                           https://api.data.gov/signup/  
    %    outputs: 
    %        USDAobj: (USDA instance)
    %
    %
    % search:
    %   S=USDAobj.search(searchfield)
    %   Required inputs:
    %       searchfield: (string) words (seperated by +) in names of foods
    %                              you want to find
    %   Ouputs:
    %        S: (domobject)  dom object of xml file returned with possible
    %    Example Call:
    %    USDAobj=USDA('DEMO_KEY')
    %    S=USDAobj.search('peanut+butter')
    %
    %
    % reports:
    %   Required inputs:
    %       ndbno: (string) 5-digit unique id for food in database (found using
    %                       search)
    %   Ouputs:
    %        R: (domobject)  dom object of xml file returned with Nutrional
    %                           Data like Energy, Protein
    %    Example Call:
    %        %collects  food with description ' Peanut butter, chunk style,
    %                                           with salt'
    %        USDAobj=USDA('DEMO_KEY')
    %        R=USDAobj.reports('16097')
    %
    % NOTE: You may want to see a text version of the xml file to product
    %       this use 'xmlwrite(filename,domobject)
    %       %%%% EXAMPLE %%%%
    %           api_key='DEMO_KEY'
    %           USDAobj=USDA(api_key)
    %           S=USDAobj.search('peanut+butter')
    %           xmlwrite('PBsearch.xml',S)
    %           R=USDAobj.reports('16097')
    %           xmlwrite('PBSalted.xml',R)
    properties(Access=protected)
        api_key
        urlbase='http://api.nal.usda.gov/usda/ndb/';
    end
    methods
        function out=USDA(api_key)
            out.api_key=api_key;
        end
        function S=search(self,searchfield,varargin)
            urlextra='search/?';
            p = inputParser;
            optionalinputs={'fg','sort','format','max','offset'};
            defaultinputs={'','r','xml',10,0};
            for k=1:length(optionalinputs)
                addOptional(p,optionalinputs{k},defaultinputs{k})
            end
            
            %add part of url for query(q)
            urlextra=[urlextra,'q=',searchfield];
            
            %parse optional arguements
            parse(p,varargin{:});
            %add string optional arguements 
            for k=1:(length(optionalinputs)-2)
                opin=optionalinputs{k};
                urlextra=[urlextra,'&',opin,'=',getfield(p.Results,opin)];
            end
            
            for k=(length(optionalinputs)-1):(length(optionalinputs))
                opin=optionalinputs{k};
                urlextra=[urlextra,'&',opin,'=',num2str(getfield(p.Results,opin))];
            end
            S=self.query(urlextra,p.Results.format);
            
        end
        function R=reports(self,ndbno,varargin)
            urlextra='reports/?';
            p = inputParser;
            optionalinputs={'type','format'};
            defaultinputs={'b','xml'};
            for k=1:length(optionalinputs)
                addOptional(p,optionalinputs{k},defaultinputs{k})
            end
            %add part of url for nutritional databse number (ndbno)
            urlextra=[urlextra,'ndbno=',ndbno];
            
            parse(p,varargin{:});
            %add string optional arguements 
            for k=1:length(optionalinputs)
                opin=optionalinputs{k};
                urlextra=[urlextra,'&',opin,'=',getfield(p.Results,opin)];
            end
            R=self.query(urlextra,p.Results.format);
            
        end
    end
    methods(Access=private)
        function D=query(self,urlextra,dtype)
            q=[self.urlbase,urlextra,'&api_key=',self.api_key];
            op=weboptions('ContentType',dtype);
            D=webread(q,op);
            %if dtype=='xml'
            %    D=xmlread(q);
            %else
            %    D=jsonread(q);
        end
    end
    
end


