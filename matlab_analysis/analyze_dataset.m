% indicate the dataset to analyze
current_dir = cd();
dataset_name = '../datasets/Dataset_Normal_3AGVs';
malfunction_flag = false;

cd(dataset_name);

% Read data_communications.csv
T = readtable('data_communications.csv');

cd(current_dir);

%% 1. Get all possible values for Transmitter, Receiver and MessageType
% 
% tx: list of components that act as origin of the messages
% rx: list of components that act as destiination of the messages
% msg: list of messages exchanged in the scenario. All messages are
%       described in Table III of the paper:
%       [1] M. Carmen Lucas-Estañ, Javier Gozálvez, Eloy González-Amor, 
%       Jorge Gómez-Jerez, Fernando Ubis, "Open Industrial Datasets for 
%       Data-Driven Industrial Networks and Manufacturing Systems", in XXXX.

tx=unique(T.Transmitter);
rx=unique(T.Receiver);
msg=unique(T.MessageType);

%% 2. Filter messages generated in each production line

% filter messages generated in production line 1
rows = endsWith(T.Transmitter, "#1");
T_line1 = T(rows, :);
% These transmitters do not belong to production line 1
rows = strcmp(T_line1.Transmitter, 'OutShelfFromConveyor #1');
T_line1(rows, :) = [];
rows = strcmp(T_line1.Transmitter, 'OutShelfToConveyor #1');
T_line1(rows, :) = [];
rows = strcmp(T_line1.Transmitter, 'InboundShelf #1');
T_line1(rows, :) = [];
rows = strcmp(T_line1.Transmitter, 'AGV #1');
T_line1(rows, :) = [];
rows = strcmp(T_line1.Transmitter, 'OutboundShelf #1');
T_line1(rows, :) = [];

% filter messages generated in production line 2
rows = endsWith(T.Transmitter, "#2");
T_line2 = T(rows, :);
% These transmitters do not belong to production line 2
rows = strcmp(T_line2.Transmitter, 'InboundShelf #2');
T_line2(rows, :) = [];
rows = strcmp(T_line2.Transmitter, 'OutboundShelf #2');
T_line2(rows, :) = [];
rows = strcmp(T_line2.Transmitter, 'AGV #2');
T_line2(rows, :) = [];

% filter messages generated in production line 3
rows = endsWith(T.Transmitter, "#3");
T_line3 = T(rows, :);
% These transmitters do not belong to production line 3
rows = strcmp(T_line3.Transmitter, 'AGV #3');
T_line3(rows, :) = [];



%% 3. Filter aperiodic and periodic messages
% filter aperiodic messages
rows = strcmp(T_line1.CommunicationType, 'a');
T_line1_aperiodic = T_line1(rows, :);

rows = strcmp(T_line2.CommunicationType, 'a');
T_line2_aperiodic = T_line2(rows, :);

rows = strcmp(T_line3.CommunicationType, 'a');
T_line3_aperiodic = T_line3(rows, :);

% filter periodic messages
rows = strcmp(T_line1.CommunicationType, 'p');
T_line1_periodic = T_line1(rows, :);

rows = strcmp(T_line2.CommunicationType, 'p');
T_line2_periodic = T_line2(rows, :);

rows = strcmp(T_line3.CommunicationType, 'p');
T_line3_periodic = T_line3(rows, :);

%% 4. Search for temporal generation patterns in the data messages produced by components within the press lines
% Load message generation sequence
% 
% We load the variables containing the message flow generated within a 
% production line. This message flow has been identified by following the 
% processing sequence of a steel sheet in a press line. By knowing the 
% generated data flow, we can analyze the inter-packet time and identify 
% potential patterns in data generation, if any exist.
% 
% Pay attention!!!! Some times the orden of the packets that are generated
% at the same time can change. This must be updated in the
% define_msg_patterns_lx script. This is the reason to define a different
% pattern for each line
% 
define_msg_patterns_l1;
define_msg_patterns_l2;
define_msg_patterns_l3;


% column index corresponding to origin (itx), destination (irx) and message type (imsg)
itx = 1;
irx = 2;
imsg = 3;


m_time = cell(3, 1);
ind_m = cell(3, 1);
ind_mQ = cell(3, 1);
ind_mEnd = cell(3, 1);
% msg_time saves time of generation of each data message in msg_pattern_l
msg_time = cell(3, 1);
% msg_time_dif saves time different between the generation of each data 
% message in msg_pattern_l with respect to the first data message in msg_pattern_l
msg_time_dif = cell(3, 1);
% msg_time_dif3 saves time different between the generation of each data 
% message in msg_pattern_l with respect to the third data message in msg_pattern_l
msg_time_dif3 = cell(3, 1);
% data_time saves size of the data generated of each data message in msg_pattern_l 
data_time = cell(3, 1);
dift_fp = cell(3, 1);
dift3 = cell(3,1);

for line=1:3
    m=[];
    flag_PressState_Press1 = 0;
    flag_PressState_Press2 = 0;
    flag_PressState_Press3 = 0;
    flag_PressState_ACK = 0;
    flag_ConveyorState_ACK = 0; 
    flag_QualityNodeState_ACK = 0;
    flag_QualityCameraData = 0;

    switch line
        case 1
            T_aperiodic = T_line1_aperiodic;
            msg_pattern_l = msg_pattern_l1;
            msg_pattern_l_end = msg_pattern_l1_end;
        case 2
            T_aperiodic = T_line2_aperiodic;
            msg_pattern_l = msg_pattern_l2;
            msg_pattern_l_end = msg_pattern_l2_end;
        case 3
            T_aperiodic = T_line3_aperiodic;
            msg_pattern_l = msg_pattern_l3;
            msg_pattern_l_end = msg_pattern_l3_end;
    end
    l = length(msg_pattern_l);
    
    for i=1:l
        if msg_pattern_l(i, imsg) == "FeedCommand"
            switch line
                case 1
                    [maux,~] = find((T_aperiodic.Transmitter == "RobotController 1 #1" | T_aperiodic.Transmitter == "RobotController 2 #1") & (T_aperiodic.Receiver == "FeedLineRobot 1 #1" | T_aperiodic.Receiver == "FeedLineRobot 2 #1") & T_aperiodic.MessageType == msg_pattern_l(i, imsg));
                case 2
                    [maux,~] = find((T_aperiodic.Transmitter == "RobotController 1 #2" | T_aperiodic.Transmitter == "RobotController 2 #2") & (T_aperiodic.Receiver == "FeedLineRobot 1 #2" | T_aperiodic.Receiver == "FeedLineRobot 2 #2") & T_aperiodic.MessageType == msg_pattern_l(i, imsg));
                case 3
                    [maux,~] = find((T_aperiodic.Transmitter == "RobotController 1 #3" | T_aperiodic.Transmitter == "RobotController 2 #3") & (T_aperiodic.Receiver == "FeedLineRobot 1 #3" | T_aperiodic.Receiver == "FeedLineRobot 2 #3") & T_aperiodic.MessageType == msg_pattern_l(i, imsg));
            end
        else
            [maux,~] = find(T_aperiodic.Transmitter == msg_pattern_l(i, itx) & T_aperiodic.Receiver == msg_pattern_l(i, irx) & T_aperiodic.MessageType == msg_pattern_l(i, imsg));
        end
    
        % if i == 1
        %     % quito los 5 primeros valores pues el sistema todavía no se ha
        %     % estabilizado
        %     maux = maux(5:end);
        %     [x,y] = find(T_aperiodic.Iteration < T_aperiodic.Iteration(maux(1)));
        %     T_aperiodic(x,:) = [];
        %     maux = maux - maux(1) + 1;
        %     laux = length(maux);
        % else
        %     while maux(1) <= m(1, end)
        %         maux =maux(2:end);
        %     end
        % end
        if msg_pattern_l(i, imsg) == "PressState" || msg_pattern_l(i, imsg) == "ConveyorState" || msg_pattern_l(i, imsg) == "CameraData"
            maux = maux(2*5-1:end);
        else
            maux = maux(5:end);
        end

        if i == 1
            laux = length(maux);
        else
            while maux(1) <= m(1, end)
                % if msg_pattern_l(i, imsg) == "PressState" || msg_pattern_l(i, imsg) == "ConveyorState" || msg_pattern_l(i, imsg) == "CameraData"
                %     maux =maux(3:end);
                % else
                    maux =maux(2:end);
                % end
            end
        end
        
        if msg_pattern_l(i, imsg) == "PressState"
            if msg_pattern_l(i, itx) == sprintf("UWICORE Press 1 #%d", line)
                if flag_PressState_Press1 == 0
                    flag_PressState_Press1 = 1;
                    flag_PressState_ACK = 2;
                    maux = maux(1:2:end,:);
                elseif msg_pattern_l(i-2, imsg) == "PressState" && msg_pattern_l(i-2, itx) == msg_pattern_l(i, itx) && msg_pattern_l(i, irx) ~= msg_pattern_l(i-2, irx) 
                    maux = maux(1:2:end,:);
                    flag_PressState_ACK = flag_PressState_ACK - 1;
                else
                    maux = maux(1:2:end,:);
                end
            elseif msg_pattern_l(i, itx) == sprintf("UWICORE Press 2 #%d", line) 
                if flag_PressState_Press2 == 0
                    flag_PressState_Press2 = 1;
                    flag_PressState_ACK = 2;
                    maux = maux(1:2:end,:);
                elseif msg_pattern_l(i-2, imsg) == "PressState" && msg_pattern_l(i-2, itx) == msg_pattern_l(i, itx) && msg_pattern_l(i, irx) ~= msg_pattern_l(i-2, irx) 
                    maux = maux(1:2:end,:);
                    flag_PressState_ACK = flag_PressState_ACK - 1;
                else
                    maux = maux(1:2:end,:);
                end
            elseif msg_pattern_l(i, itx) == sprintf("UWICORE Press 3 #%d", line) 
                if flag_PressState_Press3 == 0
                    flag_PressState_Press3 = 1;
                    flag_PressState_ACK = 1;
                    maux = maux(1:2:end,:);
                elseif msg_pattern_l(i-2, imsg) == "PressState" && msg_pattern_l(i-2, itx) == msg_pattern_l(i, itx) && msg_pattern_l(i, irx) ~= msg_pattern_l(i-2, irx) 
                    maux = maux(1:2:end,:);
                    flag_PressState_ACK = flag_PressState_ACK - 1;
                else
                    maux = maux(1:2:end,:);
                end
            end
        elseif i > 1 && msg_pattern_l(i-1, imsg) == "PressState" && flag_PressState_Press1 == 1 && msg_pattern_l(i, imsg) == "ACK"
            if flag_PressState_ACK >= 1
                maux = maux(1:2:end,:);
            else
                maux = maux(1:2:end,:);
                flag_PressState_Press1 = 0;
            end
        elseif i > 1 && msg_pattern_l(i-1, imsg) == "PressState" && flag_PressState_Press2 == 1 && msg_pattern_l(i, imsg) == "ACK"
            if flag_PressState_ACK >= 1
                maux = maux(1:2:end,:);
            else
                maux = maux(1:2:end,:);
                flag_PressState_Press2 = 0;
            end
        elseif i > 1 && msg_pattern_l(i-1, imsg) == "PressState" && flag_PressState_Press3 == 1 && msg_pattern_l(i, imsg) == "ACK"
            if flag_PressState_ACK >= 1
                maux = maux(1:2:end,:);
            else
                maux = maux(1:2:end,:);
                flag_PressState_Press3 = 0;
            end
        end
    
        if msg_pattern_l(i, imsg) == "ConveyorState" 
            maux = maux(1:2:end,:);
            flag_ConveyorState_ACK = 1;
        elseif flag_ConveyorState_ACK == 1 && msg_pattern_l(i-1, imsg) == "ConveyorState" && msg_pattern_l(i, imsg) == "ACK"
            maux = maux(1:2:end,:);
            flag_ConveyorState_ACK = 0;
        end
    
        if msg_pattern_l(i, imsg) == "SheetInQualityControlArea" 
            maux = maux(1:2:end,:);
            flag_QualityNodeState_ACK = 1;
        elseif flag_QualityNodeState_ACK == 1 && msg_pattern_l(i-1, imsg) == "SheetInQualityControlArea" && msg_pattern_l(i, imsg) == "ACK"
            maux = maux(1:2:end,:);
            flag_QualityNodeState_ACK = 0;
        end
    
        maux2 = [];
        if msg_pattern_l(i, imsg) == "CameraData" 
            m_QualityCameraData = maux;
            break;
            mm = m(:,end);
            for j=1:length(mm)-1
                if mm(j) == -1
                    continue;
                end
                [x,y] = find(maux>mm(j) & maux<mm(j+1));
                s = size(maux2);
                a = maux(x)';
                if length(x) > s(2) && s(2) > 0
                    maux2(:,end+1:length(x)) = NaN;
                elseif s(2) > length(x)
                    a = [a NaN*ones(1, s(2)-length(x))];
                end
                maux2 = [maux2; a];

            end
            maux = maux2;
            flag_QualityCameraData = 1;
            % diff_t = T_aperiodic.Timestamp(maux(2:end)) - T_aperiodic.Timestamp(maux(1:end-1));
            % [x,y] = find(diff_t <= 0.065 | diff_t >= 0.067);
            % [x_nonZero,y] = find(diff_t > 0 & (diff_t <= 0.065 | diff_t >= 0.067));
            % if diff_t(1) == 0
            %     maux2 = [maux(x(1):x_nonZero(1))'];
            % else
            %     maux2 = [maux(x_nonZero(1):x_nonZero(2))'];
            % end
            % for j = 2: length(x_nonZero) - 1
            %     s = size(maux2);
            %     a = maux(x_nonZero(j)+1:x_nonZero(j+1))';
            %     if s(2) > length(a)
            %         a = [a NaN*ones(1, s(2)-length(a))];
            %     elseif s(2) < length(a)
            %         maux2(:,end+1:length(a)) = NaN;
            %     end
            %     maux2 = [maux2; a];
            % end
        end
        
        s = size(maux);
        if s(1) < laux
            maux = [maux; -1*ones(laux-length(maux),s(2))];
        end
        if length(maux) > laux
            disp('Attention');
        end
        m = [m maux];
        if flag_QualityCameraData == 1
            flag_QualityCameraData = 0;
            break;
        end
    end
    
    l = length(msg_pattern_l_end);
    m2 = [];
    
    flag_QualityNodeState_ACK = 0;
    for i=1:l
        [maux,~] = find(T_aperiodic.Transmitter == msg_pattern_l_end(i, itx) & T_aperiodic.Receiver == msg_pattern_l_end(i, irx) & T_aperiodic.MessageType == msg_pattern_l_end(i, imsg));

        if i == 1
            vaux = m(1, end);
        else
            vaux = m2(1, end);
        end

        while maux(1) <= vaux
            maux =maux(2:end);
        end

        if msg_pattern_l_end(i, imsg) == "SheetInQualityControlArea" 
            maux = maux(1:2:end,:);
            flag_QualityNodeState_ACK = 1;
        elseif flag_QualityNodeState_ACK == 1 && msg_pattern_l_end(i-1, imsg) == "SheetInQualityControlArea" && msg_pattern_l_end(i, imsg) == "ACK"
            maux = maux(1:2:end,:);
            flag_QualityNodeState_ACK = 0;
        end

        if msg_pattern_l_end(i, imsg) == "CameraData" 
            continue;
        end
        if msg_pattern_l_end(i, imsg) == "QualityResult" 
            maux2 = maux - 1;
            [x, y] = find(T_aperiodic.MessageType(maux2) ~= "CameraData")
            if isempty(x)
                if length(maux) < laux
                    maux = [maux; -1*ones(laux-length(maux),1)];
                    maux2 = [maux2; -1*ones(laux-length(maux2),1)];
                end            
                m2 = [m2 maux2 maux];
                continue;
            end
        end

        if length(maux) < laux
            maux = [maux; -1*ones(laux-length(maux),1)];
        end
        if length(maux) > laux
            disp('Attention');
        end
        m2 = [m2 maux];

    end
    s = size(m);
    mQ = cell(0,1);
    for i = 1:s(1)
        [x,y] = find(m_QualityCameraData > m(i,end) & m_QualityCameraData < m2(i,1));
        mQ{end+1,1} = m_QualityCameraData(x);
    end
    switch line
        case 1
            mQ1 = mQ;
        case 2
            mQ2 = mQ;
        case 3
            mQ3 = mQ;
    end

    aux = m(1:end-12,:);
    ind_m{line} = m(1:end-12,:);
    ind_mQ{line} = mQ(1:end-12,:);
    ind_mEnd{line} = m2(1:end-12,:);
    % m_time{line} = [ind_m{line} ind_mQ{line} ind_mEnd{line}];
    msg_time_dif{line} = T_aperiodic.Timestamp(aux) - T_aperiodic.Timestamp(aux(:,1));
    msg_time_dif3{line} = T_aperiodic.Timestamp(aux) - T_aperiodic.Timestamp(aux(:,3));
    msg_time{line} = T_aperiodic.Timestamp(aux);
    data_time{line} = T_aperiodic.DataSize(aux);

    aux = T_aperiodic.Timestamp(aux);
    dift_fp{line} = aux(2:end,1) - aux(1:end-1,1);
    dift3{line} = aux(2:end,3) - aux(1:end-1,3);
    
end



%% 5. Generate a figure representing the generation time of data produced by components within the press lines due to the production of a steel sheet (Figure 9.b in [1])
% m_time=m(1:end-7,:);
% msg_time = T_aperiodic.Timestamp(m_time) - T_aperiodic.Timestamp(m_time(:,1));
% data_time = T_aperiodic.DataSize(m_time);
    
% select a press line and a row of the matrix ind_m{line}
line = 1;
row_i = 2000;

switch line
    case 1
        T_aperiodic = T_line1_aperiodic;
    case 2
        T_aperiodic = T_line2_aperiodic;
    case 3
        T_aperiodic = T_line3_aperiodic;
end

ind_m_aux = ind_m{line};
ind_mQ_aux = ind_mQ{line};
ind_mEnd_aux = ind_mEnd{line};
m = [ind_m_aux(row_i,:) ind_mQ_aux{row_i}' ind_mEnd_aux(row_i,:)];
msg_time_aux = T_aperiodic.Timestamp(m);
msg_time_dif_aux = T_aperiodic.Timestamp(m) - T_aperiodic.Timestamp(m(1));
data_time_aux = T_aperiodic.DataSize(m);
msg_aux = T_aperiodic.MessageType(m);

% msg_time_aux2 = msg_time{line};
% msg_time_dif_aux2 = msg_time_dif{line};
% data_time_aux2 = data_time{line};
% time_aux = msg_time_aux(row_i,:);
% [t_uniq, ~, idx] = unique(msg_time_dif_aux(row_i,:)); 
% data_agg = accumarray(idx, data_time_aux(row_i,:)', [], @sum); 

[t_uniq, ~, idx] = unique(msg_time_dif_aux); 
data_agg = accumarray(idx, data_time_aux', [], @sum); 

figure;
hold on;
stem(t_uniq, data_agg, 'b.');
l = length(msg_time_aux);
% disp([msg_time_aux(row_i,:)'-msg_time_aux(row_i,1) msg_pattern_l1(1:l,3)]);

% Represent in the figure the moments when robotic arms in the line transition between the BusyHandling and Idle states 
script_states;
set(gca,'YScale','log');
box;
grid;
xlabel('Time (s)');
ylabel('Size (bytes)');

%% 6. Representation of the generation time of all data produced by the components within a press line (Figure 9.b in [1])

if malfunction_flag == true
    % Represent a time period when a AGV malfunction occurs
    F = readtable('data_Failures_AGV #2.csv');
    malfunction_i = 1;
    
    time_ini = F.TimeStamp((malfunction_i-1)*2+1)-200;
    time_end = time_ini+3000;
else
    time_ini = 7000;
    time_end = 7300;
end

[m,n] = size(ind_m_aux);
ind_m_aux = reshape(ind_m_aux, 1, m*n);

ind_mQ_aux = cellfun(@(x) x(:).', ind_mQ_aux, 'UniformOutput', false);  % convierte cada uno en fila
ind_mQ_aux = [ind_mQ_aux{:}];

[m,n] = size(ind_mEnd_aux);
ind_mEnd_aux = reshape(ind_mEnd_aux, 1, m*n);
ind_mEnd_aux = ind_mEnd_aux(ind_mEnd_aux > 0);

msg_time_aux = T_aperiodic.Timestamp([ind_m_aux ind_mQ_aux ind_mEnd_aux]);
data_time_aux = T_aperiodic.DataSize([ind_m_aux ind_mQ_aux ind_mEnd_aux]);
[m,n] = find(msg_time_aux >= time_ini & msg_time_aux <= time_end);
[t_uniq, ~, idx] = unique(msg_time_aux(m)); 
data_agg = accumarray(idx, data_time_aux(m)', [], @sum); 

% msg_time_aux = msg_time{line};
% 
% [m,n] = size(msg_time_aux);
% msg_time_aux = reshape(msg_time_aux, m*n, 1);
% data_time_aux = reshape(data_time_aux, m*n, 1);
% 
% [m,n] = find(msg_time_aux >= time_ini & msg_time_aux <= time_end);
% [t_uniq, ~, idx] = unique(msg_time_aux(m)); 
% data_agg = accumarray(idx, data_time_aux(m)', [], @sum); 

figure;
hold on;
stem(t_uniq, data_agg, 'b.');

% Represent in the figure the moments when robotic arms in the line transition between the BusyHandling and Idle states 
script_states_2;
set(gca,'YScale','log');
box;
grid;
xlabel('Time (s)');
ylabel('Size (bytes)');

if malfunction_flag == true
    % Represent when malfunctions occur 
    ind = (malfunction_i-1)*2+1;
    stem(F.TimeStamp(ind:ind+3), 10000000*ones(4,1) );
end


% 
% figure2 = figure;
% hold on;
% histogram(msg_time(:,1));
