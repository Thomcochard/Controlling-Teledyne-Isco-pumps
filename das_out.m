% Convert a string into DASNET format
% in = input string, out = output string
function [out]=das_out(pump_id, in)

out=[num2str(pump_id) 'R']; % put pump ID and "R" (previous message received)

if (strcmp(in,'R'))  % if input string is just "R", add space to string (no message)
    out=[out ' '];
else  % add number of message characters and the message itself to the string
    out=[out num2str(length(in),'%3.3X') in];
end

sum=0;
for i=1:length(out)   % add all characters together
    sum=sum+uint16(out(i));
end

% calculate check sum (2^16 added to keep first operand positive)
sum=bitand((2^16 + 256 - sum),255);

csum=num2str(sum,'%2.2X');
out=[out csum]; % insert into string