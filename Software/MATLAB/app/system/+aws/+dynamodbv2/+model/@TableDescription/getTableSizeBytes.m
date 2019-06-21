function size = getTableSizeBytes(obj)
% GETTABLESIZEBYTES Returns the size of a table in bytes as a double

% Copyright 2019 The MathWorks, Inc.

size = obj.Handle.getTableSizeBytes().longValue;

end
