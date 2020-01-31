#!/bin/sh

#First level analysis of denoised functional data.

#By Sara Gallant ON 10/18/2019
	
for subject in 403; do

    topdir=/Volumes/ThunderBay/Projects/2019/AMSfMRI
    subdir=${topdir}/MRIdata/${subject}
    rundir=${subdir}/func/Localizer
    evdir=${topdir}/MRIdata/EVFiles/Loc_EVFiles

    if [ -e ${rundir}/Loc_denoised_1stlevel.feat/cluster_mask_zstat1.nii.gz ]; then

		echo "Subject ${subject} denoised localizer ${run} already run!"
		
	else

    cp ${topdir}/Design/Loc_denoised/Loc_denoised.fsf $rundir/${subject}_Loc_denoised.fsf

    design=$rundir/${subject}_Loc_denoised.fsf

    # Set volume count
    count="fslnvols ${rundir}/${subject}_loc_denoised"
    echo 'set fmri(npts)' ${count}' >> $design

	# Set output directory
    echo 'set fmri(outputdir)' ${rundir}'/Loc_denoised_1stlevel.feat' >> $design

	# 4D AVW data or FEAT directory (1) - point to denoised 4D data
    echo 'set feat_files(1)' ${rundir}'/'${subject}'_loc_denoised' >> $design

    # Custom EV file (EV 1) - point to EV file
    echo 'set fmri(custom1)' ${evdir}'/Loc_'${subject}'_EV_Bodies.txt' >> $design

    # Custom EV file (EV 2) - point to EV file
    echo 'set fmri(custom2)' ${evdir}'/Loc_'${subject}'_EV_Scenes.txt' >> $design

	feat $design
	fi

echo "Subject ${subject} finished!"
done
	
