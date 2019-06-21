function result = putItem(obj, request)
% PUTITEM Creates a new item, or replaces an old item with a new item
% If an item that has the same primary key as the new item already exists in
% the specified table, the new item completely replaces the existing item.
% Conditional put operations (add a new item if one with the specified primary
% key doesn't exist), or replace an existing item if it has certain
% attribute values can be performed. A PutItemResult object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.PutItemRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.PutItemRequest');
end

resultJ = obj.Handle.putItem(request.Handle);
result = aws.dynamodbv2.model.PutItemResult(resultJ);

end
