function result = createTable(obj, request)
% CREATETABLE Creates a table
% The CreateTable operation adds a new table to an account. In an AWS account,
% Table names must be unique within each region.
% The table is created based on the configuration of a CreateTableRequest object.
% CreateTable is an asynchronous operation. Upon receiving a CreateTable request,
% DynamoDB immediately returns a response with a TableStatus of CREATING.
% After the table is created, DynamoDB sets the TableStatus to ACTIVE.
% Read and write operations can only be performed on an ACTIVE table.
% A CreateTableResult object is returned. You can use the DescribeTable method
% to check the table status.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.CreateTableRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.CreateTableRequest');
end

resultJ = obj.Handle.createTable(request.Handle);
result = aws.dynamodbv2.model.CreateTableResult(resultJ);

end
