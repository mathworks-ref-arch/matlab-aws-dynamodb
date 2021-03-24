classdef TableWriteItems < aws.Object
    % TABLEWRITEITEMS Items to be used by a BatchWriteItem request

    % Copyright 2020 The MathWorks, Inc.

    methods
        function obj = TableWriteItems(varargin)

            if nargin == 1
                if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.TableWriteItems')
                    obj.Handle = varargin{1};
                elseif ischar(varargin{1}) || isStringScalar(varargin{1})
                    % varargin{1} is the table name
                    obj.Handle = com.amazonaws.services.dynamodbv2.document.TableWriteItems(varargin{1});
                else
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type character vector, scalar string or com.amazonaws.services.dynamodbv2.document.TableWriteItems');
                end
            else
                logObj = Logger.getLogger();
                write(logObj,'error','Invalid number of arguments');
            end
        end
    end

end
