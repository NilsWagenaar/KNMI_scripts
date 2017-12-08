PRO getCRH, gauge, CRH, Dbase=Dbase, DbX=DbX, Work=Work, TFs=TFs, Hobs=Hobs, Astro=Astro, Period=Period, Twin=Twin, Corr=Corr

IF NOT KEYWORD_SET(TFs)   THEN TFs   = [48, 120]
IF NOT KEYWORD_SET(Hobs)  THEN Hobs  = [-1000, 1000]
IF NOT KEYWORD_SET(Astro) THEN Astro = 0

IF NOT KEYWORD_SET(Dbase) THEN BEGIN
  IF KEYWORD_SET(DbX) THEN BEGIN
    Dbase = "Kansen-" + DbX
  ENDIF ELSE BEGIN
    Dbase = [ "Kansen-EPS0" ]
  ENDELSE
ENDIF

IF NOT KEYWORD_SET(Corr) THEN Corr='both'
CASE Corr OF
  'both' : rank = [ "rank", "rank1" ]
  'on'   : rank = [ "rank1" ]
  'off'  : rank = [ "rank"  ]
   ELSE  : rank = [ "rank1" ]
ENDCASE

; Number of classes must be fixed, because database only returns when the
; number of ranks is more than 0
NR  = 53
ndb = size(Dbase, /n_elements)
ncr = size(rank, /n_elements)
CRH = FLTARR(ndb, ncr, 3, NR + 2)

FOR i = 0, ndb-1 DO BEGIN
  FOR j = 0, ncr-1 DO BEGIN
    IF Dbase[i] EQ '' THEN CONTINUE
    cmd = "getCRH db=" + Dbase[i]
    IF KEYWORD_SET(Work) THEN $
      cmd = cmd + " work="  + Work
    cmd = cmd + " gauge=" + string(gauge, Format='(i5.5)') + " rank=" + rank[j] $
	   + " 'tfmin=" + string(TFs[0], Format='(%"%d")')  + "' 'tfmax=" + string(TFs[1], Format='(%"%d")')   + "'"$
	   + " 'obsmn=" + string(Hobs[0], Format='(%"%d")') + "' 'obsmx=" + string(Hobs[1], Format='(%"%d")')  + "'"$
	   + string(Astro, Format='(%" astro=%d")')
    IF KEYWORD_SET(Period) THEN BEGIN
      cmd = cmd + string(Period[0], Format='(%" start=%d")') + string(Period[1], Format='(%" last=%d")')
    ENDIF
    IF NOT KEYWORD_SET(Twin) THEN BEGIN
      cmd = cmd	+ " 'epsbs=eps' 'obs=hobs'"
    ENDIF ELSE BEGIN
      cmd = cmd	+ " 'epsbs=" + string(Twin, Format='(%"ept%02d_")') + "' 'obs=hmean'"
    ENDELSE
    spawn, cmd,	unit=unit
    readf, unit, nhist, nfrc
    CRH[i, j, 0, *] = INDGEN(NR + 2)
    CRH[i, j, 1, *] = [  0.0 ]
    CRH[i, j, 2, *] = [ -1.0 ]

    ; Strange enough, "read, unit, crh[*, i]" does not work but then, it is
    ; no longer necessary, as this works more sophisticated, and not all bins
    ; need to be filled/present.
    CRH[i, j, *,    0] = [ 0.0, 0.0,   0.0]
    CRH[i, j, *, NR+1] = [NR+1, 0.0, 100.0]
    FOR k = 1, nhist DO BEGIN
      readf, unit, r, h, c
      CRH[i, j, *, r] = [ r, h, c ]
    ENDFOR
    close, unit
    free_lun, unit

    FOR k = 1, NR DO BEGIN
      IF CRH[i, j, 2, k] LT 0 THEN CRH[i, j, 2, k] = CRH[i, j, 2, k-1]
    ENDFOR
  ENDFOR
ENDFOR

RETURN
END
