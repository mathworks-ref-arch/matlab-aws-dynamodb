function result = query(obj, request)
% QUERY Finds items based on primary key values
% Any table or secondary index that has a composite primary key (a partition key
% and a sort key) can be queried. Use the KeyConditionExpression parameter to
% provide a specific value for the partition key.
% The Query operation will return all of the items from the table or index with
% that partition key value. You can optionally narrow the scope of the Query
% operation by specifying a sort key value and a comparison operator in
% KeyConditionExpression. To further refine the Query results, optionally
% provide a FilterExpression.
% Query results are always sorted by the sort key value. If the data type of the
% sort key is Number, the results are returned in numeric order; otherwise, the
% results are returned in order of UTF-8 bytes. By default, the sort order is
% ascending. If LastEvaluatedKey is the response, you will need to paginate the
% results. FilterExpression is applied after a Query finishes, but before the
% results are returned. A FilterExpression cannot contain partition key or sort key
% attributes. Specify those attributes in the KeyConditionExpression. A Query
% operation can return an empty result set and a LastEvaluatedKey if all the
% items read for the page of results are filtered out. You can query a table, a
% local secondary index, or a global secondary index. For a query on a table or
% on a local secondary index, you can set the ConsistentRead parameter to true
% and obtain a strongly consistent result. Global secondary indexes support
% eventually consistent reads only, so do not specify ConsistentRead when
% querying a global secondary index. A QueryResult object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(request, 'aws.dynamodbv2.model.QueryRequest')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected request of type aws.dynamodbv2.model.QueryRequest');
end

resultJ = obj.Handle.query(request.Handle);
result = aws.dynamodbv2.model.QueryResult(resultJ);

end
