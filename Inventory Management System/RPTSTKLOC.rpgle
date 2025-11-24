FSTKLOC    IF   E           K DISK
FREPORTPF  O    F     132    PRINTER OFLIND(*IN99)
 
D HDS1          S             50A
 
/FREE
   *INLR = *OFF;
 
   HDS1 = 'STOCK BY LOCATION REPORT';
   EXCPT HDR1;
 
   READ STKLOC;
 
   DOU %EOF(STKLOC);
 
      FLD1 = %CHAR(ITEMID);
      FLD2 = LOCID;
      FLD3 = %CHAR(QTY);
      FLD4 = *BLANKS;
 
      EXCPT DTL1;
 
      READ STKLOC;
   ENDDO;
 
   *INLR = *ON;
   RETURN;
/END-FREE
