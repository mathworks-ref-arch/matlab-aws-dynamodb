function result = batchWriteItem(obj, tableWriteItems)
% BATCHWRITEITEM  Perform a batch write operation to DynamoDB
% A BatchWriteItemOutcome object is returned.
    
% Copyright 2020 The MathWorks, Inc.
    
if ~isa(tableWriteItems, 'aws.dynamodbv2.document.TableWriteItems')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.document.TableWriteItems');
end

tableWriteItemsArrayJ = javaArray('com.amazonaws.services.dynamodbv2.document.TableWriteItems', 1,numel(tableWriteItems));
for n = 1:numel(tableWriteItems)
    tableWriteItemsArrayJ(1,n) = tableWriteItems(n).Handle;
end

resultJ = obj.Handle.batchWriteItem(tableWriteItemsArrayJ(1));
result = aws.dynamodbv2.document.BatchWriteItemOutcome(resultJ);
    
end