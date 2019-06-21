function setTableName(obj, name)
% SETTABLENAME Sets the name of a table
% name should be of type character vector.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(name)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected name of type character vector');
end

obj.Handle.setTableName(name);

end
