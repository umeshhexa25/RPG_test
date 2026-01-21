**FREE
/********************************************************************/
/* Program : ADMEMPMT                                               */
/* Purpose : Admin - Manage Employee Profile                        */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio)
        commit(*chg);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f ADMEMPDSP workstn;
dcl-f EMPLFADM  usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Variables                                                        */
/*------------------------------------------------------------------*/
dcl-s rrn        int(5) inz(0);
dcl-s selEmpId  packed(6:0);
dcl-s saveReq   ind inz(*off);

/*------------------------------------------------------------------*/
/* Main                                                             */
/*------------------------------------------------------------------*/
loadSubfile();

dou *in03;

   exfmt EMPCTL;

   if *in12;
      rollback;
      leave;
   endif;

   if *in05;
      commit;
      loadSubfile();
   endif;

enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Load Subfile                                                     */
/*******************************************************************/
dcl-proc loadSubfile;

   rrn = 0;
   clear EMPSFL;

   setll *loval EMPLFADM;

   dow '1' = '1';
      read EMPLFADM;
      if %eof(EMPLFADM);
         leave;
      endif;

      rrn += 1;
      SFLSEL   = *blank;
      SFLEMPID = EMPID;
      SFLNAME  = EMPNAME;
      SFLPHN   = PHONE;
      SFLSTAT  = STATUS;

      write EMPSFL;
   enddo;

end-proc;
