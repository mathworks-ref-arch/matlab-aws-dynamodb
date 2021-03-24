function result = batchWriteItem(obj, request)
% BATCHWRITEITEM Puts or deletes multiple items in one or more tables
% A BatchWriteItemResult object is returned.
    
% Copyright 2020 The MathWorks, Inc.
    
if ~isa(request, 'aws.dynamodbv2.model.BatchWriteItemRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.BatchWriteItemRequest');
end
    
resultJ = obj.Handle.batchWriteItem(request.Handle);
result = aws.dynamodbv2.model.BatchWriteItemResult(resultJ);
    
end
    