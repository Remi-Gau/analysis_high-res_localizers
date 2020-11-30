function opt = getOptionVisualLoc()
    % returns a structure that contains the options chosen by the user to run
    % slice timing correction, pre-processing, FFX, RFX.

    if nargin < 1
        opt = [];
    end

    % group of subjects to analyze
    opt.groups = {''};
    % suject to run in each group
    opt.subjects = {[]};

    % task to analyze
    opt.taskName = 'visualLocalizer';

    % we stay in native space (that of the T1)
    opt.space = 'T1w';
    
    % The directory where the data are located
    opt.dataDir = '/Users/barilari/data/V5_high-res_pilot-1_raw';
    
    opt.derivativesDir = '/Users/barilari/data/V5_high-res_pilot-1/derivatives';

    % Options for slice time correction
    % If left unspecified the slice timing will be done using the mid-volume acquisition
    % time point as reference.
    % Slice order must be entered in time unit (ms) (this is the BIDS way of doing things)
    % instead of the slice index of the reference slice (the "SPM" way of doing things).
    % More info here: https://en.wikibooks.org/wiki/SPM/Slice_Timing
    opt.sliceOrder = [];
    opt.STC_referenceSlice = [];

    % Options for normalize
    % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
    opt.funcVoxelDims = [];

    % Suffix output directory for the saved jobs
    opt.jobsDir = fullfile(opt.derivativesDir, 'cpp_spm', 'JOBS', opt.taskName);

    % specify the model file that contains the contrasts to compute
    opt.model.file =  ...
        fullfile(fileparts(mfilename('fullpath')), '..', ...
        'model', 'model-visualLocalizer_smdl.json');

    % specify the result to compute
    opt.result.Steps(1) = struct( ...
                                'Level',  'subject', ...
                                'Contrasts', struct( ...
                                'Name', 'motion_gt_static', ... % has to match
                                'Mask', false, ... % this might need improving if a mask is required
                                'MC', 'FWE', ... FWE, none, FDR
                                'p', 0.05, ...
                                'k', 0, ...
                                'NIDM', true));

    % Save the opt variable as a mat file to load directly in the preprocessing
    % scripts
    %     save('optVisLoc.mat', 'opt');

end
