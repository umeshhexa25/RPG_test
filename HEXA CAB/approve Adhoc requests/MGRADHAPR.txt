H DFTACTGRP(*NO)
     H ACTGRP(*CALLER)
     H OPTION(*NODEBUGIO)

*------------------------------------------------------------------
* Files
*------------------------------------------------------------------
     FMGRADHDSP CF   E             WORKSTN
     FADHREQLFM UF   E           K DISK

*------------------------------------------------------------------
* Work Fields
*------------------------------------------------------------------
     D RRN             S              5I 0 INZ(0)
     D OPT             S              1A

*------------------------------------------------------------------
* Initial Load
*------------------------------------------------------------------
     C                   EXSR      LOADSFL

*------------------------------------------------------------------
* Main Loop
*------------------------------------------------------------------
     C                   DOW       *IN03 = *OFF
     C                             AND *IN12 = *OFF

     C                   EXFMT     ADHCTL

     C                   IF        *IN03 = *ON
     C                   LEAVE
     C                   ENDIF

     C                   IF        *IN12 = *ON
     C                   LEAVE
     C                   ENDIF

     C                   EXSR      PROCSFL

     C                   ENDDO

     C                   SETON                                        LR
     C                   RETURN

*------------------------------------------------------------------
* Load-All Subfile
*------------------------------------------------------------------
     C     LOADSFL      BEGSR

     C                   EVAL      RRN = 0
     C                   SETLL     *LOVAL        ADHREQLFM

     C                   DOW       '1' = '1'
     C                   READ      ADHREQLFM
     C                   IF        %EOF(ADHREQLFM)
     C                   LEAVE
     C                   ENDIF

     C                   IF        STATUS <> 'P'
     C                   ITER
     C                   ENDIF

     C                   ADD       1             RRN

     C                   EVAL      SFLSEL   = ' '
     C                   EVAL      SFLREQID = REQID
     C                   EVAL      SFLEMPID = EMPID
     C                   EVAL      SFLDATE  = REQDATE
     C                   EVAL      SFLTIME  = REQTIME
     C                   EVAL      SFLPICK  = PICKUP
     C                   EVAL      SFLDROP  = DROPLOC

     C                   WRITE     ADHSFL

     C                   ENDDO

     C                   ENDSR

*------------------------------------------------------------------
* Process Subfile Options
*------------------------------------------------------------------
     C     PROCSFL      BEGSR

     C                   DOW       '1' = '1'
     C                   READC     ADHSFL
     C                   IF        %EOF(MGRADHDSP)
     C                   LEAVE
     C                   ENDIF

     C                   EVAL      OPT = SFLSEL

     C                   IF        OPT = 'A'
     C                   EVAL      STATUS = 'A'
     C                   UPDATE    ADHREC
     C                   ENDIF

     C                   IF        OPT = 'R'
     C                   EVAL      STATUS = 'R'
     C                   UPDATE    ADHREC
     C                   ENDIF

     C                   ENDDO

     C                   ENDSR
