H**********************************************************
H* Program : ADMCABMT
H* Purpose : Admin - Manage Cab Profile
H**********************************************************
H DFTACTGRP(*NO)
H ACTGRP(*CALLER)

FADMCABDSP CF   E             WORKSTN
FCABLFADM  IF   E           K DISK

C**********************************************************
C* Work fields
C**********************************************************
C                     DEFN          RRN           5 0

C**********************************************************
C* Main processing
C**********************************************************
C                     Z-ADD 0        RRN

C                     EXSR LOADSFL

MAINLOOP  TAG
C                     EXFMT CABCTL

C**********************************************************
C* Exit handling
C**********************************************************
C                     IF   *IN03 = *ON
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C                     IF   *IN12 = *ON
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C                     GOTO MAINLOOP

C**********************************************************
C* Load All Subfile
C**********************************************************
C LOADSFL   BEGSR
C                     Z-ADD 0        RRN
C                     SETLL *LOVAL   CABLFADM

C LOADLP    DOW   *IN99 = *OFF
C                     READ  CABLFADM                99
C                     IF   *IN99 = *ON
C                     LEAVE
C                     ENDIF

C**********************************************************
C* Map fields
C**********************************************************
C                     ADD   1        RRN
C                     MOVE  CABID    SFLCABID
C                     MOVE  CABNO    SFLCABNO
C                     MOVE  CABTYPE  SFLTYPE
C                     MOVE  CAPACITY SFLCAP
C                     MOVE  STATUS   SFLSTAT

C                     WRITE CABSFL

C                     ENDDO
C                     ENDSR

