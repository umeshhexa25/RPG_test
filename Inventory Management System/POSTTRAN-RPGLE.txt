F*******************************************************
F* TRANSACTION POSTING PROGRAM
F*******************************************************
FTRNPOSTD CF   E             WORKSTN
FTRANSACT UF A E           K DISK
FTRANSDET UF A E           K DISK
FITEMS    UF A E           K DISK
FSTKLOC   UF A E           K DISK
 
D TRNID         S              7  0
D TRNTYPE       S              1
D ITEMID        S              5  0
D LOCID         S              5
D QTY           S              9  0
 
/FREE
   *INLR = *OFF;
 
   EXSR $INIT;
 
   DOU *IN03 = *ON;
 
      EXFMT POSTSCRN;
 
      IF *IN05 = *ON;
         EXSR $POST;
      ENDIF;
 
   ENDDO;
 
   *INLR = *ON;
   RETURN;
/END-FREE
 
C*******************************************************
C* $INIT Clear variables
C*******************************************************
C     $INIT         BEGSR
C                   Z-ADD0        TRNID
C                   MOVE *BLANK   TRNTYPE
C                   Z-ADD0        ITEMID
C                   MOVE *BLANK   LOCID
C                   Z-ADD0        QTY
C                   ENDSR
 
C*******************************************************
C* $POST  Perform Posting
C*******************************************************
C     $POST         BEGSR
 
C* Write Transaction Header
C                   MOVELTRNTYPE   TRNTYPE
C                   WRITE TRNHDR
 
C* Write Transaction Detail
C                   MOVELQTY       QTY
C                   WritE TRNDET
 
C* Process Item Master Quantity
C                   CHAINITEMID     ITEMREC
C                   IF %FOUND(ITEMS)
C                   SELECT
C                     WHEN TRNTYPE = 'I'
C                        SUB QTY      QTYONHAND
C                     WHEN TRNTYPE = 'R'
C                        ADD QTY      QTYONHAND
C                     WHEN TRNTYPE = 'A'
C                        MOVE QTY     QTYONHAND
C                   ENDSL
C                   UPDATEITEMREC
C                   ENDIF
 
C                   IF %FOUND(STKLOC)
C                     SELECT
C                       WHEN TRNTYPE = 'I'
C                          SUB QTY     QTY
C                       WHEN TRNTYPE = 'R'
C                          ADD QTY     QTY
C                       WHEN TRNTYPE = 'A'
C                          MOVE QTY    QTY
C                     ENDSL
C                     UPDATESTKREC
C                   ELSE
C                     MOVELQTY        QTY
C                     WRITESTKREC
C                   ENDIF
 
C                   ENDSR
