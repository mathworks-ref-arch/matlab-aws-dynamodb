function result = deleteTable(obj)
% DELETETABLE Deletes the table from DynamoDB
% A DeleteTableResult is returned.
% This method corresponds to the Table.delete method.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.delete();
result = aws.dynamodbv2.model.DeleteTableResult(resultJ);

end
