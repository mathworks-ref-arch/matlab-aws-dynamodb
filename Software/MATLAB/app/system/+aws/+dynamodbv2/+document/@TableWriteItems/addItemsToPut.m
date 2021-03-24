function result = addItemToPut(obj, item)
% ADDITEMTOPUT Adds an item to be put to the table in a batch write operation
% A aws.dynamodbv2.document.TableWriteItems object is returned.

% Copyright 2020 The MathWorks, Inc.

if ~isa(item, 'aws.dynamodbv2.document.Item')
    logObj = Logger.getLogger();
    write(logObj,'error','argument not of type array of aws.dynamodbv2.document.Item');
end

resultJ = obj.Handle.addItemToPut(item.Handle);
result = aws.dynamodbv2.document.TableWriteItems(resultJ);

end