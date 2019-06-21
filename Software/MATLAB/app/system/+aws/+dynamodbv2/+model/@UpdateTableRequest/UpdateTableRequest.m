classdef UpdateTableRequest < aws.Object
% UPDATETABLEREQUEST Object to represent a updateTable request

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = UpdateTableRequest(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.UpdateTableRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.UpdateTableRequest')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.UpdateTableRequest');
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
