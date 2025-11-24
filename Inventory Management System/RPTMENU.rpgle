F*******************************************************
F* REPORT MENU PROGRAM
F*******************************************************
FRPTMENU   CF   E             WORKSTN
 
D OPTION         S              1A
 
/FREE
   *INLR = *OFF;
 
   DOU OPTION = '4';
 
      EXFMT RPTSCR;
      SELECT;
        WHEN OPTION = '1';
          CALL 'RPTITEM';
        WHEN OPTION = '2';
          CALL 'RPTSTKLOC';
        WHEN OPTION = '3';
          CALL 'RPTTRANS';
      ENDSL;
 
   ENDDO;
 
   *INLR = *ON;
   RETURN;
/END-FREE
