classdef CreateTableRequest < aws.Object
% CREATETABLEREQUEST Object to represent a createTable request

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = CreateTableRequest(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.CreateTableRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.CreateTableRequest')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.CreateTableRequest');
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
