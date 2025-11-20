**FREE
// ***************************************************************
// TRANSMNT - TRANSACTION ENTRY PROGRAM
// ***************************************************************
ctl-opt dftactgrp(*no) actgrp(*new) option(*srcstmt:*nodebugio);

dcl-f TRANSMNT workstn;

dcl-ds T;
  ITEMID       char(10);
  TRANS_TYPE   char(1);
  QTY          packed(15:2);
  LOCATION     char(10);
  REFNO        varchar(50);
end-ds;

dow not *in03;
  exfmt TRANREC;

  if *in10;   // Post transaction
    exec sql
      call INVENTORY.SP_POST_TRANSACTION
         (:T.ITEMID, :T.TRANS_TYPE, :T.QTY,
          :T.LOCATION, :T.REFNO, :*username);

    if sqlcode = 0;
      T.ITEMID=''; T.TRANS_TYPE=''; T.QTY=0;
      T.LOCATION=''; T.REFNO='';
    else;
      T.LOCATION=''; T.REFNO='';
      // Error will be seen in joblog; add SNDPGMMSG if needed
    endif;
  endif;

  if *in12;  // Clear
    T.ITEMID=''; T.TRANS_TYPE=''; T.QTY=0;
    T.LOCATION=''; T.REFNO='';
  endif;

enddo;

*inlr = *on;
