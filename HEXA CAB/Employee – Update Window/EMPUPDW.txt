H**********************************************************
H* Program : EMPUPDW
H* Purpose : Employee Update Window
H**********************************************************
H DFTACTGRP(*NO)
H ACTGRP(*CALLER)

FEMPUPDWDSP CF   E             WORKSTN
FEMPLFWIN   UF   E           K DISK

IEMPLFWIN   NS
I              EMPID        6S 0
I              ADDRESS    100A
I              CITY        20A
I              MOBNO       10P 0
I              EMAIL       40A

C**********************************************************
C* Entry Parameter
C**********************************************************
C           *ENTRY    PLIST
C                     PARM           PEMPID     6 0

C**********************************************************
C* Load Employee Record
C**********************************************************
C                     CHAIN PEMPID   EMPLFWIN   90
C   90                SETON                     LR
C   90                RETURN

C**********************************************************
C* Load Screen Fields
C**********************************************************
C                     Z-ADD EMPID    DSPEMPID
C                     MOVEL ADDRESS  DSPADDR
C                     MOVEL CITY     DSPCITY
C                     Z-ADD MOBNO    DSPMOBNO
C                     MOVEL EMAIL    DSPEMAIL

MAINLOOP  TAG
C                     EXFMT UPDWIN

C**********************************************************
C* Exit / Cancel
C**********************************************************
C                     IF   *IN03 = *ON
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C                     IF   *IN12 = *ON
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C**********************************************************
C* Save Changes
C**********************************************************
C                     IF   *IN06 = *ON

C                     MOVE  DSPADDR  ADDRESS
C                     MOVE  DSPCITY  CITY
C                     MOVE  DSPMOBNO MOBNO
C                     MOVE  DSPEMAIL EMAIL

C                     UPDATE EMPREC

C                     SETON                     LR
C                     RETURN
C                     ENDIF

C                     GOTO MAINLOOP
