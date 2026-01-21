**FREE
/********************************************************************/
/* Program : ADROSTGEN                                              */
/* Purpose : Admin - Generate Roster                                */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f ADROSTDSP workstn;
dcl-f EMPLFGEN   usage(*input)  keyed;
dcl-f CABLFGEN   usage(*input)  keyed;
dcl-f DRVLFGEN   usage(*input)  keyed;
dcl-f ROSTLFGEN  usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Entry Fields                                                     */
/*------------------------------------------------------------------*/
dcl-s vRosterDt packed(8:0);
dcl-s vShift    char(10);

/*------------------------------------------------------------------*/
/* Main Flow                                                        */
/*------------------------------------------------------------------*/
dou *in03 or *in12;

   exfmt ROSTGEN;

   if *in03 or *in12;
      leave;
   endif;

   if DSPROSDT = 0 or DSPSHIFT = *blanks;
      iter;
   endif;

   vRosterDt = DSPROSDT;
   vShift    = DSPSHIFT;

   generateRoster(vRosterDt : vShift);

enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Subprocedure: generateRoster                                    */
/*******************************************************************/
dcl-proc generateRoster;
   dcl-pi *n;
      pDate  packed(8:0);
      pShift char(10);
   end-pi;

   dcl-s cabId  packed(5:0);
   dcl-s drvNo  packed(6:0);

   setll *loval EMPLFGEN;
   setll *loval CABLFGEN;
   setll *loval DRVLFGEN;

   read CABLFGEN;
   read DRVLFGEN;

   dow not %eof(EMPLFGEN);

      read EMPLFGEN;
      if %eof(EMPLFGEN);
         leave;
      endif;

      if %eof(CABLFGEN) or %eof(DRVLFGEN);
         leave;
      endif;

      ROSTDT  = pDate;
      EMPID   = EMPID;
      EMPNAME = EMPNAME;
      CABID   = CABID;
      DRVNO   = DRVNO;
      DRVNAME = DRVNAME;
      PICKUPTM = pShift;
      DROPTM   = pShift;

      write ROSTREC;

      read CABLFGEN;
      read DRVLFGEN;

   enddo;

end-proc;
