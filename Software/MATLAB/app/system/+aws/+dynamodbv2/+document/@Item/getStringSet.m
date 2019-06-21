function result = getStringSet(obj, attrName)
% GETSTRINGSET Gets an attribute of type StringSet
% attrName should be a character vector.
% Result is returned as a cell array of character vectors.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

resultJ = obj.Handle.getStringSet(attrName);
size = resultJ.size();
result = cell(size,1);

iteratorJ = resultJ.iterator;
n = 1;
while iteratorJ.hasNext()
   result{n} = iteratorJ.next();
   n = n + 1;
end

end
