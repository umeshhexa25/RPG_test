**FREE
// ***************************************************************
// ITEMMAINT - ITEM MASTER MAINTENANCE
// ***************************************************************
ctl-opt dftactgrp(*no) actgrp(*new) option(*srcstmt:*nodebugio);

dcl-f ITEMMAINT workstn;

// Screen fields mapped to DSPF
dcl-ds S;
  ITEMID        char(10);
  ITEMDESC      varchar(100);
  UOM           char(3);
  QTY_ON_HAND   packed(15:2);
  QTY_ALLOC     packed(15:2);
  REORDER_LEVEL packed(15:2);
  LOCATION      char(10);
  STATUS        char(1);
end-ds;

// Main loop
dow not *in03;
  exfmt MAINREC;

  // PF4 = Find
  if *in04;
    exec sql
      select ITEMDESC, UOM, QTY_ON_HAND, QTY_ALLOC,
             REORDER_LEVEL, LOCATION, STATUS
        into :S.ITEMDESC, :S.UOM, :S.QTY_ON_HAND, :S.QTY_ALLOC,
             :S.REORDER_LEVEL, :S.LOCATION, :S.STATUS
        from INVENTORY.ITEMS
        where ITEMID = :S.ITEMID;

    if sqlcode <> 0;
      S.ITEMDESC = '';
      S.UOM = '';
      S.QTY_ON_HAND = 0;
      S.QTY_ALLOC = 0;
      S.REORDER_LEVEL = 0;
      S.LOCATION = '';
      S.STATUS = 'A';
    endif;
  endif;

  // PF10 = Save
  if *in10;

    exec sql
      update INVENTORY.ITEMS
        set ITEMDESC=:S.ITEMDESC,
            UOM=:S.UOM,
            QTY_ON_HAND=:S.QTY_ON_HAND,
            QTY_ALLOC=:S.QTY_ALLOC,
            REORDER_LEVEL=:S.REORDER_LEVEL,
            LOCATION=:S.LOCATION,
            STATUS=:S.STATUS
       where ITEMID=:S.ITEMID;

    if sqlcode = 100;
      exec sql
        insert into INVENTORY.ITEMS
          (ITEMID,ITEMDESC,UOM,QTY_ON_HAND,QTY_ALLOC,
           REORDER_LEVEL,LOCATION,STATUS)
        values
          (:S.ITEMID,:S.ITEMDESC,:S.UOM,:S.QTY_ON_HAND,:S.QTY_ALLOC,
           :S.REORDER_LEVEL,:S.LOCATION,:S.STATUS);
    endif;
  endif;

  // PF6 = Delete
  if *in06;
    exec sql
      delete from INVENTORY.ITEMS
      where ITEMID=:S.ITEMID;

    S.ITEMID=''; S.ITEMDESC=''; S.UOM='';
    S.QTY_ON_HAND=0; S.QTY_ALLOC=0;
    S.REORDER_LEVEL=0; S.LOCATION=''; S.STATUS='A';
  endif;

  // PF12 = Clear
  if *in12;
    S.ITEMID=''; S.ITEMDESC=''; S.UOM='';
    S.QTY_ON_HAND=0; S.QTY_ALLOC=0;
    S.REORDER_LEVEL=0; S.LOCATION=''; S.STATUS='A';
  endif;

enddo;

*inlr = *on;


