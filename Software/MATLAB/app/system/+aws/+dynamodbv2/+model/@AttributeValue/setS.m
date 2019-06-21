function setS(obj, S)
% SETS An attribute of type String
% S is of type character vector

% Copyright 2019 The MathWorks, Inc.

if ~ischar(S)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected S of type character vector');
end

obj.Handle.setS(S);

end
