**FREE
/*******************************************************************/
/* Service Program : CANCELSVC                                      */
/* Purpose        : Cancel Cab Business Logic                       */
/*******************************************************************/
ctl-opt dftactgrp(*no) actgrp(*caller);

/*-----------------------------------------------------------------*/
/* Prototypes                                                       */
/*-----------------------------------------------------------------*/
dcl-pr ValidateDates ind;
   pFrom packed(8:0);
   pTo   packed(8:0);
end-pr;

dcl-pr GenCancelId packed(6:0);
   pEmp packed(6:0);
end-pr;

/*-----------------------------------------------------------------*/
/* Procedure : ValidateDates                                       */
/*-----------------------------------------------------------------*/
dcl-proc ValidateDates;
   dcl-pi *n ind;
      pFrom packed(8:0);
      pTo   packed(8:0);
   end-pi;

   if pFrom > pTo;
      return *off;
   endif;

   return *on;
end-proc;

/*-----------------------------------------------------------------*/
/* Procedure : GenCancelId                                         */
/*-----------------------------------------------------------------*/
dcl-proc GenCancelId;
   dcl-pi *n packed(6:0);
      pEmp packed(6:0);
   end-pi;

   return pEmp;
end-proc;

