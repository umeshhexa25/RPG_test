**FREE
/********************************************************************/
/* Program : MGRCABVW                                               */
/* Purpose : Manager - View Cab Records (Caller)                    */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f MGRCABDSP workstn;
dcl-f CABLFMGR  usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Callee Prototype                                                 */
/*------------------------------------------------------------------*/
dcl-pr CABDTL extpgm('MGRCABDTL');
   pCabId packed(5:0);
end-pr;

/*------------------------------------------------------------------*/
/* Work Fields                                                      */
/*------------------------------------------------------------------*/
dcl-s rrn    int(5) inz(0);
dcl-s opt    char(1);
dcl-s selCab packed(5:0);

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
/* Load Single-Page Subfile                                         */
/*******************************************************************/
dcl-proc loadSubfile;

   rrn = 0;
   clear CABSFL;

   setll *loval CABLFMGR;

   dow '1' = '1';
      read CABLFMGR;
      if %eof(CABLFMGR);
         leave;
      endif;

      rrn += 1;

      SFLSEL   = *blank;
      SFLCABID = CABID;
      SFLCABNO = CABNO;
      SFLMODEL = MODEL;
      SFLDRVID = DRIVERID;
      SFLSTAT  = STATUS;

      write CABSFL;
   enddo;

end-proc;

/*******************************************************************/
/* Process Subfile Options                                          */
/*******************************************************************/
dcl-proc processOptions;

   dow '1' = '1';
      readc CABSFL;
      if %eof(MGRCABDSP);
         leave;
      endif;

      opt = SFLSEL;

      if opt = '5';
         selCab = SFLCABID;
         CABDTL(selCab);
      endif;

   enddo;

end-proc;
