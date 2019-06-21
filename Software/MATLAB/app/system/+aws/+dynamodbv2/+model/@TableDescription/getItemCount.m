function count = getItemCount(obj)
% GETITEMCOUNT Returns the number of items in a table as a double

% Copyright 2019 The MathWorks, Inc.

count = obj.Handle.getItemCount().longValue;

end
