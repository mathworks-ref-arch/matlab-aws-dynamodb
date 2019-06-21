function units = getReadCapacityUnits(obj)
% GETREADCAPACITYUNITS Returns the ReadCapacityUnits
% ReadCapacityUnits is the maximum number of strongly consistent reads consumed
% per second before DynamoDB returns a ThrottlingException.
% units is returned as a double.

% Copyright 2019 The MathWorks, Inc.

units = obj.Handle.getReadCapacityUnits.longValue();

end
