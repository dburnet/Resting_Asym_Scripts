% wrapper function -DHB 10/4


function me_Markers(files, outfile)

% ge_tapBlockImport(files, outfile)
%
% Imports a block of files in the required format for Dom Parrott's "TAP" 
% experiments. Uses the ge_parrottImport.m function to resolve markers and
% pre-process data. Uses a dir() object as input! (Will break on a list or
% some other format.
%
% MDT
% 2016.06.13
% Version 0.8.3

    FileID = fopen(outfile,'w');
%     A = ('Filename;SubjectNumber;SessionNumber;1;2;3;4;5;6;7;8;9;10;11;12;13;14');
%     fprintf(FileID, '%6s, %12s, %18s, %24s, %30s, %36s, %42s, %48s, %54s, %60s, %66s, %72s, %78s, %84s, %90s, %96s, %102s\n','Filename,SubjectNumber,SessionNumber,1,2,3,4,5,6,7,8,9,10,11,12,13,14' );
% % %     fprintf(FileID, '%6.2f,%12.2f,%18.2f,%24.2f,%30.2f,%36.2f,%42.2f,%48.2f,%52.2f,%58.2f,%64.2f,%70.2f,%76.2f,%82.2f,%88.2f,%94.2f,%100.2f\n,', A);
    for file = files'
        file.name
        % Subject and condition data:
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        namelist  = strsplit(cleanname, {'-','_'});
        subnum    = namelist{1};
        sessionnumber  = regexprep(namelist{2}, '^session', '');
        % Data analysis to get AIS's:

        x = ge_makeEventList(file.name);
        % Write the "obvious" data to the file
        fprintf(FileID, '%s,%s,%s,',file.name,subnum,sessionnumber);
%         for counter = 1:length(x)
            fprintf(FileID, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,');
%             x{counter});
%         end
%         nasthings = 8 - length(x);
%         for counter = 1:nasthings
%             fprintf(FileID, 'NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,');
%         end 
        fprintf(FileID, '\n');
    end
    fclose(FileID);
    fclose('all');     % Testing to fix the matlab open file bug!
    
end

