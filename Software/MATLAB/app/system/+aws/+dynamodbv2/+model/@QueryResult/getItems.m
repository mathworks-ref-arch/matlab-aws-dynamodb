function result = getItems(obj)
% GETITEMS Returns a cell array of maps of attribute names to AttributeValues
% The returned values match the query criteria. Elements in the maps consist
% of attribute names and the values for that attribute.
% Items are returned as a cell array of containers.Maps.

% Copyright 2019 The MathWorks, Inc.

% itemsJ is a Java ArrayList
itemsJ = obj.Handle.getItems();

% return a cell array with a containers map for each item
size = itemsJ.size();

if size < 1
    result = cell(0,0);
else
    result = cell(size,1);
    n = 1;
    itemsIteratorJ = itemsJ.iterator;
    while itemsIteratorJ.hasNext()
        itemJ = itemsIteratorJ.next();
        % itemJ is a java hashmap
        if itemJ.isEmpty()
            result{n} = containers.Map();
        else
            % return and entrySet to get an iterator
            entrySetJ = itemJ.entrySet();
            % get the iterator
            entrySetIteratorJ = entrySetJ.iterator();
            % declare empty cell arrays for values and keys
            itemKeys = {};
            itemValues = {};

            while entrySetIteratorJ.hasNext()
                % pick metadata from the entry set one at a time
                entryJ = entrySetIteratorJ.next();
                % get the key and the value
                itemKey = entryJ.getKey();
                itemValueJ = entryJ.getValue();
                % build the cell arrays of keys and values
                itemKeys{end+1} = itemKey; %#ok<AGROW>
                if isa(itemValueJ, 'com.amazonaws.services.dynamodbv2.model.AttributeValue')
                    itemValue = aws.dynamodbv2.model.AttributeValue(itemValueJ);
                    itemValues{end+1} = itemValue; %#ok<AGROW>
                else
                    logObj = Logger.getLogger();
                    write(logObj,'error','AttributeValue argument not of type com.amazonaws.services.dynamodbv2.model.AttributeValue');
                end
            end
            result{n} = containers.Map(itemKeys, itemValues);
            n = n + 1;
        end
    end
end

end
