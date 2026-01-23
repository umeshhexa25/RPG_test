**FREE
/********************************************************************/
/* Program : ADMCABUPD                                              */
/* Purpose : Admin - Update Window Manage Cab Profile               */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f ADMCABUDSP workstn;
dcl-f CABLFUPD   usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Work fields                                                      */
/*------------------------------------------------------------------*/
dcl-s rrn        int(5) inz(0);
dcl-s selCabId   packed(5:0);
dcl-s opt        char(1);

/*------------------------------------------------------------------*/
/* Initial Load                                                     */
/*------------------------------------------------------------------*/
loadSubfile();

/*------------------------------------------------------------------*/
/* Main Loop                                                        */
/*------------------------------------------------------------------*/
dow not (*in03 or *in12);

   exfmt CABCTL;

   if *in03 or *in12;
      leave;
   endif;

   processOptions();

enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Load All Subfile                                                 */
/*******************************************************************/
dcl-proc loadSubfile;

   rrn = 0;
   clear CABSFL;

   setll *loval CABLFUPD;

   dow '1' = '1';
      read CABLFUPD;
      if %eof(CABLFUPD);
         leave;
      endif;

      rrn += 1;
      SFLSEL   = *blank;
      SFLCABID = CABID;
      SFLCABNO = CABNO;
      SFLTYPE  = CABTYPE;
      SFLCAP   = CAPACITY;
      SFLSTAT  = STATUS;

      write CABSFL;
   enddo;

end-proc;

/*******************************************************************/
/* Process Subfile Options                                         */
/*******************************************************************/
dcl-proc processOptions;

   dcl-s idx int(5);

   for idx = 1 to rrn;

      readc CABSFL;
      if %eof(ADMCABUDSP);
         leave;
      endif;

      opt = SFLSEL;

      if opt = '2';
         selCabId = SFLCABID;
         updateCab(selCabId);
         loadSubfile();
      endif;

   endfor;

end-proc;

/*******************************************************************/
/* Update Cab Window                                                */
/*******************************************************************/
dcl-proc updateCab;
   dcl-pi *n;
      pCabId packed(5:0);
   end-pi;

   chain pCabId CABLFUPD;
   if %notfound(CABLFUPD);
      return;
   endif;

   DSPCABID = CABID;
   DSPCABNO = CABNO;
   DSPTYPE  = CABTYPE;
   DSPCAP   = CAPACITY;
   DSPSTAT  = STATUS;

   exfmt UPCABW;

   if *in12;
      return;
   endif;

   if *in12 = *off;
      CABNO    = DSPCABNO;
      CABTYPE  = DSPTYPE;
      CAPACITY = DSPCAP;
      STATUS   = DSPSTAT;

      update CABREC;
   endif;

end-proc;
