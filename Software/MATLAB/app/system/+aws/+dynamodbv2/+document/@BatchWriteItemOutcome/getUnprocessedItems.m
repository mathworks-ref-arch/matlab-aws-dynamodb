function item = getUnprocessedItems(obj)
% GETUNPROCESSEDITEMS Return the low-level unprocessed items
% The returned items returned as a containers.Map

% Copyright 2020 The MathWorks, Inc.

itemJ = obj.Handle.getUnprocessedItems();

if ~isempty(itemJ)
    % return and entrySet to get an iterator
    entrySetJ = itemJ.entrySet();
    % get the iterator
    iteratorJ = entrySetJ.iterator();

    % declare empty cell arrays for values and keys
    itemKeys = {};
    itemValues = {};
    
    while iteratorJ.hasNext()
        % pick metadata from the entry set one at a time
        entryJ = iteratorJ.next();
        % get the key and the value
        itemKey = entryJ.getKey();
        itemValueJ = entryJ.getValue();
        % build the cell arrays of keys and values
        itemKeys{end+1} = itemKey; %#ok<AGROW>
        if isa(itemValueJ, 'com.amazonaws.services.dynamodbv2.document.Item')
            itemValue = aws.dynamodbv2.document.Item(itemValueJ);
            itemValues{end+1} = itemValue; %#ok<AGROW>
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Item not of type com.amazonaws.services.dynamodbv2.document.Item');
        end
    end

    % if the cell arrays are still empty then create an empty containers.Map and
    % return that else build it from the arrays of values and keys
    if isempty(itemKeys)
        item = containers.Map();
    else
        item = containers.Map(itemKeys, itemValues);
    end

else
    % if itemJ was returned as empty the return an empty containers.Map()
    item = containers.Map();
end    

end