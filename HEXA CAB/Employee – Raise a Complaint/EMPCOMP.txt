**FREE
/********************************************************************/
/* Program : EMPCOMP                                                */
/* Purpose : Employee - Raise a Complaint                           */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f EMPCOMPDSP workstn;
dcl-f COMPLLFEMP usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Service Program Prototype (CALLEE)                               */
/*------------------------------------------------------------------*/
dcl-pr GenCompId packed(6:0) extproc('GenCompId');
   pEmpId packed(6:0);
end-pr;

/*------------------------------------------------------------------*/
/* Entry Parameter                                                  */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pEmpId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Initialize Screen                                                */
/*------------------------------------------------------------------*/
DSPEMPID = pEmpId;
DSPSTAT  = 'OPEN';

/*------------------------------------------------------------------*/
/* Main Processing Loop (Decision Nodes)                            */
/*------------------------------------------------------------------*/
dou *in03 or *in12;

   exfmt COMPLENTR;

   /* Decision Node – Exit */
   if *in03 or *in12;
      leave;
   endif;

   /* Decision Node – Validation */
   if DSPDESC = *blanks;
      iter;
   endif;

   /* Generate Complaint ID using CALLEE */
   COMPID = GenCompId(pEmpId);

   /* Populate DB Fields */
   EMPID   = pEmpId;
   CABID   = DSPCABID;
   DRVNO   = DSPDRVNO;
   DESCR   = DSPDESC;
   STATUS  = 'OPEN';

   /* Write Complaint */
   write COMPREC;

   leave;

enddo;

*inlr = *on;
return;
