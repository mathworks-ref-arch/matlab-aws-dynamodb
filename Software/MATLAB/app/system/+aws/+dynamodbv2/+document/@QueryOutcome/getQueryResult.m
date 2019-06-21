function queryResult = getQueryResult(obj)
% GETQUERYRESULT Returns a low-level result object returned from the server side

% Copyright 2019 The MathWorks, Inc.

queryResultJ = obj.Handle.getQueryResult();
queryResult = aws.dynamodbv2.model.QueryResult(queryResultJ);

end
