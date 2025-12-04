**FREE
ctl-opt dftactgrp(*NO) actgrp(*NEW) option(*SRCSTMT:*NODEBUGIO);

/* External CSV import file */
dcl-f IMPCSV disk usage(*input)
      organization(*streamfile)
      path('/tmp/ITEMIMPORT.csv')
      lrecl(300)
      open(*read);

/* ITEMS file */
dcl-f ITEMS usage(*update) keyed;

/* Working Variables */
dcl-s Line       varchar(300);
dcl-s ITEMID_C   char(5);
dcl-s NAME_C     char(40);
dcl-s QTY_C      char(10);

dcl-s ITEMID_N   packed(5:0);
dcl-s QTY_N      packed(9:0);

dcl-s Pos1 int(10);
dcl-s Pos2 int(10);

*inlr = *off;

/* Skip header row if present */
read IMPCSV Line;

/* Read each CSV row */
dow not %eof(IMPCSV);

   // First comma
   Pos1 = %scan(',' : Line);

   // Second comma
   Pos2 = %scan(',' : Line : Pos1 + 1);

   // Extract CSV fields
   ITEMID_C = %subst(Line : 1 : Pos1 - 1);
   NAME_C   = %subst(Line : Pos1 + 1 : Pos2 - Pos1 - 1);
   QTY_C    = %subst(Line : Pos2 + 1);

   // Trim spaces
   ITEMID_C = %trim(ITEMID_C);
   NAME_C   = %trim(NAME_C);
   QTY_C    = %trim(QTY_C);

   // Convert data to numeric
   ITEMID_N = %dec(ITEMID_C : 5:0);
   QTY_N    = %dec(QTY_C : 9:0);

   // Lookup in ITEMS table
   chain ITEMID_N ITEMS;

   if %found;
      // Update existing
      ITEMNAME   = NAME_C;
      QTYONHAND  = QTY_N;
      update ITEMS;
   else;
      // Insert new
      ITEMID     = ITEMID_N;
      ITEMNAME   = NAME_C;
      QTYONHAND  = QTY_N;
      write ITEMS;
   endif;

   read IMPCSV Line;
enddo;

close IMPCSV;

dsply 'IMPORT Completed successfully from /tmp/ITEMIMPORT.csv';
*inlr = *on;
Return; 


Compile Command

Compile Command
CRTBNDRPG PGM(INVENTLIB/IMPORTITEM) +
          SRCFILE(INVENTLIB/QRPGLESRC)


 
