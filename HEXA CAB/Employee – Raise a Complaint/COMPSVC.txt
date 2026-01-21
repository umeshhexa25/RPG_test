**FREE
/********************************************************************/
/* Service Program : COMPSVC                                        */
/* Purpose        : Complaint Business Services                     */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller);

/*------------------------------------------------------------------*/
/* Prototypes                                                       */
/*------------------------------------------------------------------*/
dcl-pr GenCompId packed(6:0);
   pEmpId packed(6:0);
end-pr;

/*------------------------------------------------------------------*/
/* Procedure : GenCompId                                            */
/*------------------------------------------------------------------*/
dcl-proc GenCompId;
   dcl-pi *n packed(6:0);
      pEmpId packed(6:0);
   end-pi;

   /* Simple deterministic ID logic (can be enhanced later) */
   return pEmpId;

end-proc;
