**FREE
/********************************************************************/
/* Program : MGREMPUPD                                              */
/* Purpose : Manager - View / Update Employee Window                */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f ADMEMUPDSP workstn;     // Reused standard update window DSPF
dcl-f EMPLFMGR   usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Parameter                                                        */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pEmpId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Fetch Record                                                     */
/*------------------------------------------------------------------*/
chain pEmpId EMPLFMGR;
if %notfound(EMPLFMGR);
   return;
endif;

/*------------------------------------------------------------------*/
/* Load Fields                                                      */
/*------------------------------------------------------------------*/
DSP_EMP   = EMPID;
DSP_NAME  = EMPNAME;
DSP_ADDR  = ADDRESS;
DSP_PHONE = PHONE;
DSP_STAT  = STATUS;

/*------------------------------------------------------------------*/
/* Window                                                           */
/*------------------------------------------------------------------*/
exfmt EMPUPD;

if *in12;
   return;
endif;

/*------------------------------------------------------------------*/
/* Update Allowed Fields                                            */
/*------------------------------------------------------------------*/
if DSP_STAT = 'Y' or DSP_STAT = 'N';
   EMPNAME = DSP_NAME;
   ADDRESS = DSP_ADDR;
   PHONE   = DSP_PHONE;
   STATUS  = DSP_STAT;
   update EMPREC;
endif;

return;
