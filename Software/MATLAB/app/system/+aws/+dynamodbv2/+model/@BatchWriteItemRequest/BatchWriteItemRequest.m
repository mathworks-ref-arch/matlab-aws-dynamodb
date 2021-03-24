classdef BatchWriteItemRequest < aws.Object
% BATCHWRITEITEMREQUEST Object to represent a batchWriteItem request
% A write request batch is limited to 25 items. Multiple BatchWriteRequest can
% be made at once providing catpacity is provisioned.

% Copyright 2020 The MathWorks, Inc.

properties
    requestCount = 0;
    requestLimit = 25;
end


methods
    function obj = BatchWriteItemRequest(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.BatchWriteItemRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.BatchWriteItemRequest')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.BatchWriteItemRequest');
            else
                obj.Handle = varargin{1};
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
