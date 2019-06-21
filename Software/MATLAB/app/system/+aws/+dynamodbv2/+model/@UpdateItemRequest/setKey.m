function setKey(obj, key)
% SETKEY Sets primary key of the item to be updated

% Copyright 2019 The MathWorks, Inc.

if ~isa(key, 'containers.Map')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected key of type containers.Map');
end

keys = key.keys();
values = key.values();
hMapJ = java.util.HashMap;
for n = 1:numel(keys)
    % add an entry to the HashMap per iteration
    hMapJ.put(keys{n}, values{n}.Handle);
end

obj.Handle.setKey(hMapJ);

end
