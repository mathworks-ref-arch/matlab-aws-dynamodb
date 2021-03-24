function setNS(obj, S)
% SETNS Set a cell array of attributes of type Number
% Cell array entries should be of type character vector.
% The cell array will be mapped to a 1D array as it is converted to a Java List.
% Dimensional structure will not be retained.
% Insert order will not be retained.

% Copyright 2020 The MathWorks, Inc.

if ~iscellstr(S) %#ok<ISCLSTR>
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected S of type cell array of character vectors');
end

ArrayListJ = java.util.ArrayList;
for n = 1:numel(S)
    ArrayListJ.add(S{n});
end

obj.Handle.setNS(ArrayListJ);

end
