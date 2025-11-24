F*******************************************************
F* ITEM MAINTENANCE PROGRAM
F*******************************************************
FITEMMAST CF   E             WORKSTN
FITEMS    UF A E           K DISK

D ITEMID        S              5  0
D ITEMNAME      S             30
D UOM           S              3
D PRICE         S              9  2
D QTYONHAND     S              9  0

 /FREE
   *INLR = *OFF;

   EXSR $INIT;

   DOU *IN03 = *ON;

      EXFMT ITEMSCRN;

      IF *IN05 = *ON;     // ADD
         EXSR $ADD;
      ELSEIF *IN06 = *ON; // UPDATE
         EXSR $CHG;
      ELSEIF *IN12 = *ON; // DELETE
         EXSR $DEL;
      ELSE;
         EXSR $LOAD;     // Load record for display
      ENDIF;

   ENDDO;

   *INLR = *ON;
   RETURN;
 /END-FREE

C*******************************************************
C* $INIT Clear screen
C*******************************************************
C     $INIT         BEGSR
C                   Z-ADD0         ITEMID
C                   MOVE *BLANK     ITEMNAME
C                   MOVE *BLANK     UOM
C                   Z-ADD0         PRICE
C                   Z-ADD0         QTYONHAND
C                   ENDSR

C*******************************************************
C* $LOAD Load existing item
C*******************************************************
C     $LOAD         BEGSR
C                   CHAIN ITEMID   ITEMREC
C                   IF %FOUND(ITEMS)
C                   MOVE ITEMNAME   ITEMNAME
C                   MOVE UOM        UOM
C                   MOVE PRICE      PRICE
C                   MOVE QTYONHAND  QTYONHAND
C                   ENDIF
C                   ENDSR

C*******************************************************
C* $ADD new record
C*******************************************************
C     $ADD          BEGSR
C                   MOVELITEMNAME   ITEMNAME
C                   MOVELUOM        UOM
C                   MOVELPRICE      PRICE
C                   MOVELQTYONHAND  QTYONHAND
C                   WRITEITEMREC
C                   ENDSR

C*******************************************************
C* $CHG Update record
C*******************************************************
C     $CHG          BEGSR
C                   CHAINITEMID     ITEMREC
C                   IF %FOUND
C                   MOVELITEMNAME   ITEMNAME
C                   MOVELUOM        UOM
C                   MOVELPRICE      PRICE
C                   MOVELQTYONHAND  QTYONHAND
C                   UPDATEITEMREC
C                   ENDIF
C                   ENDSR

C*******************************************************
C* $DEL Delete record
C*******************************************************
C     $DEL          BEGSR
C                   CHAINITEMID     ITEMREC
C                   IF %FOUND
C                   DELETEITEMREC
C                   ENDIF
C                   ENDSR
