classdef WriteRequest < aws.Object
% WRITEREQUEST Represents an operation to perform - either DeleteItem or PutItem

% Copyright 2020 The MathWorks, Inc.

methods
    function obj = WriteRequest(varargin)
        import com.amazonaws.services.dynamodbv2.model.WriteRequest

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.WriteRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.WriteRequest')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.WriteRequest');
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
