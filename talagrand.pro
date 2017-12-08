PRO Talagrand, gauge, Dbase=Dbase, DbX=DbX, Work=Work, TFs=TFs, Hobs=Hobs, Astro=Astro, Period=Period, Twin=Twin, Corr=Corr, $
  Blue=Blue, Colours=Colours, Thick=Thick, NoCRH=NoCRH

IF NOT KEYWORD_SET(Colours) THEN BEGIN
  IF KEYWORD_SET(Blue) THEN Colours = [ 42, 39, 35, 36, 37, 43 ] $
                       ELSE Colours = [ 42, 43, 35, 36, 37, 43 ]
ENDIF
IF NOT KEYWORD_SET(Thick)   THEN Thick   = 1.0

spawn, "statid code " + gauge, gg
spawn, "statid name " + gauge, name

getCRH, gg, CRH, Dbase=Dbase, DbX=DbX, Work=Work, TFs=TFs, Hobs=Hobs, Astro=Astro, Period=Period, Twin=Twin, Corr=Corr

scrh = size(CRH, /dimensions)
ndb  = scrh[0] - 1
nc   = scrh[1] - 1
nr   = scrh[3] - 3
SET_PLOT, 'PS'
DEVICE, /COLOR
Device, Filename='/usr/people/wagenaa/Talagrand_diagrams/HVH_192-240_possurge_posastr.eps'
!P.Multi=[0,2,2]




!P.Title = "RH for " + name
IF KEYWORD_SET(Twin) THEN !P.Title = !P.Title + string(Twin, Format='(%" Twin=%d")')
!X.Title = "bin number"
!X.Range = [-1, 53]
!X.Tickv = [0, 10, 20, 30, 40, 50]
!X.Ticks = 5
!X.Minor = 2
!Y.Title = "observed frequency [%]"
!Y.Range = [0, 15]
!Y.Tickv = [0, 2, 4, 6, 8, 10, 12, 14]
!Y.Ticks = 7
!Y.Minor = 2
plot, !X.Range, !Y.Range, /NoData
oplot, !X.Crange, [ 100.0 / 52.0, 100.0 / 52.0 ], Linestyle=1

FOR i = 0, ndb DO BEGIN
  FOR j = 0, nc DO BEGIN
    oplot, CRH[i, j, 0, *] - 1, CRH[i, j, 1, *], $
      Psym=10, Color=Colours[i + (ndb+1) * j], Thick=Thick
  ENDFOR
ENDFOR

IF NOT KEYWORD_SET(NoCRH) THEN BEGIN
  !P.Title = "CRH for " + name
  !X.Title = "EPS probability [%]"
  !X.Range = [0, 100]
  !X.Tickv = [0, 20, 40, 60, 80, 100]
  !X.Ticks = 5
  !X.Minor = 2
  !Y.Range = !X.Range
  !Y.Tickv = !X.Tickv
  !Y.Ticks = !X.Ticks
  !Y.Minor = !X.Minor
  plot, !X.Range, !Y.Range, /NoData
  oplot, !X.Crange, !Y.Crange, Linestyle=2

  FOR i = 0, ndb DO BEGIN
    FOR j = 0, nc DO BEGIN
      oplot, 100.0 * (CRH[i, j, 0, 1:nr] - 1) / (nr - 1), CRH[i, j, 2, 1:nr], $
        Color=Colours[i + (ndb+1) * j], Thick=Thick
    ENDFOR
  ENDFOR
ENDIF
EMPTY
DEVICE, /CLOSE
; Return plotting to the original device:

RETURN
END
