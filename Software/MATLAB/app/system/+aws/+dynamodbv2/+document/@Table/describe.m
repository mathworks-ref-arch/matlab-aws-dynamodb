function result = describe(obj)
% Describe Retrieves the table description
% A TableDescription object is returned.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.describe();
result = aws.dynamodbv2.model.TableDescription(resultJ);

end
