function setLimit(obj, limit)
% SETLIMIT A maximum number of table names to return
% A minimum value of 1 and a maximum value of 100 are accepted.

% Copyright 2019 The MathWorks, Inc.

if ~isnumeric(limit)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected limit of type numeric');
end

obj.Handle.setLimit(limit);

end
