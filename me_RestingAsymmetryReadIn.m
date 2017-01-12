function me_RestingAsymmetryReadIn(files,outfile,filename,sheet,xlRange)


fid = fopen(outfile, 'w');
%  A = ('Filename;SubjectNumber;SessionNumber;1;2;3;4;5;6;7');
    fprintf(fid, '%6s, %12s, %18s, %24s, %30s, %36s, %42s, %48s, %54s, %60s, %66\r\n\,','Filename,SubjectNumber,SessionNumber,1,2,3,4,5,6,7,'',' );
    
for file = files'
    file.name
    cleanname = regexprep(file.name, '\.edf|\.set','');
    namelist = strsplit(cleanname, {'-','_'});
    subnum = namelist{1};
    eyestatus = namelist{3};
    sessionnumber = regexprep(namelist{2}, '^S', ''); 
    eegname = file.name
    x = me_restingAsym(eegname, filename,sheet,xlRange); 
    fprintf(fid, '%s,%s,%s,%s,', eegname, subnum, sessionnumber,eyestatus);
    fprintf( fid, '%f,%f,%f,%f,%f,%f,%f\n,', x);
    fprintf(fid, '\n');
end
fclose(fid);
fclose('all');
    



end

