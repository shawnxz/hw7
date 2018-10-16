#!/usr/bin/env tcsh

# created by uber_subject.py: version 1.2 (April 5, 2018)
# creation date: Mon Oct  1 23:54:19 2018

# set subject and group identifiers
set subj  = sub-02
set gname = test
set session = test

# set data directories
set top_dir = /scratch/psyc5171/dataset1/sub-${subj}_ses-${session}
set anat_dir  = $top_dir/anat
set epi_dir   = $top_dir/func
set stim_dir  = $top_dir/onsets

# run afni_proc.py to create a single subject processing script
afni_proc.py -subj_id $subj                                                  \
        -script run_afni.sh -scr_overwrite                                    \
        -blocks tshift align tlrc volreg blur mask scale regress             \
        -copy_anat $anat_dir/sub-${subj}_ses-${session}_T1w.nii.gz                          \
        -dsets $epi_dir/sub-${subj}_ses-${session}_task-fingerfootlips_bold.nii.gz            \
        -tcat_remove_first_trs 0   -tshift_opts_ts -tpattern alt+z          \
        -tlrc_base MNI_avg152T1+tlrc                                         \
        -volreg_align_to first                                               \
        -volreg_align_e2a                                                    \
        -volreg_tlrc_warp                                                    \
        -blur_size 6.0                                                       \
        -regress_stim_times /scratch/psyc5171/xuz17008/hw7/*.txt  \
        -regress_stim_labels                                                 \
            finger foot lips                                         \
        -regress_basis 'BLOCK(15)'                                                 \
        -regress_censor_motion 0.5                                           \
        -regress_apply_mot_types demean deriv                                \
        -regress_motion_per_run                                              \
        -regress_opts_3dD                                                    \
            -gltsym 'SYM: finger -foot' -glt_label 1 finger-foot             \
            -gltsym 'SYM: finger -lips' -glt_label 2 finger-lips             \
            -gltsym 'SYM: foot -lips' -glt_label 3 foot-lips             \
        -regress_make_ideal_sum sum_ideal.1D                                 \
        -regress_est_blur_epits                                              \
        -regress_est_blur_errts                                              \
        -regress_run_clustsim no

