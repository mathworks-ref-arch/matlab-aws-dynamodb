function result = getItem(obj, request)
% GETITEM Returns attributes for an item with a given primary key
% The GetItem operation returns a set of attributes for the item with the given
% primary key. If there is no matching item, GetItem does not return any data
% and there will be no Item element in the response. The request is specified
% using a GetItemRequest object
% GetItem provides an eventually consistent read by default. If your application
% requires a strongly consistent read, set ConsistentRead to true. Although a
% strongly consistent read might take more time than an eventually consistent
% read, it always returns the last updated value.
% A GetItemResult object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.GetItemRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.GetItemRequest');
end

resultJ = obj.Handle.getItem(request.Handle);
result = aws.dynamodbv2.model.GetItemResult(resultJ);

end
