% Load a NIfTI file and check how many volumes can be safely read in chunks.

% Ask the user to select a NIfTI file
[filename, pathname] = uigetfile('*.nii', 'Select a NIfTI file');
if isequal(filename, 0)
    fprintf('No file selected.\n');
    return;
end

nii_path = fullfile(pathname, filename);

% Try to load information about all volumes
try
    V = spm_vol(nii_path);
    total_vols = length(V);
    fprintf('The file contains %d volumes.\n', total_vols);
catch ME
    fprintf('Error while loading the file:\n%s\n', ME.message);
    return;
end

% Check volumes in chunks of 50
step = 50;
max_safe_vols = 0;

fprintf('Checking in chunks of %d volumes:\n', step);

for n = step:step:total_vols
    try
        subV = spm_read_vols(V(1:n));
        fprintf('✅ Successfully loaded %d volumes.\n', n);
        max_safe_vols = n;
    catch ME
        fprintf('❌ Error while trying to load %d volumes: %s\n', n, ME.message);
        break;
    end
end

fprintf('\nMaximum stable number of volumes: %d\n', max_safe_vols);
