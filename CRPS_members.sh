#!/usr/bin/ksh

# define stations, lead-times and forecast years

set -A stations 06511 06512 06514 
#set -A tfs 0:48 48:84 84:120 120:168 168:240 
set -A tfs 0:12 12:24 24:36 36:48 48:60 60:72 72:84 84:96 96:108 108:120 120:132 132:144 144:156 156:168 168:180 180:192 192:204 204:216 216:228 228:240

#set -A years 2008 2009 2010 2011 2012 2013 2014 2015 2016
set -A years 2009 2010 2011 2012 2013 2014 2015 2016

query ()
{
(

#loop over stations

for station in "${stations[@]}"; do
  
    
  echo $station
  echo $1
  echo $2
  echo $3
  echo $4
  # make directories year/stations/lead-time/
  if [ ! -d /usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/$4/$station ]; then
    mkdir -p /usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/$4/$station 
  fi
  if [ ! -d /usr/people/wagenaa/CRPS_members_adj_tf_NEGLT/$station ]; then
    mkdir -p /usr/people/wagenaa/CRPS_members_adj_tf_NEGLT/$station 
  fi

  #echo excLev"$station"_2008
  
  if [ ! -d /usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/$4/$station/$1-$2 ]; then
    mkdir -p /usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/$4/$station/$1-$2
  fi
  if [ ! -d /usr/people/wagenaa/CRPS_members_adj_tf_NEGLT/$4/$station/$1-$2 ]; then
    mkdir -p /usr/people/wagenaa/CRPS_members_adj_tf_NEGLT/$4/$station/$1-$2
  fi
  
  #MYSQL query for High/Low tide Positive/Negative surge 
    
  #echo "select hmod, hastr, dtg, tastr, member, hobs from frc"$station"_"$4" join eps"$station"_"$4" using(tastr,dtg) where HOUR(timediff(tastr, dtg))>$1 AND HOUR(timediff(tastr, dtg))<$2 AND member = $3 AND hastr>0 AND hobs is NOT NULL" | mysql --defaults-file=/usr/people/wagenaa/.mysql/ontwrd.cnf> /usr/people/wagenaa/CRPS_members_adj_tf_HT/$4/$station/$1-$2/CRPS_"$station"_$1-$2_member$3.txt
  #echo "select hmod, hastr, dtg, tastr, member, hobs from frc"$station"_"$4" join eps"$station"_"$4" using(tastr,dtg) where HOUR(timediff(tastr, dtg))>$1 AND HOUR(timediff(tastr, dtg))<$2 AND member = $3 AND hastr<0 AND hobs is NOT NULL" | mysql --defaults-file=/usr/people/wagenaa/.mysql/ontwrd.cnf> /usr/people/wagenaa/CRPS_members_adj_tf_LT/$4/$station/$1-$2/CRPS_"$station"_$1-$2_member$3.txt
  echo "select hmod, hastr, dtg, tastr, member, hobs from frc"$station"_"$4" join eps"$station"_"$4" using(tastr,dtg) where HOUR(timediff(tastr, dtg))>$1 AND HOUR(timediff(tastr, dtg))<$2 AND member = $3 AND hobs<0 AND hastr>0 AND hobs is NOT NULL" | mysql --defaults-file=/usr/people/wagenaa/.mysql/ontwrd.cnf> /usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/$4/$station/$1-$2/CRPS_"$station"_$1-$2_member$3.txt
  echo "select hmod, hastr, dtg, tastr, member, hobs from frc"$station"_"$4" join eps"$station"_"$4" using(tastr,dtg) where HOUR(timediff(tastr, dtg))>$1 AND HOUR(timediff(tastr, dtg))<$2 AND member = $3 AND hobs<0 AND hastr<0 AND hobs is NOT NULL" | mysql --defaults-file=/usr/people/wagenaa/.mysql/ontwrd.cnf> /usr/people/wagenaa/CRPS_members_adj_tf_NEGLT/$4/$station/$1-$2/CRPS_"$station"_$1-$2_member$3.txt
  done
)\
}

#loop over years and all members and provide input for the function
for year in "${years[@]}"; do 
  for member in {1..50};do

    for tf in ${tfs[*]};do
      echo $tf
      query $(echo $tf | sed -e 's/:/ /') $member $year
    done
  done
done
