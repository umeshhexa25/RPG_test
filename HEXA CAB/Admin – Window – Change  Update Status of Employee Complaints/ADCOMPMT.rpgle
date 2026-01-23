H**********************************************************
H* Program : ADCOMPMT
H* Purpose : Admin - Employee Complaints
H**********************************************************
H DFTACTGRP(*NO)
H ACTGRP(*CALLER)

FADCOMPDSP CF   E             WORKSTN
FCOMPLLFADM UF  E           K DISK

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
C                     EXFMT COMPCTL

C**********************************************************
C* Exit Handling
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
C* Process Selected Complaints
C**********************************************************
C                     EXSR PROCSFL

C                     GOTO MAINLOOP

C**********************************************************
C* Load All Subfile
C**********************************************************
LOADSFL   BEGSR
C                     Z-ADD 0        RRN
C                     SETLL *LOVAL   COMPLLFADM

LOADLP    DOW   *IN99 = *OFF
C                     READ  COMPLLFADM            99
C                     IF   *IN99 = *ON
C                     LEAVE
C                     ENDIF

C                     ADD   1        RRN
C                     MOVE  COMPID   SFLCMPID
C                     MOVE  EMPID    SFLEMPID
C                     MOVE  CABID    SFLCABID
C                     MOVE  DESCR    SFLDESC
C                     MOVE  STATUS   SFLSTAT
C                     MOVE  *BLANKS  SFLSEL

C                     WRITE COMPSFL
C                     ENDDO
C                     ENDSR

C**********************************************************
C* Process Subfile Options
C**********************************************************
PROCSFL   BEGSR
C                     READC COMPSFL                90
C                     DOW   *IN90 = *OFF

C                     IF   SFLSEL = '5'
C                     CHAIN SFLCMPID COMPLLFADM     91
C                     IF   *IN91 = *OFF
C                     MOVE  'CLOSED' STATUS
C                     UPDATE COMPREC
C                     ENDIF
C                     ENDIF

C                     READC COMPSFL                90
C                     ENDDO

C                     EXSR LOADSFL
C                     ENDSR

