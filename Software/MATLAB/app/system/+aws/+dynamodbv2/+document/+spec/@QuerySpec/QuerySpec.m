classdef QuerySpec < aws.Object
% QUERYSPEC Constructs a new QuerySpec object
% A QuerySpec is constructed based on the equivalent underlying Java SDK
% object.

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = QuerySpec(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.document.spec.QuerySpec();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.spec.QuerySpec')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.spec.QuerySpec');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
