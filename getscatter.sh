#!/usr/bin/ksh

#define stations, lead-time and years arrays

set -A stations 06511 06512 06514 06515 06520
#set -A tfs 0:48 48:84 84:120 120:168 168:240 
set -A tfs 0:12 12:24 24:36 36:48 48:60 60:72 72:84 84:96 96:108 108:120 120:132 132:144 144:156 156:168 168:180 180:192 192:204 204:216 216:228 228:240

#set -A years 2008 2009 2010 2011 2012 2013 2014 2015 2016
set -A years 2009 2010 2011 2012 2013 2014 2015 2016 

#function for MYSQL query

query ()
{
(

# loop over stations array

for station in "${stations[@]}"; do
  
    
  echo $station
  echo $1
  echo $2
  echo $3
  #make directories

  if [ ! -d /usr/people/wagenaa/scatterEPS_HT/$3/$station ]; then
    mkdir -p /usr/people/wagenaa/scatterEPS_HT/$3/$station 
  fi
  #if [ ! -d /usr/people/wagenaa/CRPS_members/13-16/$station ]; then
    #mkdir -p /usr/people/wagenaa/CRPS_members/13-16/$station 
  #fi

  #echo excLev"$station"_2008
  
  if [ ! -d /usr/people/wagenaa/scatterEPS_HT/$3/$station/$1-$2 ]; then
    mkdir -p /usr/people/wagenaa/scatterEPS_HT/$3/$station/$1-$2
  fi
  #if [ ! -d /usr/people/wagenaa/CRPS_members/13-16/$station/$1-$2 ]; then
    #mkdir -p /usr/people/wagenaa/CRPS_members/13-16/$station/$1-$2
  #fi
  
  #do MYSQL query
  echo "select dtg, tastr, hastr, hmean, sigma, hobs from eps"$station"_"$3" where HOUR(timediff(tastr, dtg))>$1 AND HOUR(timediff(tastr, dtg))<$2 AND hobs IS NOT NULL" |mysql --defaults-file=/usr/people/wagenaa/.mysql/ontwrd.cnf> /usr/people/wagenaa/scatterEPS/$3/$station/$1-$2/EPS_"$station"_$1-$2_.txt 
done
)\
}


#for year in "${years[@]}"; do 
  #for tf in ${tfs[*]};do
    #echo $tf
    #query $(echo $tf | sed -e 's/:/ /') $year
  #done
#done

query ()
{
(


for station in "${stations[@]}"; do
  
    
  echo $station
  echo $1
  echo $2
  echo $3
  if [ ! -d /usr/people/wagenaa/scatterEPS_years_LT_PS/$station/$1-$2 ]; then
    mkdir -p /usr/people/wagenaa/scatterEPS_years_LT_PS/$station/$1-$2
  fi
  #if [ ! -d /usr/people/wagenaa/CRPS_members/13-16/$station ]; then
    #mkdir -p /usr/people/wagenaa/CRPS_members/13-16/$station 
  #fi

  #echo excLev"$station"_2008
  
  if [ ! -d /usr/people/wagenaa/scatterEPS_years_LT_PS/$station/$1-$2/$3 ]; then
    mkdir -p /usr/people/wagenaa/scatterEPS_years_LT_PS/$station/$1-$2/$3
  fi
  #if [ ! -d /usr/people/wagenaa/CRPS_members/13-16/$station/$1-$2 ]; then
    #mkdir -p /usr/people/wagenaa/CRPS_members/13-16/$station/$1-$2
  #fi
  echo "select dtg, tastr, hastr, hmean, sigma, hobs from eps"$station"_"$3" where HOUR(timediff(tastr, dtg))>$1 AND HOUR(timediff(tastr, dtg))<$2 AND hastr <0 AND hmean >0 AND hobs IS NOT NULL" |mysql --defaults-file=/usr/people/wagenaa/.mysql/ontwrd.cnf> /usr/people/wagenaa/scatterEPS_years_LT_PS/$station/$1-$2/$3/EPS_"$station"_$1-$2_.txt
done
)\
}


#loop over years and lead-time and use it  as input for query function
for year in "${years[@]}"; do 
  for tf in ${tfs[*]};do
    echo $tf
    query $(echo $tf | sed -e 's/:/ /') $year
  done
done

