classdef AttributeAction < aws.Object
    % ATTRIBUTEACTION Enumeration of attribute actions
    % Possible values are: ADD, PUT or DELETE
    % a toJava() method returns the equivalent Java enumeration.

    % Copyright 2019 The MathWorks, Inc.

    enumeration
        ADD
        PUT
        DELETE
    end

    methods
        function typeJ = toJava(obj)
            switch obj
            case aws.dynamodbv2.model.AttributeAction.ADD
                    typeJ = com.amazonaws.services.dynamodbv2.model.AttributeAction.ADD;
                case aws.dynamodbv2.model.AttributeAction.PUT
                    typeJ = com.amazonaws.services.dynamodbv2.model.AttributeAction.PUT;
                case aws.dynamodbv2.model.AttributeAction.DELETE
                    typeJ = com.amazonaws.services.dynamodbv2.model.AttributeAction.DELETE;
                otherwise
                    logObj = Logger.getLogger();
                    write(logObj,'error','Invalid aws.dynamodbv2.model.AttributeAction');
            end
        end
    end
end %class
