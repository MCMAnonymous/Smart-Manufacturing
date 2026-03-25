cd(dataset_name);

S = readtable('data_states.csv');
cd(current_dir);


%% 
x=strcmp(S.Component,'RobotController 1 #1');
s1 = S(x,:);
x=strcmp(s1.State,'BusyHandling');
s1_busy = s1(x,:);
x=strcmp(s1.State,'Idle');
s1_idle = s1(x,:);

x=strcmp(S.Component,'RobotController 2 #1');
s2 = S(x,:);
x=strcmp(s2.State,'BusyHandling');
s2_busy = s2(x,:);
x=strcmp(s2.State,'Idle');
s2_idle = s2(x,:);

x=strcmp(S.Component,'RobotController 3 #1');
s3 = S(x,:);
x=strcmp(s3.State,'BusyHandling');
s3_busy = s3(x,:);
x=strcmp(s3.State,'Idle');
s3_idle = s3(x,:);

x=strcmp(S.Component,'RobotController 4 #1');
s4 = S(x,:);
x=strcmp(s4.State,'BusyHandling');
s4_busy = s4(x,:);
x=strcmp(s4.State,'Idle');
s4_idle = s4(x,:);

x=strcmp(S.Component,'RobotController 5 #1');
s5 = S(x,:);
x=strcmp(s5.State,'BusyHandling');
s5_busy = s5(x,:);
x=strcmp(s5.State,'Idle');
s5_idle = s5(x,:);

x=strcmp(S.Component,'RobotController 6 #1');
s6 = S(x,:);
x=strcmp(s6.State,'BusyHandling');
s6_busy = s6(x,:);
x=strcmp(s6.State,'Idle');
s6_idle = s6(x,:);

x=strcmp(S.Component,'RobotController 7 #1');
s7 = S(x,:);
x=strcmp(s7.State,'BusyHandling');
s7_busy = s7(x,:);
x=strcmp(s7.State,'Idle');
s7_idle = s7(x,:);

x=strcmp(S.Component,'HumanLine #1');
sH = S(x,:);
x=strcmp(sH.State,'Moving');
sH_moving = sH(x,:);
% x=strcmp(sH.State,'Idle');
% sH_idle = sH(x,:);



sini = [s1_busy; s2_busy];
sini = sortrows(sini, 'TimeStamp');
sini_idle = [s1_idle; s2_idle];
sini_idle = sortrows(sini_idle, 'TimeStamp');

l=length(s6_busy.TimeStamp);
ini_states=[sini.TimeStamp(1:l) s3_busy.TimeStamp(1:l) s4_busy.TimeStamp(1:l) s5_busy.TimeStamp(1:l) s6_busy.TimeStamp(1:l)];
l=length(s6_idle.TimeStamp);
ini_states_idle=[sini_idle.TimeStamp(1:l) s3_idle.TimeStamp(1:l) s4_idle.TimeStamp(1:l) s5_idle.TimeStamp(1:l) s6_idle.TimeStamp(1:l)];

%% 
[x,y] = find(ini_states(:,1) >= msg_time_aux(1));

fila_states = x(1);

stem(ini_states(fila_states,:)-msg_time_aux(1), 10000000*ones(length(ini_states(fila_states,:)),1) );
stem(ini_states_idle(fila_states,:)-msg_time_aux(1), 10000000*ones(length(ini_states_idle(fila_states,:)),1) );


[x,y] = find(s7_busy.TimeStamp >= ini_states(fila_states,end) & s7_busy.TimeStamp <= ini_states(fila_states+1,end));

if ~isempty(x)
    length(x)
    stem(s7_busy(x(1),:).TimeStamp-msg_time_aux(1), 10000000);
    stem(s7_idle(x(1),:).TimeStamp-msg_time_aux(1), 10000000);
end

[x,y] = find(sH_moving.TimeStamp >= ini_states(fila_states,end) & sH_moving.TimeStamp <= ini_states(fila_states+1,end));

if ~isempty(x)
    length(x)
    stem(sH_moving(x(1),:).TimeStamp-msg_time_aux(1), 10000000);
    % stem(s7_idle(x(1),:).TimeStamp-msg_time_aux(1), 5000);
end