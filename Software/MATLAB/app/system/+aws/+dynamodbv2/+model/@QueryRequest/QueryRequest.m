classdef QueryRequest < aws.Object
% QUERYREQUEST Object to represent a query request

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = QueryRequest(varargin)
        import com.amazonaws.services.dynamodbv2.model.QueryRequest

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.QueryRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.QueryRequest')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.QueryRequest');
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
