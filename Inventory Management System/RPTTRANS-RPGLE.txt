FTRANSACT  IF   E           K DISK
FTRANSDET  IF   E           K DISK
FREPORTPF  O    F     132    PRINTER OFLIND(*IN99)

D HDS1          S             50A

 /FREE
   *INLR = *OFF;

   HDS1 = 'TRANSACTION REGISTER';
   EXCPT HDR1;

   READ TRANSACT;

   DOU %EOF(TRANSACT);

      // Print header line for transaction
      FLD1 = 'TRN:';
      FLD2 = %CHAR(TRNID);
      FLD3 = TRNTYPE;
      FLD4 = %CHAR(%DATE(TRNDATE));
      EXCPT DTL1;

      // Print each detail
      READE TRNID TRANSDET;

      DOU %EOF(TRANSDET) OR TRNID <> TRNID;

         FLD1 = %CHAR(ITEMID);
         FLD2 = LOCID;
         FLD3 = %CHAR(QTY);
         FLD4 = *BLANKS;
         EXCPT DTL1;

         READE TRNID TRANSDET;
      ENDDO;

      READ TRANSACT;
   ENDDO;

   *INLR = *ON;
   RETURN;
 /END-FREE

