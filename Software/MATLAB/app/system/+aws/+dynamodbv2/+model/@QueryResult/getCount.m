function count = getCount(obj)
% GETCOUNT The number of items in the response
% Result is returned as a double.

% Copyright 2019 The MathWorks, Inc.

intJ = obj.Handle.getCount();
count = intJ.intValue();

end
