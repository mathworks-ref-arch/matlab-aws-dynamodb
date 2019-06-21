classdef Item < aws.Object
% ITEM Constructs a new Item object
% An Item is constructed based on the equivalent underlying Java SDK object.

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = Item(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.document.Item();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.Item')
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.Item');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
