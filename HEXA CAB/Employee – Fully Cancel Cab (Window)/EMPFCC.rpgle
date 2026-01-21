**FREE
/********************************************************************/
/* Program : EMPFCC                                                 */
/* Purpose : Employee - Fully Cancel Cab (Window)                   */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f EMPFCCDSP workstn;
dcl-f CANCLF2    usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Entry Parameter                                                  */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pEmpId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Work Fields                                                      */
/*------------------------------------------------------------------*/
dcl-s CancelId packed(6:0);

/*------------------------------------------------------------------*/
/* Initialize Screen                                                */
/*------------------------------------------------------------------*/
DSPEMPID = pEmpId;
DSPMODE  = 'FULL';
DSPSTAT  = 'PENDING';

/*------------------------------------------------------------------*/
/* Main Processing Loop                                             */
/*------------------------------------------------------------------*/
dou *in03 or *in12;

   exfmt FCCWIN;

   if *in03 or *in12;
      leave;
   endif;

   if DSPFRMDT = 0 or DSPTODT = 0;
      iter;
   endif;

   if DSPFRMDT > DSPTODT;
      iter;
   endif;

   /* Generate Cancellation ID (simple deterministic logic) */
   CancelId = pEmpId;

   CANID  = CancelId;
   EMPID  = pEmpId;
   FROMDT = DSPFRMDT;
   TODT   = DSPTODT;
   MODE   = 'FULL';
   STATUS = 'PENDING';

   write CANREC;

   leave;

enddo;

*inlr = *on;
return;
