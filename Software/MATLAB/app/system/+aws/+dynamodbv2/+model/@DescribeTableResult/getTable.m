function result = getTable(obj)
% GETTABLE Get the properties of the table
% Returns a TableDescription object.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.getTable();
result = aws.dynamodbv2.model.TableDescription(resultJ);

end
