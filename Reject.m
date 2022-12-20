clear;clc;eeglab
datapath = 'E:\Jiang in 2022\TF in aes\TF_data\';
subj = load("cnt_name.txt");
subj_num = length(subj);
trial_num = 288;

rejects = zeros(subj_num, trial_num);
events = zeros(subj_num, trial_num);

for i = 1 : subj_num
    i
    subj_id = num2str(subj(i));
    
    EEG = pop_loadset('filename',[subj_id 'reject.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.reject\\');
    EEG = eeg_checkset( EEG );
    
%     reject = EEG.reject.rejthresh;
%     L = length(reject);
%     rejects(i, 1:L) = reject;
    
    event = {EEG.event.type};
    L = length(event);
    events(i, 1:L) = cell2mat(event);
end

edge = length(rejects(1,:));
edge = length(events(1,:));

for i = 1 : subj_num
    i
    subj_id = num2str(subj(i));
    
    EEG = pop_loadset('filename',[subj_id 'reject.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.reject\\');
    EEG = eeg_checkset( EEG );
    
%     reject = EEG.reject.rejthresh;
%     L = length(reject);
%     rejects(i, edge + 1) = L;
        
    event = {EEG.event.type};
    L = length(event);
    rejects(i, edge + 1) = L;
end
% save('rejects.mat', 'rejects');
save('events.mat', 'events');