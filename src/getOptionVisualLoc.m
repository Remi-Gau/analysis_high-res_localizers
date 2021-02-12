% (C) Copyright 2020 Remi Gau, Marco Barilari

function opt = getOption_rdkBimotion()
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
    opt.space = 'individual';

    % The directory where the data are located
    opt.dataDir = '/Users/barilari/Desktop/data_temp/ses-001_localizers_CPP_SPM/raw';

    opt.derivativesDir = '/Users/barilari/Desktop/data_temp/ses-001_localizers_CPP_SPM/derivatives/cpp_spm-task-visualLocalizer';

    % Options for slice time correction
    % If left unspecified the slice timing will be done using the mid-volume acquisition
    % time point as reference.
    % Slice order must be entered in time unit (ms) (this is the BIDS way of doing things)
    % instead of the slice index of the reference slice (the "SPM" way of doing things).
    % More info here: https://en.wikibooks.org/wiki/SPM/Slice_Timing

    opt.sliceOrder = [ 0, 0.85, 1.70, 0.75, 1.60, 0.65, 1.50, 0.55, 1.40, 0.45, 1.30, 0.35, ...
                       1.20, 0.25, 1.10, 0.15, 1, 0.05, 0.90, 1.75, 0.80, 1.65, 0.70, 1.55, ...
                       0.60, 1.45, 0.50, 1.35, 0.40, 1.25, 0.30, 1.15, 0.20, 1.05, 0.10, 0.95, ...
                       0, 0.85, 1.70, 0.75, 1.60, 0.65, 1.50, 0.55, 1.40, 0.45, 1.30, 0.35, ...
                       1.20, 0.25, 1.10, 0.15, 1, 0.05, 0.90, 1.75, 0.80, 1.65, 0.70, 1.55, ...
                       0.60, 1.45, 0.50, 1.35, 0.40, 1.25, 0.30, 1.15, 0.20, 1.05, 0.10, 0.95 ];

    opt.STC_referenceSlice = 1.8 / 2;

    opt.realign.useUnwarp = false;

    % Options for normalize
    % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
    opt.funcVoxelDims = [];

    % Suffix output directory for the saved jobs
    opt.jobsDir = fullfile(opt.derivativesDir, 'cpp_spm', 'JOBS', opt.taskName);

    % specify the model file that contains the contrasts to compute
    opt.model.file =  ...
        fullfile(fileparts(mfilename('fullpath')), ...
        '..', 'model', 'model-visualLocalizer_smdl.json');

    % Specify the result to compute
    opt.result.Steps(1) = returnDefaultResultsStructure();

    opt.result.Steps(1).Level = 'subject';

    opt.result.Steps(1).Contrasts(1).Name = 'motion_gt_static';
    opt.result.Steps(1).Contrasts(1).MC =  'none';
    opt.result.Steps(1).Contrasts(1).p = 0.001;
    opt.result.Steps(1).Contrasts(1).k = 0;

    opt.result.Steps(1).Contrasts(2).Name = 'motion_gt_static';
    opt.result.Steps(1).Contrasts(2).MC =  'FWE';
    opt.result.Steps(1).Contrasts(2).p = 0.05;
    opt.result.Steps(1).Contrasts(2).k = 0;

    opt.result.Steps(1).Contrasts(3).Name = 'static_gt_motion';
    opt.result.Steps(1).Contrasts(3).MC =  'none';
    opt.result.Steps(1).Contrasts(3).p = 0.001;
    opt.result.Steps(1).Contrasts(3).k = 0;

    opt.result.Steps(1).Contrasts(4).Name = 'static_gt_motion';
    opt.result.Steps(1).Contrasts(4).MC =  'FWE';
    opt.result.Steps(1).Contrasts(4).p = 0.05;
    opt.result.Steps(1).Contrasts(4).k = 0;

    opt.result.Steps(1).Contrasts(5).Name = 'motion';
    opt.result.Steps(1).Contrasts(5).MC =  'none';
    opt.result.Steps(1).Contrasts(5).p = 0.001;
    opt.result.Steps(1).Contrasts(5).k = 0;

    opt.result.Steps(1).Contrasts(6).Name = 'motion';
    opt.result.Steps(1).Contrasts(6).MC =  'FWE';
    opt.result.Steps(1).Contrasts(6).p = 0.05;
    opt.result.Steps(1).Contrasts(6).k = 0;

    opt.result.Steps(1).Contrasts(7).Name = 'static';
    opt.result.Steps(1).Contrasts(7).MC =  'none';
    opt.result.Steps(1).Contrasts(7).p = 0.001;
    opt.result.Steps(1).Contrasts(7).k = 0;

    opt.result.Steps(1).Contrasts(8).Name = 'static';
    opt.result.Steps(1).Contrasts(8).MC =  'FWE';
    opt.result.Steps(1).Contrasts(8).p = 0.05;
    opt.result.Steps(1).Contrasts(8).k = 0;

    % % specify the result to compute
    % opt.result.Steps(1) = struct( ...
    %                              'Level',  'subject', ...
    %                              'Contrasts', struct( ...
    %                         'Name', 'Motion_gt_Static', ... % has to match
    %                         'Mask', false, ... % this might need improving if a mask is required
    %                         'MC', 'FWE', ... FWE, none, FDR
    %                         'p', 0.05, ...
    %                         'k', 0, ...
    %                         'NIDM', true));

    % Specify how you want your output (all the following are on false by default)
    opt.result.Steps(1).Output.png = true();

    opt.result.Steps(1).Output.csv = true();

    opt.result.Steps(1).Output.thresh_spm = true();

    opt.result.Steps(1).Output.binary = true();

    opt.result.Steps(1).Output.montage.do = true();
    opt.result.Steps(1).Output.montage.slices = -38:3:28; % in mm

    % axial is default 'sagittal', 'coronal'
    opt.result.Steps(1).Output.montage.orientation = 'axial';

    % will use the MNI T1 template by default but the underlay image can be
    % changed.
    % opt.result.Steps(1).Output.montage.background = ...
    %   fullfile(spm('dir'), 'canonical', 'avg152T1.nii,1');

    opt.result.Steps(1).Output.montage.background = '/Users/barilari/Desktop/data_temp/ses-001_localizers_CPP_SPM/derivatives/cpp_spm-task-visualLocalizer/sub-pilot001/ses-001/anat/msub-pilot001_ses-003_run-1_T1w_skullstripped.nii';

    %
    %   opt.result.Steps(1).Output.NIDM_results = true();

    %% DO NOT TOUCH

    % Save the opt variable as a mat file to load directly in the preprocessing
    % scripts
    opt = checkOptions(opt);
    saveOptions(opt);

end
