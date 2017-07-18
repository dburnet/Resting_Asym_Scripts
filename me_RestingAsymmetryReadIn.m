function me_RestingAsymmetryReadIn(outfile,filename,sheet,xlRange)
% fix to make the input match what csvread needs. then run through and try
% to make it work...
placeholder = csvread(filename,sheet,xlRange);
edffile = placeholder(1);
start = placeholder(2);

length(edffile)
length(start)

if length(start) ~= length(edffile)
    error( 'List of start times does not match the number of files in directory.');
end


lowerBound = 2;
upperBound = 41;
eegChannels = 3:16;

fid = fopen(outfile, 'w');
%  A = ('Filename;SubjectNumber;SessionNumber;1;2;3;4;5;6;7');
fprintf(fid, '%6s, %12s, %18s, %24s, %30s, %36s, %42s, %48s, %54s, %60s, %66, %72s,','Filename,SubjectNumber,SessionNumber,CloseOpen,1,2,3,4,5,6,7,');
fprintf(fid, '\n');

for files = edffile'
    if regexp(edffile,'set$')
        EEG2 = pop_loadset(edffile);
    elseif regexp(edffile,'edf$')
        EEG2 = pop_biosig(edffile);
    else
        error('me_restingAsym: File type unknown');
    end
    startholder = 1;
    for edffile = edffile'
        edf.name
        cleanname = regexprep(edf.name, '\.edf|\.set','');
        namelist = strspl;
        it(cleanname, {'-','_'});
        subnum = namelist{1};
        eyestatus = namelist{3};
        sessionnumber = regexprep(namelist{2}, '^S', '');
        eegname = file.name;
        EEG_only = pop_select(EEG2, 'channel', eegChannels);
        EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [],[0], 0, 0, 'fir1', 0);
        EEG_data = EEG_only.data(:,start:(start+15360));
        blob.Fs = 128;
        blob.data = EEG_data';
        tempvar = alphaImbalance(blob);
        AIS{ii} = tempvar(3:4);
        startholder = startholder+1;
    end
    fprintf(fid, '%s,%s,%s,%s', eegname, subnum, sessionnumber,eyestatus);
    fprintf( fid, '%f,%f,%f,%f,%f,%f,%f,', x);
    fprintf(fid, '\n');
    
    fclose(fid);
    fclose('all');
    
end


end

