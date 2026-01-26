**FREE
/********************************************************************/
/* Program : MGREMPADD                                              */
/* Purpose : Manager - Add Employee Profile (Caller)                */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f MGREMPADSP workstn;

/*------------------------------------------------------------------*/
/* Callee Prototype                                                 */
/*------------------------------------------------------------------*/
dcl-pr ADDNEWEMP extpgm('MGREMPADC'); end-pr;

/*------------------------------------------------------------------*/
/* Main Loop                                                        */
/*------------------------------------------------------------------*/
dow '1' = '1';

   exfmt EMPADDW;

   if *in12;
      leave;
   endif;

   if DSP_EMP > 0
      and DSP_NAME <> *blanks
      and DSP_STAT <> *blanks;

      ADDNEWEMP();
      leave;

   else;
      iter;
   endif;

enddo;

*inlr = *on;
return;
