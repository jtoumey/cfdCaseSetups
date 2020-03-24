#!/bin/bash

# Get input
echo Job script name?
read jobScriptName

echo Number of jobs? 
read numJobs

ii=1
while [ $ii -le $numJobs ]
do
  echo "Job num: $ii"
  
  # /bin/bash jobscr.sh
  currentJob=$(/bin/bash $jobScriptName)

  echo $currentJob
  currentJob=${currentJob//[^0-9]/}
  echo $currentJob
  # Note the double quotes
  sed -i -e "s/afterany:.*/afterany:$currentJob/" $jobScriptName

  ii=$(($ii + 1))
done

