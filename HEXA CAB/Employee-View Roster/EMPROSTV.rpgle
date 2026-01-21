**FREE
/********************************************************************/
/* Program : EMPROSTV                                                */
/* Purpose : Employee - View Roster                                  */
/* Type    : RPGLE Free Format                                       */
/* Notes   : Uses Logical File ROSTLF1 only                           */
/********************************************************************/

ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f EMPROSTDSP workstn;
dcl-f ROSTLF1    usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Indicators                                                       */
/*------------------------------------------------------------------*/
dcl-ds Inds;
   ExitKey     ind pos(3);   // F3
end-ds;

/*------------------------------------------------------------------*/
/* Subfile Fields                                                   */
/*------------------------------------------------------------------*/
dcl-s SflRrn     int(5) inz(0);

/*------------------------------------------------------------------*/
/* Entry Parameter                                                  */
/*------------------------------------------------------------------*/
dcl-s pEmpId     packed(6:0);

/*------------------------------------------------------------------*/
/* Data from Logical File                                           */
/*------------------------------------------------------------------*/
dcl-s ROSTDT     packed(8:0);
dcl-s CABID      packed(5:0);
dcl-s CABNO      char(10);
dcl-s DRVNAME    char(30);
dcl-s PICKUPTM   char(10);

/*------------------------------------------------------------------*/
/* Entry Point                                                      */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pEmpId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Main Processing                                                  */
/*------------------------------------------------------------------*/
exsr ClearSubfile;
exsr LoadSubfile;
exsr DisplayScreen;

*inlr = *on;
return;

/*------------------------------------------------------------------*/
/* Subroutine : Clear Subfile                                       */
/*------------------------------------------------------------------*/
begsr ClearSubfile;
   SflRrn = 0;
   *inlr = *off;
endsr;

/*------------------------------------------------------------------*/
/* Subroutine : Load Subfile                                        */
/*------------------------------------------------------------------*/
begsr LoadSubfile;

   setll pEmpId ROSTLF1;

   dow '1' = '1';
      read ROSTLF1;
      if %eof(ROSTLF1);
         leave;
      endif;

      if EMPID <> pEmpId;
         leave;
      endif;

      SflRrn += 1;

      SFLROSTDT = ROSTDT;
      SFLCABID  = CABID;
      SFLCABNO  = CABNO;
      SFLDRVNM  = DRVNAME;
      SFLPICKTM = PICKUPTM;

      write SFL01;
   enddo;

endsr;

/*------------------------------------------------------------------*/
/* Subroutine : Display Screen                                      */
/*------------------------------------------------------------------*/
begsr DisplayScreen;

   dou ExitKey;
      exfmt SFLCTL01;
   enddo;

endsr;

