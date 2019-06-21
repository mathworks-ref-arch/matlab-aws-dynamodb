function setN(obj, N)
% SETN Sets an attribute of type Number
% N should be of type character vector.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(N)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected N of type character vector');
end

obj.Handle.setN(N);

end
