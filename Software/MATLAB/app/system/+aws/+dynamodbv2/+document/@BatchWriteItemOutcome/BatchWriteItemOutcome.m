classdef BatchWriteItemOutcome < aws.Object
% BATCHWRITEITEMOUTCOME Constructs a new BatchWriteItemOutcome object

% Copyright 2020 The MathWorks, Inc.

methods
    function obj = BatchWriteItemOutcome(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.document.BatchWriteItemOutcome();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.BatchWriteItemOutcome')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.BatchWriteItemOutcome');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
