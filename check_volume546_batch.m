% Automatically check whether volume 546 can be loaded from all inner speech NIfTI files
% located in subfolders of a selected root directory.

% Ask the user to select the root folder
root_path = uigetdir('', 'Select the root directory containing participant folders');
if root_path == 0
    fprintf('No folder selected.\n');
    return;
end

% Get a list of all participant subfolders
participants = dir(root_path);
participants = participants([participants.isdir]);  % keep only directories
participants = participants(~ismember({participants.name}, {'.', '..'}));  % remove . and ..

for p = 1:length(participants)
    subj_name = participants(p).name;
    subj_path = fullfile(root_path, subj_name);
    
    % Find all .nii files that contain "InnerSpeech" in the filename
    nii_files = dir(fullfile(subj_path, '*InnerSpeech*.nii'));
    
    for f = 1:length(nii_files)
        nii_path = fullfile(subj_path, nii_files(f).name);
        
        try
            V = spm_vol(nii_path);
            if length(V) < 546
                fprintf(' %s: only %d volumes, cannot check #546\n', nii_files(f).name, length(V));
                continue;
            end

            % Try reading the 546th volume
            spm_read_vols(V(546));
            fprintf('✅ %s → volume 546 loaded successfully\n', nii_files(f).name);
            
        catch ME
            fprintf('❌ %s → error reading volume 546: %s\n', nii_files(f).name, ME.message);
        end
    end
end
