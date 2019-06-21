function result = getNULL(obj)
% GETNULL gets an attribute of type NULL which may be true or false
% Result is returned as a logical.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.getNULL();
result = resultJ.booleanValue();

end
