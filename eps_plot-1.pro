PRO eps_plot

!P.Multi = [0, 2, 2]
%dbs    = [ ['EPS0', ''], ['EPS0x', 'EPS1'] ]
%dbs    = [ ['EPS0', 'E2'] ]
dbs		= [ ['waqua', 'waqua_work']
gauges = [ 'delfzijl', 'denhelde', 'harlinge', 'hoekvanh', $
           'huibertg', 'roompotb', 'vlissing', 'ijmuiden' ]
astro  = [ "L", "H" ]
tfs    = [ [0, 36], [36, 72], [72, 120], [120, 240] ]
tfs    = [ [0, 48], [48, 84], [84, 120], [120, 156], [156, 240] ]
hobs   = [ [-1000, 0], [0, 1000] ]
nobs   = [ "N", "P" ]
pext   = [ ".eps", "c.eps" ]
Corr   = 1

nd     = size(dbs,    /dimensions) - 1
IF size(nd, /n_elements) EQ 1 THEN BEGIN
  ndmx = 0
ENDIF ELSE BEGIN
  ndmx = nd[1]
ENDELSE
ng     = size(gauges, /n_elements) - 1
nt     = size(tfs,    /dimensions) - 1
nh     = size(nobs,   /n_elements) - 1

For Corr = 0, 1 DO BEGIN
  FOR db = 0, ndmx DO BEGIN
    FOR gg = 0, ng DO BEGIN
      FOR hl = 0, 1 DO BEGIN
	FOR tf = 0, nt[1] DO BEGIN
	  FOR ob = 0, nh DO BEGIN
	    device, Filename=gauges[gg] + '-' + dbs[0, db] + '-' + astro[hl] $
			       + string(tfs[0, tf], Format='(i3.3)') $
			       + string(tfs[1, tf], Format='(i3.3)') $
			       + nobs[ob] + pext[Corr]
	    talagrand, gauges[gg], DbX=dbs[*, db], TFs=tfs[*, tf], Hobs=hobs[*, ob], Astro=hl, Corr=Corr
	    device, /Close_File
	  ENDFOR
	ENDFOR
      ENDFOR
    ENDFOR
  ENDFOR
ENDFOR

RETURN
END
