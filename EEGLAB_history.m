     EEG.etc.eeglabvers = '2020.0'; % this tracks which version of EEGLAB is being used, you may ignore it
     EEG = pop_loadcnt('E:\Jiang in 2022\TF in aes\TF_data\00.cntdata_other\2.cnt' , 'dataformat', 'auto', 'memmapfile', '');
     EEG = eeg_checkset( EEG );
     EEG = pop_resample( EEG, 250);
     EEG = eeg_checkset( EEG );
     EEG = pop_reref( EEG, [33 43] );
     EEG = eeg_checkset( EEG );
     EEG = pop_eegfiltnew(EEG, 'locutoff',100,'hicutoff',0.1,'plotfreqz',1);
     EEG = eeg_checkset( EEG );
     EEG = pop_eegfiltnew(EEG, 'locutoff',52,'hicutoff',48,'revfilt',1,'plotfreqz',1);
     EEG = eeg_checkset( EEG );