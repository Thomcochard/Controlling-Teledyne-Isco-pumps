% Extract message from a DASNET response
% in = input string, out = output string
function [out]=das_in(in)

len=length(in);
if len<7 % No message present
    out=[];
else % Message present
    % Remove acknowledgement, message destination, length, checksum, final [CR]
    out=in(5:len-3);
end