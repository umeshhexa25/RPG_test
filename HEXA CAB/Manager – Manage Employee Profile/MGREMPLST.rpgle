**FREE
/********************************************************************/
/* Program : MGREMPLST                                              */
/* Purpose : Manager - Manage Employee Profile (Caller)             */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f MGREMPDSP workstn;
dcl-f EMPLFMGR  usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Callee Prototype                                                 */
/*------------------------------------------------------------------*/
dcl-pr EMPUPDW extpgm('MGREMPUPD');
   pEmpId packed(6:0);
end-pr;

/*------------------------------------------------------------------*/
/* Work Fields                                                      */
/*------------------------------------------------------------------*/
dcl-s rrn     int(5) inz(0);
dcl-s opt     char(1);
dcl-s selEmp  packed(6:0);

/*------------------------------------------------------------------*/
/* Initial Load                                                     */
/*------------------------------------------------------------------*/
loadSubfile();

/*------------------------------------------------------------------*/
/* Main Loop                                                        */
/*------------------------------------------------------------------*/
dow not (*in03 or *in12);

   exfmt EMPCTL;

   if *in03 or *in12;
      leave;
   endif;

   processOptions();

enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Load-All Subfile                                                 */
/*******************************************************************/
dcl-proc loadSubfile;

   rrn = 0;
   clear EMPSFL;

   setll *loval EMPLFMGR;

   dow '1' = '1';
      read EMPLFMGR;
      if %eof(EMPLFMGR);
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

/*******************************************************************/
/* Process Subfile Options                                          */
/*******************************************************************/
dcl-proc processOptions;

   dow '1' = '1';
      readc EMPSFL;
      if %eof(MGREMPDSP);
         leave;
      endif;

      opt = SFLSEL;

      if opt = '2';
         selEmp = SFLEMPID;
         EMPUPDW(selEmp);
         loadSubfile();
      endif;

   enddo;

end-proc;
