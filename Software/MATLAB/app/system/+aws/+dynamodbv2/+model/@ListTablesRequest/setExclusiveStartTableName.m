function setExclusiveStartTableName(obj, exclusiveStartTableName)
% SETEXCLUSIVESTARTTABLENAME The first table name the operation will evaluate
% exclusiveStartTableName should be of type character vector.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(exclusiveStartTableName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected exclusiveStartTableName of type character vector');
end

obj.Handle.setExclusiveStartTableName(exclusiveStartTableName);

end
