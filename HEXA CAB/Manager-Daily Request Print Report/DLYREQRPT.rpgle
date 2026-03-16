**FREE
/********************************************************************/
/* Program : DLYREQRPT                                              */
/* Purpose : Manager Daily Cab Request Report                       */
/********************************************************************/

ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio)
        commit(*none);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f REQRPT printer;

/*------------------------------------------------------------------*/
/* Variables                                                        */
/*------------------------------------------------------------------*/
dcl-s vDate char(10);
dcl-s vEmpId packed(6:0);
dcl-s vEmpName char(30);
dcl-s vCabNo char(10);
dcl-s vPickup char(8);
dcl-s vStatus char(10);

/*------------------------------------------------------------------*/
/* SQL Cursor                                                       */
/*------------------------------------------------------------------*/
exec sql
   declare C1 cursor for
   select EMPID,
          EMPNAME,
          CABNO,
          PICKUPTM,
          STATUS
   from CABREQUEST
   where REQDATE = CURRENT_DATE;

/*------------------------------------------------------------------*/
/* Print Header                                                     */
/*------------------------------------------------------------------*/

vDate = %char(%date());

RPTDATE = vDate;
write RPTHEAD;

/*------------------------------------------------------------------*/
/* Open Cursor                                                      */
/*------------------------------------------------------------------*/

exec sql
   open C1;

/*------------------------------------------------------------------*/
/* Fetch Loop                                                       */
/*------------------------------------------------------------------*/

dou SQLCODE <> 0;

   exec sql
      fetch C1
      into :vEmpId,
           :vEmpName,
           :vCabNo,
           :vPickup,
           :vStatus;

   if SQLCODE = 0;

      EMPID    = vEmpId;
      EMPNAME  = vEmpName;
      CABNO    = vCabNo;
      PICKTIME = vPickup;
      STATUS   = vStatus;

      write RPTDTL;

   endif;

enddo;

/*------------------------------------------------------------------*/
/* Close Cursor                                                     */
/*------------------------------------------------------------------*/

exec sql
   close C1;

/*------------------------------------------------------------------*/
*inlr = *on;
return;
