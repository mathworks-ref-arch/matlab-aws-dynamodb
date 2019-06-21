function name = getLastEvaluatedTableName(obj)
% GETTABLENAME Returns name of the last table in the current page of results
% Result is returned as a character vector.

% Copyright 2019 The MathWorks, Inc.

name = char(obj.Handle.getLastEvaluatedTableName());

end
