**FREE
/********************************************************************/
/* Program : EMPPCC                                                 */
/* Purpose : Employee - Partially Cancel Cab (Subfile Window)       */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f EMPPCCDSP workstn;
dcl-f CANCLF3    usage(*update) keyed;

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
/* Main Processing                                                  */
/*------------------------------------------------------------------*/
exsr ClearSubfile;
exsr LoadSubfile;

dou *in03 or *in12;

   exfmt PCCCTL;

   if *in03 or *in12;
      leave;
   endif;

   exsr ProcessSelection;

enddo;

*inlr = *on;
return;

/*------------------------------------------------------------------*/
/* Clear Subfile                                                    */
/*------------------------------------------------------------------*/
begsr ClearSubfile;
   rrn = 0;
   *inlr = *off;
endsr;

/*------------------------------------------------------------------*/
/* Load Subfile                                                     */
/*------------------------------------------------------------------*/
begsr LoadSubfile;

   setll pEmpId CANCLF3;

   dow '1' = '1';
      read CANCLF3;
      if %eof(CANCLF3);
         leave;
      endif;

      if EMPID <> pEmpId;
         leave;
      endif;

      rrn += 1;
      SFLSEL  = ' ';
      SFLFRMDT = FROMDT;
      SFLTODT  = TODT;
      SFLMODE  = MODE;
      SFLSTAT  = STATUS;

      write PCCSFL;
   enddo;

endsr;

/*------------------------------------------------------------------*/
/* Process Selected Records                                        */
/*------------------------------------------------------------------*/
begsr ProcessSelection;

   readc PCCSFL;
   dow not %eof(EMPPCCDSP);

      if SFLSEL = 'X';
         MODE   = 'PARTIAL';
         STATUS = 'PENDING';
         update CANREC;
      endif;

      readc PCCSFL;
   enddo;

endsr;
