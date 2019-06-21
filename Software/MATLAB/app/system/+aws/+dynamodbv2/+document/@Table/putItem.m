function result = putItem(obj, item)
% PUTITEM Adds an item to a table
% Item should be of type aws.dynamodbv2.document.Item.
% A PutItemOutcome object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(item, 'aws.dynamodbv2.document.Item')
    logObj = Logger.getLogger();
    write(logObj,'error','Expected item of type aws.dynamodbv2.document.Item');
end

resultJ = obj.Handle.putItem(item.Handle);
result = aws.dynamodbv2.document.PutItemOutcome(resultJ);

end
