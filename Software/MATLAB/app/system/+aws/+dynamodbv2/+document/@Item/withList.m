function item = withList(obj, attrName, val)
% WITHLIST Sets specified attribute in the item to the given values as a list
% attrName should be a character vector.
% MATLAB arrays are converted to row vectors prior to conversion to a list
% for storage. Multidimensional arrays are not supported.
% Only vals of type double are currently supported.
% An aws.dynamodbv2.document.Item is returned.
% TODO update for cell array lists

% Copyright 2020 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

if iscell(val)
    listStr = '[';
    for n = 1:numel(val)
        if isscalar(val{n}) || ischar(val{n})
            if ischar(val{n}) || isStringScalar(val{n})
                entryStr = ['"', char(val{n}), '"'];
            elseif isnumeric(val{n})
                entryStr = num2str(val{n});
            else
                logObj = Logger.getLogger();
                write(logObj,'error','Cell array val entries must be character vector, scalar string or numeric types');
            end
            if n > 1
                listStr = [listStr, ', ' entryStr]; %#ok<AGROW>                
            else
                listStr = [listStr, entryStr]; %#ok<AGROW>
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Cell array val entries must be scalar');
        end
    end    
    listStr = [listStr, ']'];
    itemJ = obj.Handle.withList(attrName, listStr);
else
    if isa(val,'double')
        listJ = java.util.ArrayList();
        for n = 1:numel(val)
            listJ.add(java.lang.Double(val(n)));
        end
    else
        logObj = Logger.getLogger();
        write(logObj,'error','Expected val to be of type double');
    end
    % TODO expand for other types
    itemJ = obj.Handle.withList(attrName, listJ);
end

item = aws.dynamodbv2.document.Item(itemJ);

end
