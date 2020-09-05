clear;
clc;
close all;

% Smoothing to apply
FWHM = 6;

addpath(fullfile(pwd, '..'));

initEnv();

% we add all the subfunctions that are in the sub directories
opt = getOptionVisualLoc();

checkDependencies();

%% Run batches
bidsCopyRawFolder(opt, 1);
bidsRealign(opt);

% BIDS_Smoothing(FWHM, opt);
% BIDS_FFX(1, FWHM, opt, 0);
% BIDS_FFX(2, FWHM, opt, 0);
% BIDS_Results(FWHM, opt, 0);
