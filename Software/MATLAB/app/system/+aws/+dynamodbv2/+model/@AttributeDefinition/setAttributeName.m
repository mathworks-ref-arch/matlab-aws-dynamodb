function setAttributeName(obj, name)
% SETATTRIBUTENAME Sets the name of an attribute
% The name should be provided as a character vector

% Copyright 2019 The MathWorks, Inc.

if ~ischar(name)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected name of type character vector');
end

obj.Handle.setAttributeName(name);

end
