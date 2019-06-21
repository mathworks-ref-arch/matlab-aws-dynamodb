classdef AttributeValue < aws.Object
% ATTRIBUTEVALUE Constructs a new AttributeValue object
% An AttributeValue is constructed based on the equivalent underlying
% Java SDK object.
%
% Example:
%    % Constructor calls:
%    attributeValue = AttributeValue();
%    attributeValue = AttributeValue(AttributeValueJavaObject);
%    attributeValue = AttributeValue('myAttributeStr');


% Copyright 2019 The MathWorks, Inc.

methods
    function obj = AttributeValue(varargin)

        if nargin == 0
            obj.Handle = com.amazonaws.services.dynamodbv2.model.AttributeValue();
        elseif nargin == 1
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.AttributeValue')
                obj.Handle = varargin{1};
            elseif ischar(varargin{1})
                obj.Handle = com.amazonaws.services.dynamodbv2.model.AttributeValue(varargin{1});
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.AttributeValue or character vector');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
