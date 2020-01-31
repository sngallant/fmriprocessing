#!/bin/sh

#PREPROCESSING FOR FUNCTIONAL LOCALIZER TASK INCLUDING REGISTRATION, FIELDMAP UNWARPING, AND MELODIC ICA EXPLORATION.

#By Sara Gallant ON 10/18/2019
	
for subject in 417; do

    topdir=/Volumes/ThunderBay/Projects/2019/AMSfMRI
    subdir=${topdir}/MRIdata/${subject}
    rundir=${subdir}/func/Localizer
    fmapdir=${subdir}/func/gre_field_mapping

    if [ -e ${rundir}/Loc_fmap_ICA.feat/cluster_mask_zstat1.nii.gz ]; then

		echo "Subject${subject} Encoding Run ${run} Already Done!"
		
	else

    cp ${topdir}/Design/Loc_fmap_ICA/Loc_fmap_ICA.fsf $rundir/${subject}_Loc_fmap_ICA.fsf

    design=$rundir/${subject}_Loc_fmap_ICA.fsf


	# Set output directory
    echo 'set fmri(outputdir)' ${rundir}'/Loc_fmap_ICA.feat' >> $design

	# 4D AVW data or FEAT directory (1) - point to location of 4D data
    echo 'set feat_files(1)' ${rundir}'/'${subject}'_loc_reorient' >> $design

    # B0 unwarp input image for analysis 1 - point to fieldmap magnitude image image in rad/s
    echo 'set unwarp_files(1)' ${subdir}'/func/gre_field_mapping/'${subject}'_fieldmap_mag_e1_brain_ero_rads' >> $design

    # B0 unwarp mag input image for analysis 1 - point to fieldmap magnitude image
    echo 'set unwarp_files_mag(1)' ${subdir}'/func/gre_field_mapping/'${subject}'_fieldmap_mag_e1_brain_ero' >> $design

    # Subject's structural image for analysis 1 - point to anatomical image
    echo 'set highres_files(1)' ${subdir}'/anat/t1_mprage_short_32channel/'${subject}'_T1mpr_reorient_brain' >> $design


	feat $design		
	fi

echo "Subject ${subject} finished!"
done
	
