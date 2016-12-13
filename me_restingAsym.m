function AIS = me_restingAsym(eegname,filename,sheet,xlRange)

lowerBound = 2;
upperBound = 41;
eegChannels = 1:14;

 if regexp(eegname,'set$')
        EEG2 = pop_loadset(eegname);
    elseif regexp(eegname,'edf$')
        EEG2 = pop_biosig(eegname);
    else
        error('me_restingAsym: File type unknown');
 end

 EEG_only = pop_select(EEG2, 'channel', eegChannels);
 EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [],[0], 0, 0, 'fir1', 0);
 
 if regexp(filename, 'csv$')
     start = csvread(filename,sheet,xlRange);
 elseif regexp(filename, 'xlsx$')
     start = xlsread(filename,sheet,xlRange,'basic');
 else 
     error('me_restingAsym: File type unknown');
 end 
 
 EEG_data = EEG_only.data(:,start:(start+15360));
 
 blob.Fs = 128;
 blob.data = EEG_data';
 
 AIS = alphaImbalance(blob);
 
 
 end
 