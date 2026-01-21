H**********************************************************
H* Program : EMPUPDT
H* Purpose : Employee Update Personal Details
H**********************************************************
H DFTACTGRP(*NO)
H ACTGRP(*CALLER)
H COMMIT(*CHG)

FEMPUPDDSP CF   E             WORKSTN
FEMPLFUPD  UF   E           K DISK

IEMPLFUPD  NS
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
C* Initialize
C**********************************************************
C                     SETON                     *INLR
C                     STRCMT

C**********************************************************
C* Load Employee Data
C**********************************************************
C                     CHAIN PEMPID   EMPLFUPD    90
C   90                ROLBK
C   90                RETURN

C                     Z-ADD EMPID    SFLEMPID
C                     MOVEL ADDRESS  SFLADDR
C                     MOVEL CITY     SFLCITY
C                     Z-ADD MOBNO    SFLMOBNO
C                     MOVEL EMAIL    SFLEMAIL

C                     WRITE UPDSFL

MAINLOOP  TAG
C                     EXFMT UPDCTL

C**********************************************************
C* Exit without save
C**********************************************************
C                     IF   *IN03 = *ON
C                     ROLBK
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C                     IF   *IN12 = *ON
C                     ROLBK
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C**********************************************************
C* Save Changes
C**********************************************************
C                     IF   *IN06 = *ON

C                     MOVE  SFLADDR  ADDRESS
C                     MOVE  SFLCITY  CITY
C                     MOVE  SFLMOBNO MOBNO
C                     MOVE  SFLEMAIL EMAIL

C                     UPDATE EMPREC
C                     COMMIT

C                     SETON                     LR
C                     RETURN
C                     ENDIF

C                     GOTO MAINLOOP
