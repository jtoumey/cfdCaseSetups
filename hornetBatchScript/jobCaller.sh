#!/bin/bash

# echo Job script name?
# read jobScriptName
jobScriptName=jobscr.sh
# echo Number of jobs? 
# read numJobs
numJobs=4
jobPattern='jobId.*'

ii=1
while [ $ii -le $numJobs ]
do
  echo "Job num: $ii"
  
  # /bin/bash jobscr.sh
  currentJob=$(/bin/bash jobscr.sh)

  echo $currentJob
  currentJob=${currentJob//[^0-9]/}
  echo $currentJob
  # Note the double quotes
  # sed -i "s/${search}/${replace}/g" metamorphosis.txt
  # sed '/jobId/!b;n;c999' $jobScriptName
  # sed "s/.*$jobId.*/$currentJob/" $jobScriptName
  # sed -n -e "/$jobId.*/p" jobscr.sh
  sed -i -e "s/afterany:.*/afterany:=$currentJob/" $jobScriptName

  ii=$(($ii + 1))
done

