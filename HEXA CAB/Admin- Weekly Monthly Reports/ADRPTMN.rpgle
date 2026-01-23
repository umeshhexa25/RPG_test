**FREE
/********************************************************************/
/* Program : ADRPTMN                                                */
/* Purpose : Admin - Weekly / Monthly Reports (Caller)              */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f ADRPTDSP workstn;

/*------------------------------------------------------------------*/
/* Prototypes                                                       */
/*------------------------------------------------------------------*/
dcl-pr GENRPT extpgm('ADRPTCL');
   pType  char(1);
   pFrom  packed(8:0);
   pTo    packed(8:0);
   oTrip  packed(5:0);
   oEmp   packed(5:0);
   oComp  packed(5:0);
   oClose packed(5:0);
end-pr;

/*------------------------------------------------------------------*/
/* Main Loop                                                        */
/*------------------------------------------------------------------*/
dow not (*in03 or *in12);

   exfmt RPTSEL;

   if *in03 or *in12;
      leave;
   endif;

   if DSPTYPE = 'W' or DSPTYPE = 'M';

      GENRPT(DSPTYPE : DSPFROM : DSPTO :
             DSPTRIP : DSPEMP : DSPCOMP : DSPCLSD);

   else;
      /* Invalid report type – redisplay */
      iter;
   endif;

enddo;

*inlr = *on;
return;
