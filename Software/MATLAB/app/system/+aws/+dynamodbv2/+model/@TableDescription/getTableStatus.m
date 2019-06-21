function status = getTableStatus(obj)
% GETTABLESTATUS Returns the status of a table as a character vector

% Copyright 2019 The MathWorks, Inc.

status = char(obj.Handle.getTableStatus());

end
