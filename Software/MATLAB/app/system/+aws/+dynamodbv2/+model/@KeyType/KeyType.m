classdef KeyType < aws.Object
    % KEYTYPE Enumeration of key types
    % Possible values are HASH or RANGE. A to toJava method returns the Java
    % equivalent.

    % Copyright 2019 The MathWorks, Inc.

    enumeration
        HASH
        RANGE
    end

    methods
        function typeJ = toJava(obj)
            switch obj
                case aws.dynamodbv2.model.KeyType.HASH
                    typeJ = com.amazonaws.services.dynamodbv2.model.KeyType.HASH;
                case aws.dynamodbv2.model.KeyType.RANGE
                    typeJ = com.amazonaws.services.dynamodbv2.model.KeyType.RANGE;
                otherwise
                    logObj = Logger.getLogger();
                    write(logObj,'error','Invalid aws.dynamodbv2.model.KeyType');
            end
        end
    end

end %class
