function result = isBOOL(obj)
% ISBOOL Returns a logical value denoting if an attribute is of type Boolean

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.isBOOL();
result = resultJ.booleanValue();

end
