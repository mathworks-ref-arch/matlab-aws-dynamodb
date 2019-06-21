function result = updateTable(obj, value)
% UPDATETABLE Updates a table
% A aws.dynamodbv2.model.ProvisionedThroughput object is expected as input.
% A TableDescription object is returned.

% Copyright 2019 The MathWorks, Inc.

if isa(value, 'aws.dynamodbv2.model.ProvisionedThroughput')
    resultJ = obj.Handle.updateTable(value.Handle);
    result = aws.dynamodbv2.model.TableDescription(resultJ);
else
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.ProvisionedThroughput');
end

end
