function setNULL(obj, N)
% SETNULL Sets an attribute of type NULL
% N should be of type logical.

% Copyright 2019 The MathWorks, Inc.

if ~islogical(N)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected N of type logical');
end

obj.Handle.setNULL(java.lang.Boolean(N));

end
