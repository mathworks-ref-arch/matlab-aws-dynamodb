function arn = getTableArn(obj)
% GETTABLEARN Returns the ARN of a table as a character vector

% Copyright 2019 The MathWorks, Inc.

arn = char(obj.Handle.getTableArn());

end
