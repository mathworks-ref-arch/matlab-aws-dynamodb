classdef PrimaryKey < aws.Object
% PRIMARYKEY Constructs a new PrimaryKey object

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = PrimaryKey(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.document.PrimaryKey();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.PrimaryKey')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.PrimaryKey');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
