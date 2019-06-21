function setExpressionAttributeValues(obj, expressionAttributeValues)
% SETEXPRESSIONATTRIBUTEVALUES One or more values that can be substituted in an expression

% Copyright 2019 The MathWorks, Inc.

if ~isa(expressionAttributeValues, 'containers.Map')
    logObj = Logger.getLogger();
    write(logObj,'error','expressionAttributeValues argument not of type containers.Map');
end

keys = expressionAttributeValues.keys();
values = expressionAttributeValues.values();
hMapJ = java.util.HashMap;
for n = 1:numel(keys)
    % add an entry to the HashMap per iteration
    hMapJ.put(keys{n}, values{n}.Handle);
end

obj.Handle.setExpressionAttributeValues(hMapJ);

end
