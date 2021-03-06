classdef DeleteItemOutcome < aws.Object
% DELETEITEMOUTCOME Constructs a new DeleteItemOutcome object

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = DeleteItemOutcome(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.document.DeleteItemOutcome();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.DeleteItemOutcome')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.DeleteItemOutcome');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
