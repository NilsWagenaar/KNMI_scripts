/*-------------------------------------------------------------------------------------------*
 *
 ***** rankeps - Calculate Ensemble rankings
 *
 * Purpose:
 * --------
 *
 * Calulate the Ensemble Rankings for water level forecasts for use in
 * Talagrand diagrams and Cumulative Rank Histograms.
 * This revised version does not use the forecast ranks, but counts the number of levels
 * below and above the observation. For debugging purposes in the Identical Twin Experiment,
 * the number of coinciding intervals and the random number choice can also be stored.
 *
 *
 * Interface:
 * ----------
 *
 * % rankeps [ <options> ] <gauge> ...
 *
 *
 * Author:
 * -------
 *
 * Hans de Vries	*Copyright © KNMI*		October 14, 2005
 *
 *
 * Modifications:
 * --------------
 *
 * $Log: rankeps.c,v $
 * Revision 1.17  2012/05/04 15:59:54  jwdv
 * New get-address-command interface for cli
 *
 * Revision 1.16  2009/09/17 16:45:15  jwdv
 * Preferred ANSI version of random generator is rand()
 *
 * Revision 1.15  2008/08/22 16:55:45  jwdv
 * New calculation of EPS ranks implemented, tested as rankeps2.c
 *
 * Revision 1.14  2008/08/22 13:34:24  jwdv
 * 1. Identical Twin Experiment implemented
 * 2. Make use of more sophisticated capabilities of DESCRIBE
 *
 * Revision 1.13  2008/08/08 16:56:38  jwdv
 * Identical Twin experiment facilitated
 *
 * Revision 1.12  2007/08/01 11:47:51  jwdv
 * 1. Full database names implemented in rankeps
 * 2. splitdtg does not require unnecessary variables anymore
 *
 * Revision 1.11  2007/07/16 14:51:38  jwdv
 * SunOS does not like $s in defines
 *
 * Revision 1.10  2006/08/16 14:42:05  jwdv
 * 1. Brier can now also use prepared results from jodiex
 * 2. Jodiex adds column season and has an error corrected for the correction
 *
 * Revision 1.9  2006/08/03 12:02:35  jwdv
 * 1. Differences needed for Brier scores for negative and positive levels
 * 2. Queries do not seem to need ;-s or \n-s.
 *
 * Revision 1.8  2006/07/26 16:23:47  jwdv
 * Corrected rank added to the database tables
 *
 * Revision 1.7  2006/07/24 15:43:03  jwdv
 * Connecting to the database centralized in one routine
 *
 * Revision 1.6  2006/04/24 13:01:05  jwdv
 * 1. mysql uses MYSQL_HOST rather than MYSQL_SERVER
 * 2. Some details in administration
 *
 * Revision 1.5  2006/03/21 13:02:25  jwdv
 * Deterministic added, which means that N=52 now
 *
 * Revision 1.4  2005/10/24 16:28:40  jwdv
 * Main program should be an integer finction and return a value
 *
 * Revision 1.3  2005/10/21 16:05:23  jwdv
 * do_mquery needed the address of mysql
 *
 * Revision 1.2  2005/10/21 15:06:28  jwdv
 * 1. Take absolute surges
 * 2. Forgot to count the last bin
 *
 * Revision 1.1  2005/10/19 11:13:05  jwdv
 * Initial revision
 *
 *===========================================================================================*/

#include        "stateps.h"

int		verbose   = 0;


int	main(int argc, char *argv[])
{
typedef enum	{o_dbxt, o_dbnm, o_vrb, o_cor, o_old, o_syr, o_twn, o_mlt, n_mlt, o_end} o_list;
typedef enum	{m_std, m_twn, m_mlt, m_not} m_list;

command         *opts     = NULL;
command         *gauges   = NULL;
io_result	res;
int		yy;
wlstation       *g;
o_list          idx;
char            *dbid     = "EPSx";
Flag		useyy     = true;
Flag		corrected = false;
char		eps[32], frc[32];
char            query[1024], *rname;
MYSQL           mysql;
MYSQL_RES       *epsres, *frcres;
MYSQL_ROW       epsval, frcval;
int		twin      = UNDEF;
int		i, n, hobs, hmean, nup, ndn, rank, mult, rndm;
m_list		mmode = m_std;

inirdm();		/* Initialize the random generator with a random seed */
cinit(argc, argv);
caddmsg(RNK_USE, "Usage: rankeps [ <options> ] <gauge>...");
caddmsg(RNK_MYI, "Failed to initialize MySQL database");
caddmsg(RNK_MYX, "MySQL failure");

caddcd(&opts, "dbext",     (cmdindex) o_dbxt);
caddcd(&opts, "dbname",    (cmdindex) o_dbnm);
caddcd(&opts, "verbose",   (cmdindex) o_vrb);
caddcd(&opts, "corrected", (cmdindex) o_cor);
caddcd(&opts, "oldtname",  (cmdindex) o_old);
caddcd(&opts, "year",      (cmdindex) o_syr);
caddcd(&opts, "twin",      (cmdindex) o_twn);
caddcd(&opts, "mult",      (cmdindex) o_mlt);
caddcd(&opts, "nomult",    (cmdindex) n_mlt);

for (g = statini(); g != NULL; g = g->next)
  if (g->code % 1000 != 0)
    cadrcd(&gauges, g->mnemo, (void *) g);

splitdtg(curdtg(), &yy, NULL, NULL, NULL);

cdefcd(opts);
do
  {
  cgetop(allowdflt, (cmdindex) o_end, &res, (cmdindex *) &idx);
  switch (idx)
    {
    case o_dbxt:	/* Select database name extension (experiment) */
      cgetst(valreq, "", &res, &dbid);
      break;
    case o_dbnm:	/* Select database full name */
      cgetst(valreq, "", &res, &dbid);
      use_dbprefix = false;
      break;
    case o_vrb:		/* Set or step verbosity level */
      cgetin(allowdflt, verbose + 1, &res, &verbose);
      break;
    case o_cor:		/* Use corrected ensembles */
      corrected = true;
      break;
    case o_old:		/* Use old table names, without year */
      useyy = false;
      break;
    case o_syr:		/* Choose a (different) year */
      cgetin(valreq, 0, &res, &yy);
      break;
    case o_twn:		/* Perform Identical Twin Experiment */
      mmode  = m_twn;
      cgetin(allowdflt, 1, &res, &twin);
      break;
    case o_mlt:		/* Multiplicity mode on ITE */
      mmode  = m_mlt;
      cgetin(allowdflt, 1, &res, &twin);
      break;
    case n_mlt:		/* Not in multiplicity mode on ITE */
      mmode  = m_not;
      cgetin(allowdflt, 1, &res, &twin);
      break;
    case o_end:		/* No more options */
      break;
    }
  }
while (idx != o_end);

mconnect(&mysql, dbid)

cdefcd(gauges);
for (cgtadr(valreq, NULL, &res, (void **) &g);
     g != NULL;
     cgtadr(allowdflt, NULL, &res, (void **) &g))
  {
  if (useyy)
    {
    if (twin == UNDEF)
      sprintf(eps, "eps%05d_%04d", g->code, yy);
    else
      sprintf(eps, "ept%02d_%05d_%04d", twin, g->code, yy);
    sprintf(frc, "frc%05d_%04d", g->code, yy);
    }
  else
    {
    

    if (twin == UNDEF)
      sprintf(eps, "eps%05d", g->code);
    else
      sprintf(eps, "ept%02d_%05d", twin, g->code);
    sprintf(frc, "frc%05d", g->code);
    }
  if (verbose > 2)
    fprintf(stderr, "rankeps -- Twin = %d; eps table is %s\n", twin == UNDEF ? 999 : twin, eps);
  if (corrected)
    { /* Add column for corrected rank, if not present yet */
    sprintf(query, "DESCRIBE %s rank1", eps);
    
    epsres = do_mquery(query, &mysql);
    if (mysql_num_rows(epsres) != 1)
      {
      sprintf(query, "ALTER TABLE %s ADD rank1 TINYINT(4) DEFAULT NULL AFTER rank", eps);
      (void) do_mquery(query, &mysql);
      }
    mysql_free_result(epsres);
    /* Build query for corrected version */
   /*sprintf(query, "SELECT tastr, dtg, hobs, hmean, tf, ROUND(a0 + a1*sigma)");*/
    sprintf(query, "SELECT tastr, dtg, hobs, hmean, tf, ROUND(a1*sigma)")
    sprintf(query, "%s FROM %s, corr", query, eps);
    sprintf(query, "%s WHERE N=%d", query, N_ENS);
    sprintf(query, "%s   AND hobs IS NOT NULL", query);
    sprintf(query, "%s   AND code=%05d", query, g->code);
    sprintf(query, "%s   AND tf > tfmin", query);
    sprintf(query, "%s   AND tf <= tfmax", query);
    sprintf(query, "%s   AND astro * hastr > 0", query);
    sprintf(query, "%s   AND (surge * hobs > 0 OR (hobs = 0 AND surge=1));\n", query);
    rname = "rank1";
    mmode = m_std;
    }
  else
    {
    switch (mmode)		/* Setup table and what to update */
      {
      case m_std:		/* Standard mode: do not store multiplicity and upate rank column */
	rname = "rank";
	break;
      case m_twn:		/* ITE: presence of a mult column determines whether to store the
				   multiplicity and the random choice as well */
	sprintf(query, "DESCRIBE %s mult", eps);
	epsres = do_mquery(query, &mysql);
	mmode = mysql_num_rows(epsres) == 1 ? m_mlt : m_not;
	rname = mmode == m_mlt ? "rank1" : "rank";
	mysql_free_result(epsres);
	break;
      case m_mlt:		/* ITE: add mult and random columns if not present and fill them */
	sprintf(query, "DESCRIBE %s mult", eps);
	epsres = do_mquery(query, &mysql);
	if (mysql_num_rows(epsres) != 1)
	  {
	  sprintf(query, "ALTER TABLE %s", eps);
	  sprintf(query, "%s ADD mult   TINYINT(4) DEFAULT NULL AFTER rank1,", query);
	  sprintf(query, "%s ADD random TINYINT(4) DEFAULT NULL AFTER mult", query);
	  (void) do_mquery(query, &mysql);
	  }
	mysql_free_result(epsres);
	rname = "rank1";
	break;
      case m_not:		/* ITE: update rank and do not use mult and random */
	rname = "rank";
	break;
      }
    sprintf(query, "SELECT tastr, dtg, hobs, hmean, tf");	/* Build the query for the uncorrected version */
    sprintf(query, "%s FROM %s", query, eps);
    sprintf(query, "%s WHERE N=%d AND hobs IS NOT NULL", query, N_ENS);
    }
  epsres = do_mquery(query, &mysql);

  while ((epsval = mysql_fetch_row(epsres)) != NULL)	/* Loop over all forecasts */
    {
    hobs  = atoi(epsval[2]);
    hmean = atoi(epsval[3]);
    if (verbose > 3)
      fprintf(stderr, "rankeps -- Forecast %+4d for %s: %6s", atoi(epsval[4]), epsval[0], epsval[2]);
    sprintf(query,   "SELECT count(*) FROM %s", frc);
    sprintf(query,   "%s WHERE tastr = \"%s\"", query, epsval[0]);
    sprintf(query,   "%s   AND dtg   = \"%s\"", query, epsval[1]);
    if (corrected)
      sprintf(query, "%s   AND hmod - %s > %s", query, epsval[5], epsval[2]);
    else
      sprintf(query, "%s   AND hmod      > %s", query, epsval[2]);
    frcres = do_mquery(query, &mysql);
    if ((frcval = mysql_fetch_row(frcres)) != NULL)
      nup = atoi(frcval[0]);
    else
      nup = 0;
    mysql_free_result(frcres);
    sprintf(query,   "SELECT count(*) FROM %s", frc);
    sprintf(query,   "%s WHERE tastr = \"%s\"", query, epsval[0]);
    sprintf(query,   "%s   AND dtg   = \"%s\"", query, epsval[1]);
    if (corrected)
      sprintf(query, "%s   AND hmod - %s < %s", query, epsval[5], epsval[2]);
    else
      sprintf(query, "%s   AND hmod      < %s", query, epsval[2]);
    frcres = do_mquery(query, &mysql);
    if ((frcval = mysql_fetch_row(frcres)) != NULL)
      ndn = atoi(frcval[0]);
    else
      ndn = 0;
    mysql_free_result(frcres);
    mult = N_ENS - ndn - nup + 1;
    if (mult > 1)
      rndm = rand() % mult;
    else
      rndm = 0;
    /* For positive surges and negative surges, the rank is just opposite to reflect the idea
     * of a more serious surge being more positive if positive and more negative if negative.
     * What to use for to distinguish positive from negative surges?
     * The original choice was the observation, but, maybe, that is not the best choice. In
     * forecast mode you do not know the observation yet.
     * For ITE you definitely need hmean, because hobs is hmod and that will bias the rank
     * to higher values.
     */
    if (((mmode == m_std) && (hobs >= 0)) || ((mmode != m_std) && (hmean >= 0)))
      rank = ndn + rndm + 1;
    else
      rank = nup + rndm + 1;
    sprintf(query, "UPDATE %s", eps);
    sprintf(query, "%s SET %s=%d", query, rname, rank);
    if (mmode == m_mlt)
      sprintf(query, "%s, mult=%d, random=%d", query,  mult, rndm);
    sprintf(query, "%s WHERE tastr='%s' AND dtg='%s'", query, epsval[0], epsval[1]);
    (void) do_mquery(query, &mysql);
    }
  mysql_free_result(epsres);
  }

mysql_close(&mysql);

return 0;
}

