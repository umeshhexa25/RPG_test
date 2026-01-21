**FREE
/********************************************************************/
/* Program : EMPCOMVW                                               */
/* Purpose : Employee - Window View Complaint Status                */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f EMPCOMVWDSP workstn;
dcl-f COMPLLFV    usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Entry Parameter                                                  */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pEmpId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Subfile Control                                                  */
/*------------------------------------------------------------------*/
dcl-s rrn int(5) inz(0);

/*------------------------------------------------------------------*/
/* Main Flow                                                        */
/*------------------------------------------------------------------*/
clearSubfile();
loadComplaints();

dou *in03 or *in12;
   exfmt COMVCTL;
enddo;

*inlr = *on;
return;

/*******************************************************************/
/* Function: clearSubfile                                          */
/*******************************************************************/
dcl-proc clearSubfile;
   rrn = 0;
end-proc;

/*******************************************************************/
/* Function: loadComplaints                                        */
/*******************************************************************/
dcl-proc loadComplaints;

   setll pEmpId COMPLLFV;

   dow '1' = '1';
      read COMPLLFV;
      if %eof(COMPLLFV);
         leave;
      endif;

      if EMPID <> pEmpId;
         leave;
      endif;

      rrn += 1;
      SFLCMPID = COMPID;
      SFLCABID = CABID;
      SFLDRVNO = DRVNO;
      SFLDESC  = DESCR;
      SFLSTAT  = STATUS;

      write COMVSFL;
   enddo;

end-proc;
