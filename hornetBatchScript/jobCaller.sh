#!/bin/bash

echo Job script name?
read jobScriptName

echo Number of jobs? 
read numJobs

ii=1
while [ $ii -le $numJobs ]
do
  echo "Job num: $ii"
  
  # /bin/bash jobscr.sh
  currentJob=$(/bin/bash jobscr.sh)

  echo $currentJob
  vv=$currentJob | tr -dc '0-9'
  echo $vv
  
  ii=$(( $ii + 1))
done

