function result = getS(obj)
% GETS gets an attribute of type String
% Result is returned as a character vector.

% Copyright 2019 The MathWorks, Inc.

result = char(obj.Handle.getS());

end
