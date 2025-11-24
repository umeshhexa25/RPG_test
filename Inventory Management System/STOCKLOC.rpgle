F*******************************************************
F* STOCK BY LOCATION MAINTENANCE
F*******************************************************
FSTKLOCD  CF   E             WORKSTN
FSTKLOC   UF A E           K DISK
 
D ITEMID        S              5  0
D LOCID         S              5
D QTY           S              9  0
 
/FREE
   *INLR = *OFF;
   EXSR $INIT;
 
   DOU *IN03 = *ON;
 
      EXFMT STKSCREEN;
 
      IF *IN05 = *ON;
         EXSR $ADD;
      ELSEIF *IN06 = *ON;
         EXSR $CHG;
      ELSEIF *IN12 = *ON;
         EXSR $DEL;
      ELSE;
         EXSR $LOAD;
      ENDIF;
 
   ENDDO;
 
   *INLR = *ON;
   RETURN;
/END-FREE
 
C*******************************************************
C* $INIT Clear variables
C*******************************************************
C     $INIT         BEGSR
C                   Z-ADD0        ITEMID
C                   MOVE *BLANK   LOCID
C                   Z-ADD0        QTY
C                   ENDSR
 
C*******************************************************
C* $LOAD Load existing item/location
C*******************************************************
C     $LOAD         BEGSR
C                   IF %FOUND(STKLOC)
C                   MOVE QTY           QTY
C                   ENDIF
C                   ENDSR
 
C*******************************************************
C* $ADD Add New Stock Record
C*******************************************************
C     $ADD          BEGSR
C                   MOVELQTY          QTY
C                   WRITE STKREC
C                   ENDSR
 
C*******************************************************
C* $CHG Update Existing Stock
C*******************************************************
C     $CHG          BEGSR
C                   IF %FOUND
C                   MOVELQTY           QTY
C                   UPDATESTKREC
C                   ENDIF
C                   ENDSR
 
C*******************************************************
C* $DEL Delete Stock Record
C*******************************************************
C     $DEL          BEGSR
C                   IF %FOUND
C                   DELETESTKREC
C                   ENDIF
C                   ENDSR
