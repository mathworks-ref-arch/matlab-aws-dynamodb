function units = getWriteCapacityUnits(obj)
% GETWRITECAPACITYUNITS Returns WriteCapacityUnits
% WriteCapacityUnits is the maximum number of writes consumed per second before
% DynamoDB returns a ThrottlingException.
% units is returned as a double.

% Copyright 2019 The MathWorks, Inc.

units = obj.Handle.getWriteCapacityUnits.longValue();

end
