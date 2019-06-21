function setExpressionAttributeNames(obj, expressionAttributeNames)
% SETEXPRESSIONATTRIBUTENAMES One or more substitution tokens for attribute names

% Copyright 2019 The MathWorks, Inc.

if ~isa(expressionAttributeNames, 'containers.Map')
    logObj = Logger.getLogger();
    write(logObj,'error','expressionAttributeNames argument not of type containers.Map');
end

keys = expressionAttributeNames.keys();
values = expressionAttributeNames.values();
hMapJ = java.util.HashMap;
for n = 1:numel(keys)
    % add an entry to the HashMap per iteration
    hMapJ.put(keys{n}, values{n});
end

obj.Handle.setExpressionAttributeNames(hMapJ);

end
