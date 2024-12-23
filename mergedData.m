% create an empty cell array to store the data from all file
combined_all_data = {};

% Loop through the files and combine their data
for i = 1:10
    % Create the file name with leading zeros for numbers 1 to 9
    if i < 10
        file_name = sprintf('U0%d_Acc_FreqD_FDay.mat', i);
    else
        file_name = sprintf('U%d_Acc_FreqD_FDay.mat', i);
    end
    
    % Check if the file exists
    if isfile(file_name)
        % Load the data
        data = load(file_name);
        
        % Replace 'Acc_FD_Feat_Vec' with the actual variable name in the files
        if isfield(data, 'Acc_FD_Feat_Vec')
            combined_all_data{i} = [data.Acc_FD_Feat_Vec, i * ones(size(data.Acc_FD_Feat_Vec, 1), 1)];
        else
            error('File %s does not contain the variable "Acc_FD_Feat_Vec". Please check the file.', file_name);
        end
    else
        error('File %s does not exist. Please check the file naming or directory.', file_name);
    end
end

% Combined all loaded data into a single matrix
merged_data = vertcat(combined_all_data{:});

% Save the merged data to a new file
save('mergedData.mat', 'merged_data');

% Display message
disp('Data Merging Cmpleted. Merged data has been saved as mergedData.mat');
