H
FLOGINPF UF   E           K DISK
FHEXALOGN CF   E             WORKSTN

IHEXALOGN NS
I              OLDPWD     10A
I              NEWPWD     10A
I              CNFPWD     10A

ILOGINPF  NS
I              USERID     10S 0
I              PASSWORD  10A

C           *ENTRY    PLIST
C                     PARM           PUSERID   10 0

C*------------------------------------------
C* Fetch User Record
C*------------------------------------------
C                     CHAIN PUSERID  LOGINPF  90
C   90                SETON                     LR
C   90                RETURN

PWDLOOP   TAG
C                     EXFMT CHGPWDFMT

C* Cancel
C                     IF   *IN12 = '1'
C                     SETON                     LR
C                     RETURN
C                     ENDIF

C* Validate Old Password
C                     IF   OLDPWD <> PASSWORD
C                     GOTO  PWDLOOP
C                     ENDIF

C* Validate New = Confirm
C                     IF   NEWPWD <> CNFPWD
C                     GOTO  PWDLOOP
C                     ENDIF

C* Update Password
C                     MOVEL NEWPWD   PASSWORD
C                     UPDATE LOGINREC

C                     SETON                     LR
C                     RETURN
