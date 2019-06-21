function name = getTableName(obj)
% GETTABLENAME Returns the name of a table as a character vector

% Copyright 2019 The MathWorks, Inc.

name = char(obj.Handle.getTableName());

end
