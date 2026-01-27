**FREE
/********************************************************************/
/* Program : MGRCANVW                                               */
/* Purpose : Manager - View Cancellation Requests                  */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f MGRCANDSP workstn;
dcl-f CANCLFMGR usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Callee Prototype                                                 */
/*------------------------------------------------------------------*/
dcl-pr CANDET extpgm('MGRCANDTL');
   pCanId packed(7:0);
end-pr;

/*------------------------------------------------------------------*/
/* Work Fields                                                      */
/*------------------------------------------------------------------*/
dcl-s rrn     int(5) inz(0);
dcl-s opt     char(1);
dcl-s selCan  packed(7:0);

/*------------------------------------------------------------------*/
/* Initial Load                                                     */
/*------------------------------------------------------------------*/
loadSubfile();

/*------------------------------------------------------------------*/
/* Main Loop                                                        */
/*------------------------------------------------------------------*/
dow not (*in03 or *in12);

   exfmt CANCTL;

   if *in03 or *in12;
      leave;
   endif;

   processOptions();

enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Load Cancellation Requests                                      */
/*******************************************************************/
dcl-proc loadSubfile;

   rrn = 0;
   clear CANSFL;

   setll *loval CANCLFMGR;

   dow '1' = '1';
      read CANCLFMGR;
      if %eof(CANCLFMGR);
         leave;
      endif;

      rrn += 1;

      SFLSEL   = *blank;
      SFLCANID = CANCID;
      SFLEMPID = EMPID;
      SFLCABID = CABID;
      SFLREASN = REASON;
      SFLSTAT  = STATUS;

      write CANSFL;
   enddo;

end-proc;

/*******************************************************************/
/* Process Subfile Options                                          */
/*******************************************************************/
dcl-proc processOptions;

   dow '1' = '1';
      readc CANSFL;
      if %eof(MGRCANDSP);
         leave;
      endif;

      opt = SFLSEL;

      if opt = '5';
         selCan = SFLCANID;
         CANDET(selCan);
      endif;

   enddo;

end-proc;
