     H DFTACTGRP(*NO)
     H ACTGRP(*CALLER)
     H OPTION(*NODEBUGIO)

*------------------------------------------------------------------
* Files
*------------------------------------------------------------------
     FMGREMPUDSP CF   E             WORKSTN

*------------------------------------------------------------------
* Prototype for Callee
*------------------------------------------------------------------
     D EMPUPDC         PR                  EXTPGM('MGREMPUPD')
     D  PEMPID                       6P 0

*------------------------------------------------------------------
* Fields
*------------------------------------------------------------------
     D SELID           S              6P 0

*------------------------------------------------------------------
* Main Logic
*------------------------------------------------------------------
     C                   DOW       *IN12 = *OFF

     C                   EXFMT     EMPUPDW

     C                   IF        *IN12 = *ON
     C                   LEAVE
     C                   ENDIF

     C                   IF        DSP_EMP > 0
     C                   EVAL      SELID = DSP_EMP
     C                   CALLP     EMPUPDC(SELID)
     C                   LEAVE
     C                   ENDIF

     C                   ENDDO

     C                   SETON                                        LR
