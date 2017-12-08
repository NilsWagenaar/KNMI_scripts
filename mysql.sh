#!/bin/bash

#login

#mysql -h namo astro -e "SELECT * FROM gauge"  > /usr/people/wagenaa/gauges.txt
#mysql -h namo W610 -e "SELECT *, HOUR(TIMEDIFF(tastr,dtg)) as time_diff from frc06514_2016 WHERE HOUR(TIMEDIFF(tastr, dtg)) < 48" > /usr/people/wagenaa/query.txt

#mysql -h namo W610 -e "SELECT * from eps06514_2016 RIGHT JOIN frc06514_2016 on eps06514_2016.tastr = frc06514_2016.tastr LIMIT 1000" > /usr/people/wagenaa/blabla.txt

#mysql -h namo W610 -e "select * from frc06514_2016 LIMIT 800" > /usr/people/wagenaa/FRC_2016.txt

#mysql -h namo W610 -e "select * from crh06514" > /usr/people/wagenaa/crh06514.txt
#mysql --defaults-file=.mysql/ontwrd.cnf -e "select *, HOUR(TIMEDIFF(tastr, dtg)) as time_diff from excLev06520_2008 WHERE ROUND(TIME_TO_SEC(TIMEDIFF(tastr, dtg))/3600) <=6" > 6h_lead_informationlvl_vliss.txt
#mysql --defaults-file=.mysql/ontwrd.cnf -e "select hastr, hobs, dtg, tf, lvl, hmean, Pexc from excLev06512_2016	WHERE lvl = 80 AND hastr<0" > /usr/people/wagenaa/Den_Helder/Medium_surge_tides/Den_Helder_Mediumsurge_lowtide_2016.txt
#mysql --defaults-file=.mysql/ontwrd.cnf waqua -e "select * from eps06520_2010 WHERE hastr>0 AND hobs>0 AND tf >192 AND tf< 240" > /usr/people/wagenaa/192-240hr_hightide_possurge_vlissingen_2010.txt
#mysql --defaults-file=.mysql/ontwrd.cnf waqua -e "select * from eps06520_2008 WHERE tf<48" > /usr/people/wagenaa/48hr_CRPS_vlissingen_2009.txt

#mysql --defaults-file=.mysql/ontwrd.cnf -e "select hastr, hobs, dtg, tf, lvl, hmean, Pexc from excLev06515_2016 where dtg between '2016-01-01 12:00:00' AND '2016-03-24 12:00:00' AND lvl = 75">/usr/people/wagenaa/Huibertgat/Seasons_Mediumsurge/Huibertgat_Mediumsurge_winter_2016.txt

#declare -a years=("2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016")

mysql --defaults-file=.mysql/ontwrd.cnf -e "select tastr, hastr, hobs, dtg, tf, lvl, hmean, Pexc from excLev06511_2008 where tf >48 AND tf < 84 AND hastr<0 AND lvl = 80" > /usr/people/wagenaa/Delfzijl/Medium_surge_tides/48-84hr/48-84hr_Delfzijl_Mediumsurge_lowtide_2008.txt
#mysql --defaults-file=.mysql/ontwrd.cnf -e "select tastr, hastr, hobs, dtg, tf, lvl, hmean, Pexc from excLev06512_2016  where tf<12  AND lvl = 80" > /usr/people/wagenaa/Den_Helder/Climatology/Mediumsurge/Lowtide/Den_helder_Lowtide_2016.txt



#mysql --defaults-file=.mysql/ontwrd.cnf -e "select * from eps620_2009 WHERE hastr <0 AND hobs<0 AND tf <48" > /usr/people/wagenaa/testing.txt"
# select * from eps620_2009 WHERE hastr <0 AND hobs<0 AND tf <48" > /usr/people/wagenaa/testing.txt
