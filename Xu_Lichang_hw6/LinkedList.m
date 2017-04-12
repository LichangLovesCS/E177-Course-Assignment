classdef LinkedList < handle
    %% LINKEDLIST will receive and return node data stored in the list.
    %  The class has following properties described fully in details:
    %  Size - the size of the array.
    %  CellArray - this is a dependent property that compiles the data of
    %  the list into a 1-D cell array where the data stored in the cell
    %  array of a given index matches the data stored in the node of the
    %  LinkedList with the same index.
    
    %  The class has following methods described fully in details:
    %  >>> add(list,NodeData,index) - creates a dlnode instance with
    %  NodeData stored in the Data property and inserts the node in the
    %  LinkedList instance list at index. The node currently at index will
    %  come after the new node.
    %  >>> add(list,NodeData) - create a dlnode instance with NodeData
    %  stored in the data property and appends the node to the LinkedList.
    %  >>> addAll(list,otherList) - for each node in otherList, the data
    %  stored in the Data property is used to append a node to list. Adding
    %  or subtracting nodes from either list should not affect the other.
    %  >>> clear(list) - remove all nodes from the list.
    %  >>> out = contains(list,NodeData) - return true if the NodeData is
    %  contained in the list.
    %  >>> NodeData = get(list,index) - return the data at the given index.
    %  >>> index = indexOf(list,NodeData) - return the index of node for
    %  the first occurence of NodeData in the list or -1 if NodeData is not
    %  in the list.
    %  >>> NodeData = remove(list,index) - remove the node at a given index
    %  from the list and return its data.
    %  >>> set(list,NodeData,index) - set the Data property of the node at
    %  the given index to NodeData, overwriting the data already there.
    %  >>> out = subList(list,indexFrom,indexTo) - return a new LinkedList
    %  object with data from the nodes starting at indexFrom and ending at
    %  indexTo. It should include the data at indexFrom and indexTo. Adding
    %  or subtracting nodes from either list should not effect the other.
    
    properties(SetAccess = private)
        Size = 0; % size of the array
        CellArray = {}; % 1-D cell array representation of the list
    end
    
    properties(Access = private)
        Head; % store the head of the list 
    end
    
    methods
        function add(list,NodeData,index)
            new_node = dlnode(NodeData); % create a new node that will be added
            if(nargin == 3) % has index as input
                if(index == 1) % add to the first node
                    if(isempty(list.Head)) % head is null
                        list.Head = new_node; % set head to the new node
                    else
                        new_node.insertBefore(list.Head); % reset head pointer
                        list.Head = new_node;
                    end
                else
                    if(index > list.Size)
                        error('index is not valid!');
                    else
                        cur_node = list.Head;
                        for i = 2:index
                            cur_node = cur_node.Next;
                        end
                        % now cur_node is at index node; insert new node after
                        new_node.insertBefore(cur_node);
                    end
                end
                % update size
                list.Size = list.Size + 1;
                % update the 1-D cell array representation of the list
                dummy_node = list.Head;
                for i = 1:list.Size
                    list.CellArray{i} = dummy_node.Data;
                    if(~isempty(dummy_node.Next))
                        dummy_node = dummy_node.Next;
                    end
                end
            end
            
            if(nargin == 2) % no index input
                % append the node to the list
                if(list.Size == 0)
                    list.Head = new_node;
                else
                    cur_node = list.Head;
                    for i = 1:list.Size
                        if(~isempty(cur_node.Next))
                            cur_node = cur_node.Next;
                        end
                    end
                    % now cur_node points at the tail node
                    new_node.insertAfter(cur_node);
                end
                % update size
                list.Size = list.Size + 1;
                % update the 1-D cell Array representation of the list
                dummy_node = list.Head;
                for i = 1:list.Size
                    list.CellArray{i} = dummy_node.Data;
                    if(~isempty(dummy_node.Next))
                        dummy_node = dummy_node.Next;
                    end
                end
            end   
        end
        
        function addAll(list,otherList)
            for i = 1:otherList.Size
                % copy each node data from otherList to list
                list.add(otherList.CellArray{i});
            end
        end
        
        function clear(list)
            % remove all nodes from the list
            list.Size = 0;
            list.CellArray = {};
        end
        
        function out = contains(list,NodeData)
            % out is true if list contains NodeData
            out = 0;
            for i = 1:list.Size
                if(isequal(list.CellArray{i},NodeData))
                    out = 1;
                end
            end
        end
        
        function NodeData = get(list,index)
            if(index > list.Size)
                error('index is not valid!');
            end
            % return data at the given index
            NodeData = list.CellArray{index};
        end
        
        function index = indexOf(list,NodeData)
            % return the index of node that has NodeData or -1 otherwise
            index = -1;
            for i = 1:list.Size
                if(isequal(list.CellArray{i},NodeData))
                    index = i;
                    break;
                end
            end
        end
        
        function NodeData = remove(list,index)
            % remove the node at a given index and return its data
            NodeData = get(list,index);
            cur_node = list.Head;
            for i = 1:index
                if(~isempty(cur_node.Next))
                    cur_node = cur_node.Next;
                end
            end
            % remove the node
            cur_node.delete();
            % update CellArray and size
            list.Size = list.Size - 1;
            list.CellArray(index) = [];       
        end
        
        function set(list,NodeData,index)
            if(index > list.Size)
                error('index is not valid!');
            end
            % set data of node at index to NodeData
            cur_node = list.Head;
            for i = 1:index
                if(~isempty(cur_node.Next))
                    cur_node = cur_node.Next;
                end
            end
            % overwrite node data
            cur_node.Data = NodeData;
            % update CellArray
            list.CellArray{i} = NodeData;
        end
        
        function out = subList(list,indexFrom,indexTo)
            % return a new LinkedList object with indexing data
            out = LinkedList();
            for i = indexFrom:indexTo
                % get each node data
                node_data = list.get(i);
                % add the data to the out list
                out.add(node_data);
            end
        end
         
    end
    
end