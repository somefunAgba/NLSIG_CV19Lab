function row_mets = ...
    get_metrics(query_ccode, time_query, focus, time_data)
%  GET_METRICS 

%% Copyright
% <mailto:oasomefun@futa.edu.ng |oasomefun@futa.edu.ng|>|, 2020.|

[this_filepath,this_filename,~]= fileparts(mfilename('fullpath')); %#ok<ASGLU>
rootpath = strrep(this_filepath, [filesep 'cvmain' filesep 'cvcore'], '');
cd(rootpath);
old_dir = rootpath;
thisfolder =  string(time_data(end));

if focus == 'i'
    cd('measures');
    cd('infs')
    cd(thisfolder)
    metricsfile = "imetrics_df.xlsx";
elseif focus == 'd'
    cd('measures');
    cd('dths');
    cd(thisfolder)
    metricsfile = "dmetrics_df.xlsx";
end


sheets = sheetnames(metricsfile);
% check if the sheet for a country code exists
sheet_exists = any(strcmpi(query_ccode,sheets));
if sheet_exists
    % write or append new data on new line
    % if date-entry does overwrite with new data
    
    opts = detectImportOptions(metricsfile);
    % selects ccode sheet
    opts.Sheet = query_ccode;
    % selects all variables
    opts.SelectedVariableNames = 1:8;
    tabdf = readtable(metricsfile,opts);
    row_idx = time_query == tabdf{:,1};
    row_mets = tabdf(row_idx,2:8);
    row_mets = table2array(row_mets);
    %'R2','XIR','XIRLB','XIRUB','YIR','YIRLB','YIRUB'
end

cd(old_dir);
cprintf('[0.3, 0.5, 0.5]','Query successful!\n');
end