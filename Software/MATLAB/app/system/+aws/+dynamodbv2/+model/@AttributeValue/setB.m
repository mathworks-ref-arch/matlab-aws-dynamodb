function setB(obj, B)
% SETB An attribute of type Binary
% B is of type uint 8
% Attribute must be greater than less than 400KB in size. If a primary key
% attribute is defined as a binary type attribute, the following additional
% constraints apply:
%  *  For a simple primary key, the maximum length of the first attribute value
%     (the partition key) is 2048 bytes.
%  *  For a composite primary key, the maximum length of the second attribute
%     value (the sort key) is 1024 bytes.

% Copyright 2019 The MathWorks, Inc.

import java.nio.*

if ~isa(B, 'uint8')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected B of type uint8');
end

% 409600 == 400KB
if numel(B) < 1 || numel(B) > 409600
    logObj = Logger.getLogger();
    write(logObj,'error','Invalid input size');
end

bytebufferJ	= java.nio.ByteBuffer.wrap(B);
obj.Handle.setB(bytebufferJ);

end
