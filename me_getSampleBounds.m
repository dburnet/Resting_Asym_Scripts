% bounds = ge_getSampleBounds(EEGVAR, beepValue, markerChannel)
% 
% Determines the start and stop samples of an EEG experiment.
%
% MDT
% 2015.07.01

function bounds = me_getSampleBounds(EEGVAR, beepValue, markerChannel)
    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
   elseif regexp(filename,'edf$')
        EEG2 = pop_biosig(filename);
    else
        error('ge_handContraction: File type unknown');
    end
    if nargin == 2
        markerChannel = 20;     % Default EPOC(+) marker channel
    elseif nargin == 1
        beepValue     = 2;      % Original default beep marker
        markerChannel = 20;
    end
    EEGVAR.data = EEG2.data'
    nonzeroSamplePoints = find(EEGVAR.data(markerChannel,:));
    nonzeroSampleValues = EEGVAR.data(markerChannel, nonzeroSamplePoints);
    bounds = nonzeroSamplePoints(nonzeroSampleValues == beepValue);
    