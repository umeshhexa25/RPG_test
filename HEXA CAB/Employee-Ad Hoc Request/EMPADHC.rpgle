H**********************************************************
H* Program : EMPADHC
H* Purpose : Employee Ad-hoc Cab Request
H**********************************************************
H DFTACTGRP(*NO) ACTGRP(*CALLER)

FEMPADHCDSP CF   E             WORKSTN
FADHOCLF1   UF   E           K DISK

IADHOCLF1   NS
I              REQID        6S 0
I              EMPID        6S 0
I              EMPNAME     30A
I              REQDT        8S 0
I              REQTM        6S 0
I              REASON      50A
I              APPROVAL     1A

C**********************************************************
C* Entry Parameter
C**********************************************************
C           *ENTRY    PLIST
C                     PARM           PEMPID     6 0

C**********************************************************
C* Initialize Screen
C**********************************************************
C                     Z-ADD PEMPID    DSPEMPID
C                     MOVE  'N'       DSPAPPRV

MAINLOOP  TAG
C                     EXFMT ADHENTR

C**********************************************************
C* Exit Keys
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
C* Validate Input
C**********************************************************
C                     IF   DSPREQDT = 0
C                     GOTO MAINLOOP
C                     ENDIF

C                     IF   DSPREASN = *BLANKS
C                     GOTO MAINLOOP
C                     ENDIF

C**********************************************************
C* Generate Request ID (Simple logic)
C**********************************************************
C                     MOVE  PEMPID     REQID

C**********************************************************
C* Write Ad-hoc Request
C**********************************************************
C                     MOVE  PEMPID     EMPID
C                     MOVE  DSPREQDT   REQDT
C                     MOVE  DSPREQTM   REQTM
C                     MOVE  DSPREASN   REASON
C                     MOVE  'N'        APPROVAL

C                     WRITE ADHREC

C                     GOTO MAINLOOP
