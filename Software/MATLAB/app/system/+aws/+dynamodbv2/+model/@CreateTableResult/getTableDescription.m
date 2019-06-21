function result = getTableDescription(obj)
% GETTABLEDESCRIPTION Gets the properties of the table

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.getTableDescription();
result = aws.dynamodbv2.model.TableDescription(resultJ);

end
