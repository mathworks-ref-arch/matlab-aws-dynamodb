function result = getConsistentRead(obj)
% GETCONSISTENTREAD Determines the read consistency model
% If set to true, then the operation uses strongly consistent reads.
% Otherwise, the operation uses eventually consistent reads. A logical is
% returned.

% Copyright 2019 The MathWorks, Inc.

% convert returned Boolean to a boolean so a logical is returned from this function
resultJ = obj.Handle.getConsistentRead();
result = resultJ.booleanValue();

end
