function [] = read_volume()
    global volume FR t s pump_id pressure real_time time;
    t = t+1;
    
     time(t) = toc(real_time);

    
    temp = ISCO_comm(s,pump_id,'VOLA');   % Get current volume
    ind = find(temp=='=');
    volume(t) = str2double(temp(ind+1:end));
    
    temp = ISCO_comm(s,pump_id,'PRESSA');   % Get current volume
    ind = find(temp=='=');
    pressure(t) = str2double(temp(ind+1:end));
    
    temp = ISCO_comm(s,pump_id,'FLOWA');   % Get current volume
    ind = find(temp=='=');
    FR(t) = str2double(temp(ind+1:end));
    
    disp(['> Measure ' num2str(t) ' : time ' num2str(time(t)) ', pressure ' num2str(pressure(t)) ', volume ' num2str(volume(t)) ', flowrate ' num2str(FR(t))])

    
