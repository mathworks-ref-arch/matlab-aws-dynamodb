function setConsistentRead(obj, consistentRead)
% SETCONSISTENTREAD Sets the read consistency model
% If set to true, then the operation uses strongly consistent reads; otherwise,
% the operation uses eventually consistent reads.

% Copyright 2019 The MathWorks, Inc.

if ~islogical(consistentRead)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected consistentRead of type logical');
end

obj.Handle.setConsistentRead(java.lang.Boolean(consistentRead));

end
