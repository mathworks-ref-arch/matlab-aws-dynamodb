function result = deleteTable(obj, name)
% DELETETABLE Deletes a table
% The table name is specified as a character vector. A DeleteTableResult object
% is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(name)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected name of type character vector');
end

resultJ = obj.Handle.deleteTable(name);
result = aws.dynamodbv2.model.DeleteTableResult(resultJ);

end
