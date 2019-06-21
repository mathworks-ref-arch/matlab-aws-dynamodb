classdef PutItemRequest < aws.Object
% PUTITEMREQUEST Object to represent a PutItem request
%
% Example:
%    putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
%    putItemResult = ddb.putItem(putItemRequest);

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = PutItemRequest(varargin)
        logObj = Logger.getLogger();

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.PutItemRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.PutItemRequest')
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.PutItemRequest');
            end
            obj.Handle = varargin{1};
        elseif nargin == 2
            if ~ischar(varargin{1})
                write(logObj,'error','table name argument not of type character vector');
            end
            key = varargin{2};
            if ~isa(key, 'containers.Map')
                write(logObj,'error','key argument not of type containers.Map');
            end
            keyKeys = key.keys();
            keyValues = key.values();
            hMapJ = java.util.HashMap;
            for n = 1:numel(keyKeys)
                % add an entry to the HashMap per iteration
                hMapJ.put(keyKeys{n}, keyValues{n}.Handle);
            end
            obj.Handle = com.amazonaws.services.dynamodbv2.model.PutItemRequest(varargin{1}, hMapJ);
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
