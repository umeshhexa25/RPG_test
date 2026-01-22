H**********************************************************
H* Program : ADMINHM
H* Purpose : Admin Home Screen
H**********************************************************

FADMINHMDSP CF   E             WORKSTN
FLOGINLFADM IF   E           K DISK

C**********************************************************
C* Entry Parameter
C**********************************************************
C           *ENTRY    PLIST
C                     PARM           PUSERID    6 0

C**********************************************************
C* Validate Admin User
C**********************************************************
C                     CHAIN PUSERID   LOGINLFADM  90
C   90                SETON                     LR
C   90                RETURN

MAINLOOP  TAG
C                     EXFMT ADMINHM

C**********************************************************
C* Exit
C**********************************************************
C                     IF   *IN03 = *ON
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C**********************************************************
C* Menu Routing using SELECT / WHEN
C**********************************************************
C                     SELECT
C                     WHEN DSPOPT = '1'
C                     CALL 'EMPMAINT'
C                     WHEN DSPOPT = '2'
C                     CALL 'CABMAINT'
C                     WHEN DSPOPT = '3'
C                     CALL 'DRVMAINT'
C                     WHEN DSPOPT = '4'
C                     CALL 'ROSTMAINT'
C                     WHEN DSPOPT = '5'
C                     CALL 'COMPMGMT'
C                     WHEN DSPOPT = '6'
C                     SETON                     LR
C                     RETURN
C                     OTHER
C                     ENDSL

C                     MOVE *BLANKS   DSPOPT
C                     GOTO MAINLOOP

