function result = createTable(obj, request)
% CREATETABLE Creates a Table
% A Table object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.CreateTableRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.CreateTableRequest');
end

resultJ = obj.Handle.createTable(request.Handle);
result = aws.dynamodbv2.document.Table(resultJ);

end
