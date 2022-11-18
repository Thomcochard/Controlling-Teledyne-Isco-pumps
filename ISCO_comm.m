% Single ISCO command-response sequence
% Note: The controller acknowledges each command, so each "write" must be
% followed by a "read" to flush the buffer

function [response]=ISCO_comm(s,pump_id,command)

dasout = das_out(pump_id,command); % Convert to DASNET format
fprintf(s,[dasout '\n']);
out = fscanf(s); 
response = das_in(out); % Remove DASNET characters