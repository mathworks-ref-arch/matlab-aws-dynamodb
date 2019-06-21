function result = listTables(obj, request)
% LISTTABLES List Tables in an account
% Returns an array of table names associated with the current account and
% endpoint. The output from ListTables is paginated, with each page returning a
% maximum of 100 table names.
% A listTablesResult object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.ListTablesRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.ListTablesRequest');
end

resultJ = obj.Handle.listTables(request.Handle);
result = aws.dynamodbv2.model.ListTablesResult(resultJ);

end
