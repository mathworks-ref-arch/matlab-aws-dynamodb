function result = waitForActive(obj)
% WAITFORACTIVE Blocking call to wait for the table to become active
% This is typically used during table creation.
% The call polls the status every 5 seconds.
% A TableDescription object is returned.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.waitForActive();
result = aws.dynamodbv2.model.TableDescription(resultJ);

end
