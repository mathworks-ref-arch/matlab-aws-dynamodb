function result = isNULL(obj)
% ISNULL Returns a logical value denoting if an attribute is of type Null

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.isNULL();
result = resultJ.booleanValue();

end
