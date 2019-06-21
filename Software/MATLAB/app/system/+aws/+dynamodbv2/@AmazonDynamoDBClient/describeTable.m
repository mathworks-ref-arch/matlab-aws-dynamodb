function result = describeTable(obj, name)
% DESCRIBETABLE Describes a table
% The table name is specified as a character vector. A DescribeTableResult object
% is returned. This methods can be used to get the status of a table.
%
% Example:
%    describeResult = ddb.describeTable(tableName);
%    tableDescription = describeResult.getTable();
%    status = tableDescription.getTableStatus();

% Copyright 2019 The MathWorks, Inc.

if ~ischar(name)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected name of type character vector');
end

resultJ = obj.Handle.describeTable(name);
result = aws.dynamodbv2.model.DescribeTableResult(resultJ);

end
