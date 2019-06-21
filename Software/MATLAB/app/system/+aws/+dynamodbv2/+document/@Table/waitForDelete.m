function waitForDelete(obj)
% WAITFORDELETE Blocking call to wait for the table to become deleted
% The call polls the status every 5 seconds.

% Copyright 2019 The MathWorks, Inc.

obj.Handle.waitForDelete();

end
