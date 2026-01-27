**FREE
/********************************************************************/
/* Program : MGRDAYRQ                                               */
/* Purpose : Manager - View Daily Requests                          */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f MGRREQDSP workstn;
dcl-f REQDTLFL  usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Data Area                                                        */
/*------------------------------------------------------------------*/
dcl-s bizDate char(8);
dcl-ds dtaaraDs extname('HEXABIZDT') end-ds;

/*------------------------------------------------------------------*/
/* Callee Prototype                                                 */
/*------------------------------------------------------------------*/
dcl-pr REQDTL extpgm('MGRREQDTL');
   pReqId packed(7:0);
end-pr;

/*------------------------------------------------------------------*/
/* Work Fields                                                      */
/*------------------------------------------------------------------*/
dcl-s rrn    int(5) inz(0);
dcl-s opt    char(1);
dcl-s selReq packed(7:0);

/*------------------------------------------------------------------*/
/* Read Business Date                                               */
/*------------------------------------------------------------------*/
bizDate = dtaaraDs;
DSPDATE = bizDate;

/*------------------------------------------------------------------*/
/* Initial Load                                                     */
/*------------------------------------------------------------------*/
loadSubfile();

/*------------------------------------------------------------------*/
/* Main Loop                                                        */
/*------------------------------------------------------------------*/
dow not (*in03 or *in12);

   exfmt REQCTL;

   if *in03 or *in12;
      leave;
   endif;

   processOptions();

enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Load Daily Requests                                              */
/*******************************************************************/
dcl-proc loadSubfile;

   rrn = 0;
   clear REQSFL;

   setll bizDate REQDTLFL;

   dow '1' = '1';
      read REQDTLFL;
      if %eof(REQDTLFL) or REQDATE <> bizDate;
         leave;
      endif;

      rrn += 1;
      SFLSEL   = *blank;
      SFLREQID = REQID;
      SFLEMPID = EMPID;
      SFLREQTM = REQTIME;
      SFLPICK  = PICKUP;
      SFLDROP  = DROPLOC;

      write REQSFL;
   enddo;

end-proc;

/*******************************************************************/
/* Process Subfile Options                                          */
/*******************************************************************/
dcl-proc processOptions;

   dow '1' = '1';
      readc REQSFL;
      if %eof(MGRREQDSP);
         leave;
      endif;

      opt = SFLSEL;

      if opt = '5';
         selReq = SFLREQID;
         REQDTL(selReq);
      endif;

   enddo;

end-proc;
