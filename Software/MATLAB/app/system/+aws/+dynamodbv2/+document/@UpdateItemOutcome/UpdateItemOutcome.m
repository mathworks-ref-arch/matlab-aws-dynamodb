classdef UpdateItemOutcome < aws.Object
% UPDATEITEMOUTCOME Constructs a new UpdateItemOutcome object
% A UpdateItemOutcome is constructed based on the equivalent underlying Java SDK
% object.

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = UpdateItemOutcome(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
