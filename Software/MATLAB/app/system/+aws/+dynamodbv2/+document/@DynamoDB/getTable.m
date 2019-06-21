function result = getTable(obj, name)
% GETTABLE Gets a table based on a name
% A Table object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(name)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected name of type character vector');
end

resultJ = obj.Handle.getTable(name);
result = aws.dynamodbv2.document.Table(resultJ);

end
