function result = getB(obj)
% GETB Gets an attribute of type binary
% Result is returned as a uint8.

% Copyright 2019 The MathWorks, Inc.

bytebufferJ = obj.Handle.getB();

if bytebufferJ.hasArray()
    bytes = bytebufferJ.array();
else
    logObj = Logger.getLogger();
    write(logObj,'error','Returned ByteBuffer does not have a backing array');
end

result = typecast(bytes,'uint8');

end
