function result = deleteItem(obj, tableName, items)
% DELETEITEM Deletes an item from a table
% The table name is specified as a character vector and the items to be deleted
% are specified using a containers.Map
% A DeleteItemResult object is returned

% Copyright 2019 The MathWorks, Inc.

if ~ischar(tableName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected tableName of type character vector');
end

if ~isa(items, 'containers.Map')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected items of type containers.Map');
end

% extract the keys and values from the containers map
cMapKeys = keys(items);
cMapVals = values(items);

hMapJ = java.util.HashMap;

for n = 1:numel(items)
    % add an entry to the HashMap per iteration
    hMapJ.put(cMapKeys{n}, cMapVals{n}.Handle);
end

resultJ = obj.Handle.deleteItem(tableName, hMapJ);
result = aws.dynamodbv2.model.DeleteItemResult(resultJ);

end
