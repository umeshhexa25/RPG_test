H**********************************************************
H* Program : ADMCABADD
H* Purpose : Admin - Add Window Manage Cab Profile
H**********************************************************
H DFTACTGRP(*NO)
H ACTGRP(*CALLER)

FADMCABADSP CF   E             WORKSTN
FCABLFADD   UF   E           K DISK

C**********************************************************
C* Work Fields
C**********************************************************
C                     DEFN          RRN           5 0

C**********************************************************
C* Initial Load
C**********************************************************
C                     Z-ADD 0        RRN
C                     EXSR LOADSFL

MAINLOOP  TAG
C                     EXFMT CABCTL

C**********************************************************
C* Exit
C**********************************************************
C                     IF   *IN03 = *ON
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C**********************************************************
C* Add Cab Window
C**********************************************************
C                     IF   *IN06 = *ON
C                     EXFMT ADDCABW

C                     IF   *IN12 = *OFF
C                     MOVE DSPCABID  CABID
C                     MOVE DSPCABNO  CABNO
C                     MOVE DSPTYPE   CABTYPE
C                     MOVE DSPCAP    CAPACITY
C                     MOVE DSPSTAT   STATUS

C                     WRITE CABREC
C                     EXSR LOADSFL
C                     ENDIF
C                     ENDIF

C                     GOTO MAINLOOP

C**********************************************************
C* Load All Subfile
C**********************************************************
LOADSFL   BEGSR
C                     Z-ADD 0        RRN
C                     SETLL *LOVAL   CABLFADD

LOADLP    DOW   *IN99 = *OFF
C                     READ  CABLFADD               99
C                     IF   *IN99 = *ON
C                     LEAVE
C                     ENDIF

C                     ADD   1        RRN
C                     MOVE  CABID    SFLCABID
C                     MOVE  CABNO    SFLCABNO
C                     MOVE  CABTYPE  SFLTYPE
C                     MOVE  CAPACITY SFLCAP
C                     MOVE  STATUS   SFLSTAT

C                     WRITE CABSFL
C                     ENDDO
C                     ENDSR
 
