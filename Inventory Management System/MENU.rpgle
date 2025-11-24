F*******************************************************
F* MENU PROGRAM - MIXED FORMAT RPGLE
F*******************************************************
FMENU      CF   E             WORKSTN
 
D*******************************************************
D* Fields
D*******************************************************
D OPTION          S              1A
 
/FREE
   *INLR = *OFF;
   EXSR $INIT;
 
   DOU *IN03 = *ON;
 
      EXFMT MENUSCRN;
 
      OPTION = OPTION;
 
      SELECT;
        WHEN OPTION = '1';
           EXSR $ITEMS;
 
        WHEN OPTION = '2';
           EXSR $LOCSTK;
 
        WHEN OPTION = '3';
           EXSR $POST;
 
        WHEN OPTION = '4';
           EXSR $RPT;
 
        WHEN OPTION = '5';
           LEAVE;
      ENDSL;
 
   ENDDO;
 
   *INLR = *ON;
   RETURN;
/END-FREE
 
C*******************************************************
C* $INIT Initialize screen
C*******************************************************
C     $INIT         BEGSR
C                   Z-ADD0         OPTION
C                   ENDSR
 
C*******************************************************
C* $ITEMS Call Item Maintenance
C*******************************************************
C     $ITEMS        BEGSR
C                   CALL      'WRKITEMS'
C                   ENDSR
 
C*******************************************************
C* $LOCSTK Call Stock By Location
C*******************************************************
C     $LOCSTK       BEGSR
C                   CALL      'LOCSTOCK'
C                   ENDSR
 
C*******************************************************
C* $POST Call Transaction Posting
C*******************************************************
C     $POST         BEGSR
C                   CALL      'POSTTRAN'
C                   ENDSR
 
C*******************************************************
C* $RPT Call Reports Menu
C*******************************************************
C     $RPT          BEGSR
C                   CALL      'RPTMENU'
C                   ENDSR
