% Check if volumes 501 to 546 of a NIfTI file can be successfully loaded using SPM.

% Ask the user to select a NIfTI file
[filename, pathname] = uigetfile('*.nii', 'Select a NIfTI file');
if isequal(filename, 0)
    fprintf('No file selected.\n');
    return;
end

nii_path = fullfile(pathname, filename);

% Load volume metadata
try
    V = spm_vol(nii_path);
    total_vols = length(V);
    fprintf('The file contains %d volumes.\n', total_vols);
catch ME
    fprintf('Error loading volume info:\n%s\n', ME.message);
    return;
end

% Define volume range to check
range_start = 501;
range_end = 546;

if total_vols < range_end
    fprintf('The file contains fewer than %d volumes. Adjusting range to available data.\n', range_end);
    range_end = total_vols;
end

% Try loading each volume in the range
for i = range_start:range_end
    try
        spm_read_vols(V(i));
        fprintf('✅ Volume %d loaded successfully\n', i);
    catch ME
        fprintf('❌ Error on volume %d: %s\n', i, ME.message);
    end
end
