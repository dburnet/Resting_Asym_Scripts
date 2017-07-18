function AIS = me_restingAsym(eegname)
%% start time should be in samples in the given xlRange, the read in file should only have the start time in samples listed as a number in the file %%

lowerBound = 2;
upperBound = 41;
eegChannels = 3:16;

 if regexp(eegname,'set$')
        EEG2 = pop_loadset(eegname);
    elseif regexp(eegname,'edf$')
        EEG2 = pop_biosig(eegname);
    else
        error('me_restingAsym: File type unknown');
 end

 EEG_only = pop_select(EEG2, 'channel', eegChannels);
 EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [],[0], 0, 0, 'fir1', 0);
  
     EEG_data = EEG_only.data(:,1:(1+15360));
     blob.Fs = 128;
     blob.data = EEG_data';
     AIS = sepa_alphaAsymmetry(blob);

 
 end
 