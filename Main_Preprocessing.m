clear;clc;eeglab
datapath = 'E:\Jiang in 2022\TF in aes\TF_data\';
subj = load("cnt_name.txt");
subj_num = length(subj);

for i = 1% : subj_num
    i
    subj_id = num2str(subj(i));
    
     EEG.etc.eeglabvers = '2020.0'; % this tracks which version of EEGLAB is being used, you may ignore it
     EEG = pop_loadcnt([datapath '00.cntdata_other\' subj_id '.cnt'] , 'dataformat', 'auto', 'memmapfile', '');
     EEG = eeg_checkset( EEG );
     
     EEG=pop_chanedit(EEG, 'lookup','D:\\Program Files\\MATLAB\\R2018b\\toolbox\\eeglab\\eeglab2020_0\\plugins\\dipfit4.3\\standard_BESA\\standard-10-5-cap385.elp');
     EEG = eeg_checkset( EEG );
     
     EEG = pop_reref( EEG, [33 43] ); % ÖØ²Î¿¼M1¡¢M2
     EEG = eeg_checkset( EEG );
     
     EEG = pop_resample( EEG, 250); % ½µ²ÉÑù 250Hz
     EEG = eeg_checkset( EEG );
     
     EEG = pop_eegfiltnew(EEG, 'locutoff',0.1,'hicutoff',100); % ´øÍ¨ÂË²¨0.1-100Hz
     EEG = eeg_checkset( EEG );
     
     EEG = pop_eegfiltnew(EEG, 'locutoff',48,'hicutoff',52,'revfilt',1); % °¼ÏÝÂË²¨48-52Hz
     EEG = eeg_checkset( EEG );
     
     EEG = pop_saveset( EEG, 'filename',[subj_id 'beforeICA.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.before_ICA\\');
     EEG = eeg_checkset( EEG );
     
     EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'pca',50,'interrupt','on');% ICA
     EEG = eeg_checkset( EEG );
     
     EEG = pop_saveset( EEG, 'filename',[subj_id 'ICA.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.ICA\\');% ´æ´¢ICA
     EEG = eeg_checkset( EEG );
end

for i = 1  : subj_num
    i
    subj_id = num2str(subj(i));
    

    EEG = pop_loadset('filename',[subj_id 'ICA.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.ICA\\');
    EEG = eeg_checkset( EEG );

    EEG = pop_iclabel(EEG, 'default');
    EEG = eeg_checkset( EEG );

    EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN]);
    EEG = eeg_checkset( EEG );

    EEG = pop_subcomp( EEG, [ ], 0);
    EEG.setname='afterICA';
    EEG = eeg_checkset( EEG );
    
    EEG = pop_saveset( EEG, 'filename',[subj_id 'afterICA.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.after_ICA\\');% ´æ´¢ICA
    EEG = eeg_checkset( EEG );

    EEG = pop_epoch( EEG, {  }, [-0.5           4], 'newname', 'afterICA epochs', 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    
    EEG = pop_rmbase( EEG, [-500 0] ,[]);% 2 35 41
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    
    EEG = pop_saveset( EEG, 'filename',[subj_id 'epoch.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.epochs\\');% ´æ´¢ICA
    EEG = eeg_checkset( EEG );
    
     EEG = pop_eegthresh(EEG,1,[1:64] ,-150,150,-0.5,3.996,0,0);
     EEG = eeg_checkset( EEG );
     
     EEG = pop_saveset( EEG, 'filename',[subj_id 'reject.set'],'filepath','E:\\Jiang in 2022\\TF in aes\\TF_data\\01.reject\\');
     EEG = eeg_checkset( EEG );
end