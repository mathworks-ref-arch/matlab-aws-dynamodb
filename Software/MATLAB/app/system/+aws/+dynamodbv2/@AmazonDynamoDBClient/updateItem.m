function result = updateItem(obj, request)
% UPDATEITEM Edits an existing item's attributes, or adds a new item to the table
% Enables put, delete, or adding attribute values. Conditional updates on an
% existing item (insert a new attribute name-value pair if it doesn't exist,
% or replace an existing name-value pair if it has certain expected attribute
% values) can be performed.
% Return the item's attribute values in the same UpdateItem operation using the
% ReturnValues parameter. A UpdateItemResult object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.UpdateItemRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.UpdateItemRequest');
end

resultJ = obj.Handle.updateItem(request.Handle);
result = aws.dynamodbv2.model.UpdateItemResult(resultJ);

end
