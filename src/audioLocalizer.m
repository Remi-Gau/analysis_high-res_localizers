% Batch auditory localizer high-res

clear;
clc;

%% Run batches
opt = getOptionAudioLoc();

checkDependencies();

reportBIDS(opt);

bidsCopyRawFolder(opt, 1);

% preprocessing
bidsSTC(opt);
bidsSpatialPrepro(opt);

% Quality control
anatomicalQA(opt);

% Not implemented yet
bidsResliceTpmToFunc(opt);
functionalQA(opt);

funcFWHM = 0;
bidsSmoothing(funcFWHM, opt);

% subject level Univariate
bidsFFX('specifyAndEstimate', opt, funcFWHM);
bidsFFX('contrasts', opt, funcFWHM);

bidsResults(opt, funcFWHM);