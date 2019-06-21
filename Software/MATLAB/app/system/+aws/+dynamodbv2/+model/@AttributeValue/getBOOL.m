function result = getBOOL(obj)
% GETBOOL Gets an attribute of type Boolean
% Result is returned as a logical.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.getBOOL();
result = resultJ.booleanValue();

end
