% LAYNII quality metrics

opt.dataDir = '/Users/barilari/Desktop/data_temp/V5_high-res_pilot-1_raw_localizers';

opt.reportDir = '/Users/barilari/Desktop/data_temp/V5_high-res_pilot-1_raw_localizers';

opt.taskName = {'visualLocalizer'}; % here you can pass in >1 task

pthLAYNII = '/Users/barilari/data/tools/LAYNII/';

cmd = 'LN_SKEW -input ';

rawDir = opt.dataDir;

% volumes = cellstr(spm_select('FPListRec', rawDir, '^.*.nii.gz$'));
volumes = cellstr(spm_select('FPListRec', rawDir, '^.*.nii$'));


% Pick up only func brains
funcVolumes = volumes(contains(volumes, {'func'}) & ~contains(volumes, {'dir'}));

tic;

for iTask = 1:length(opt.taskName)
    
    fprintf('\n\n\n  Checking task: %s\n\n', opt.taskName{iTask})
    
    volumesToCheck = funcVolumes(contains(funcVolumes, {opt.taskName{iTask}}));
    
    
    for iVol = 1:length(volumesToCheck)
        
        [~,name,ext] = fileparts(volumesToCheck{iVol});
        
        volume = [opt.reportDir filesep name ext];
        
        system(sprintf('cp -R -L -f %s %s', volumesToCheck{iVol}, volume));
                        
        system([pthLAYNII cmd volume]);
        
        delete(volume)
        
    end
    
end

toc;