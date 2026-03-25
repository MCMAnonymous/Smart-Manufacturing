function [t_uniq, data_agg]=represent_data_time(time, data, time_ini, time_end, S)
% Represents the total size (data) and generation time (time) of the data produced 
% in the time interval given by [time_ini, time_end].
% The figure also includes the times when robotic arm controllers
% transition to BusyHandling state read from S.


[m,n] = find(time >= time_ini & time <= time_end);
[t_uniq, ~, idx] = unique(time(m)); 
data_agg = accumarray(idx, data(m)', [], @sum); 

figure;
hold on;
stem(t_uniq, data_agg, 'b.');

box;
set(gca,'XLim',[time_ini time_end]);
set(gca,'YScale','log');
set(gca,'YLim',[1 10^7]);
box();
ylabel('Size (bytes)');
xlabel('Time (s)');
set(gca,'YTick',[1 10 100 1000 10000 100000 1000000 100000000]);
set(gca,'YTickLabel',{1 '' '10^2' '' '10^4' '' '10^6' 100000000});
% set(gca,'XTick',7496+[0:10:100]);
% set(gca,'XTickLabel',[0:10:100]);
% legend('Data','BusyHandling')

for linea=1:3
    switch linea
        case 1
            x=strcmp(S.Component,'RobotController 1 #1');
            s1 = S(x,:);
            x=strcmp(S.Component,'RobotController 2 #1');
            s2 = S(x,:);
        case 2
            x=strcmp(S.Component,'RobotController 1 #2');
            s1 = S(x,:);
            x=strcmp(S.Component,'RobotController 2 #2');
            s2 = S(x,:);
        case 3
            x=strcmp(S.Component,'RobotController 1 #3');
            s1 = S(x,:);
            x=strcmp(S.Component,'RobotController 2 #3');
            s2 = S(x,:);
    end
    x=strcmp(s1.State,'BusyHandling');
    s1_busy = s1(x,:);
    % x=strcmp(s1.State,'Idle');
    % s1_idle = s1(x,:);
    x=strcmp(s2.State,'BusyHandling');
    s2_busy = s2(x,:);
    % x=strcmp(s2.State,'Idle');
    % s2_idle = s2(x,:);
    sini = [s1_busy; s2_busy];
    sini = sortrows(sini, 'TimeStamp');


    x=strcmp(S.Component,'RobotController 1 #1');
    s1 = S(x,:);
    x=strcmp(s1.State,'BusyHandling');
    s1_busy = s1(x,:);
    % x=strcmp(s1.State,'Idle');
    % s1_idle = s1(x,:);
    
    x=strcmp(S.Component,'RobotController 2 #1');
    s2 = S(x,:);
    x=strcmp(s2.State,'BusyHandling');
    s2_busy = s2(x,:);
    % x=strcmp(s2.State,'Idle');
    % s2_idle = s2(x,:);
    sini_l1 = [s1_busy; s2_busy];
    sini_l1 = sortrows(sini, 'TimeStamp');
    
    [m,n] = find(sini.TimeStamp >= time_ini & sini.TimeStamp <= time_end);
    stem(sini(m,:).TimeStamp, 1000000000*ones(length(m),1));
end