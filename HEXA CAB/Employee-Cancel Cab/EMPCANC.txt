**FREE
/*******************************************************************/
/* Program : EMPCANC                                                */
/* Purpose : Employee Cancel Cab                                    */
/*******************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*-----------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f EMPCANCDSP workstn;
dcl-f CANCLF1    usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Service Program Prototypes                                       */
/*------------------------------------------------------------------*/
dcl-pr ValidateDates ind extproc('ValidateDates');
   pFrom packed(8:0);
   pTo   packed(8:0);
end-pr;

dcl-pr GenCancelId packed(6:0) extproc('GenCancelId');
   pEmp packed(6:0);
end-pr;

/*------------------------------------------------------------------*/
/* Entry Parameter                                                  */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pEmpId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Main Logic                                                       */
/*------------------------------------------------------------------*/
DSPEMPID = pEmpId;
DSPSTAT  = 'PENDING';

dou *in03 or *in12;

   exfmt CANCENTR;

   if *in03 or *in12;
      leave;
   endif;

   if not ValidateDates(DSPFRMDT : DSPTODT);
      iter;
   endif;

   CANID  = GenCancelId(pEmpId);
   EMPID  = pEmpId;
   FROMDT = DSPFRMDT;
   TODT   = DSPTODT;
   MODE   = DSPMODE;
   STATUS = 'PENDING';

   write CANREC;

enddo;

*inlr = *on;
return;
