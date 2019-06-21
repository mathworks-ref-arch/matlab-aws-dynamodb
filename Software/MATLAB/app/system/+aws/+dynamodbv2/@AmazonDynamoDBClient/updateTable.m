function result = updateTable(obj, request)
% UPDATETABLE Modifies Table properties
% Modifies the provisioned throughput settings, global secondary indexes, or
% DynamoDB Streams (not currently supported) settings for a given table.
% Only perform one of the following operations can be performed at once:
%  * Modify the provisioned throughput settings of the table.
%  * Enable or disable Streams on the table.
%  * Remove a global secondary index from the table.
%  * Create a new global secondary index on the table. Once the index begins
%    backfilling, you can use UpdateTable to perform other operations.
%
% UpdateTable is an asynchronous operation; while it is executing, the table
% status changes from ACTIVE to UPDATING. While it is UPDATING, you cannot issue
% another UpdateTable request. When the table returns to the ACTIVE state, the
% UpdateTable operation is complete.
% A UpdateTableResult object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.UpdateTableRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.UpdateTableRequest');
end

resultJ = obj.Handle.updateTable(request.Handle);
result = aws.dynamodbv2.model.UpdateTableResult(resultJ);

end
