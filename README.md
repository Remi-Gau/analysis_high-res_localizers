**Unit tests and coverage**

[![](https://img.shields.io/badge/Octave-CI-blue?logo=Octave&logoColor=white)](https://github.com/Remi-gau/template_matlab_analysis/actions)
![](https://github.com/Remi-gau/template_matlab_analysis/workflows/CI/badge.svg) 

[![codecov](https://codecov.io/gh/Remi-gau/template_matlab_analysis/branch/master/graph/badge.svg)](https://codecov.io/gh/Remi-gau/template_matlab_analysis)

**Miss_hit linter**

[![Build Status](https://travis-ci.com/Remi-gau/template_matlab_analysis.svg?branch=master)](https://travis-ci.com/Remi-gau/template_matlab_analysis)


# Code for analysing visual and auditory localizers


## Content

```bash
├── .git
├── .github  # where you put anything github related
│   └── workflows # where you define your github actions
│       └── moxunit.yml # a yaml file that defines a github action
├── lib # where you put the code from external libraries (mathworks website or other github repositories)
│   └── README.md
├── src # where you put your code
│   ├── README.md
│   └── miss_hit.cfg
├── tests # where you put your unit tests
|   ├── README.md
|   └── miss_hit.cfg
├── notebooks
|   ├── ...
|   └── README.md
├── model 
|   ├── ...
|   └── README.md
├── .travis.yml # where you define the continuous integration done by Travis
├── LICENSE
├── README.md
├── miss_hit.cfg # configuration file for the matlab miss hit linter
├── spm_my_defaults.m # define the SPM defaults for this project
└── initEnv.m # a .m file to set up your project (adds the right folder to the path)
```

The code for the analysis is in the `src` folder.

## Keeping your code stylish: miss hit linter

## Testing the code

## Continuous integration




## Datalad issue

Seems that after copying data "out" of a datalad dataset the files are still "locked" and one needs to still run `chmod +w` on them.



