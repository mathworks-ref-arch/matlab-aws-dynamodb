classdef GetItemRequest < aws.Object
% GETITEMREQUEST Object to represent a GetItem request
% If calling with table name and key arguments then the table name should be of
% type character vector and the key should be a containers.Map of keys and values
% of type AttributeValue.
%
% Example:
%    % Constructors
%    getItemRequest = GetItemRequest();
%    getItemRequest = GetItemRequest(GetItemRequestJavaObject);
%    getItemRequest = GetItemRequest(tableName, key);


% Copyright 2019 The MathWorks, Inc.

methods
    function obj = GetItemRequest(varargin)
        logObj = Logger.getLogger();

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.GetItemRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.GetItemRequest')
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.GetItemRequest');
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
            obj.Handle = com.amazonaws.services.dynamodbv2.model.GetItemRequest(varargin{1}, hMapJ);
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
