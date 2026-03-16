H DFTACTGRP(*NO)
     H ACTGRP(*NEW)
     H OPTION(*NODEBUGIO)

*------------------------------------------------------------------
* Files
*------------------------------------------------------------------
     FEMPLFL      UF   E           K DISK

*------------------------------------------------------------------
* Data Queue API
*------------------------------------------------------------------
     D QRCVDTAQ        PR                  EXTPGM('QRCVDTAQ')
     D  DTAQNAME                    10A
     D  DTAQLIB                     10A
     D  DTAQLEN                      5P 0
     D  DTAQDATA                   256A
     D  WAITTIME                    5P 0
     D  KEYLEN                      3P 0
     D  KEYDATA                   256A

*------------------------------------------------------------------
* Work Fields
*------------------------------------------------------------------
     D DTAQDATA        S            256A
     D WAIT            S              5P 0 INZ(-1)

*------------------------------------------------------------------
* Data Structure
*------------------------------------------------------------------
     D EMPDQDS         DS                  256
     D  DQ_EMPID              1      6
     D  DQ_NAME               7     36
     D  DQ_DEPT              37     66
     D  DQ_EMAIL             67     96
     D  DQ_PHONE             97    106
     D  DQ_STATUS           107    107

*------------------------------------------------------------------
* Main Loop (Listener)
*------------------------------------------------------------------
     C                   DOW       '1' = '1'

     C                   CALLP     QRCVDTAQ(
     C                             'EMPDTAQ' :
     C                             'HEXACAB' :
     C                             256 :
     C                             DTAQDATA :
     C                             WAIT :
     C                             0 :
     C                             *BLANKS )

*------------------------------------------------------------------
* Move Data to DS
*------------------------------------------------------------------
     C                   EVAL      EMPDQDS = DTAQDATA

*------------------------------------------------------------------
* Check if Employee exists
*------------------------------------------------------------------
     C                   CHAIN     DQ_EMPID      EMPREC
     C                   IF        %FOUND
     C* Update existing employee
     C                   EVAL      EMPNAME = %TRIM(DQ_NAME)
     C                   EVAL      DEPT    = %TRIM(DQ_DEPT)
     C                   EVAL      EMAIL   = %TRIM(DQ_EMAIL)
     C                   EVAL      PHONE   = DQ_PHONE
     C                   EVAL      STATUS  = DQ_STATUS
     C                   UPDATE    EMPREC
     C                   ELSE
     C* Add new employee
     C                   EVAL      EMPID   = DQ_EMPID
     C                   EVAL      EMPNAME = %TRIM(DQ_NAME)
     C                   EVAL      DEPT    = %TRIM(DQ_DEPT)
     C                   EVAL      EMAIL   = %TRIM(DQ_EMAIL)
     C                   EVAL      PHONE   = DQ_PHONE
     C                   EVAL      STATUS  = DQ_STATUS
     C                   WRITE     EMPREC
     C                   ENDIF

     C                   ENDDO

