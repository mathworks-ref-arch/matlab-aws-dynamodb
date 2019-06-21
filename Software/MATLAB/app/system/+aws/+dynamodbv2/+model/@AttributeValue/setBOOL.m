function setBOOL(obj, B)
% SETBOOL An attribute of type Boolean
% B is of type logical.

% Copyright 2019 The MathWorks, Inc.

if ~islogical(B)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected B of type logical');
end

obj.Handle.setBOOL(java.lang.Boolean(B));

end
