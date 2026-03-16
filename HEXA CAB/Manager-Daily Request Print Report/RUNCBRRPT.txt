/*==============================================================*/
/* Program : RUNCBRRPT                                          */
/* Purpose : Run HEXA CAB Daily Request Report                  */
/* Author  : Production Control                                 */
/*==============================================================*/
PGM

/*--------------------------------------------------------------*/
/* Variable Declaration                                         */
/*--------------------------------------------------------------*/
DCL VAR(&DATE) TYPE(*CHAR) LEN(10)
DCL VAR(&MSG)  TYPE(*CHAR) LEN(50)

/*--------------------------------------------------------------*/
/* Get Current System Date                                      */
/*--------------------------------------------------------------*/
RTVSYSVAL SYSVAL(QDATE) RTNVAR(&DATE)
MONMSG MSGID(CPF0000)

/*--------------------------------------------------------------*/
/* Check if Today is Weekend                                    */
/*--------------------------------------------------------------*/
IF COND(&DATE *EQ 'SATURDAY') THEN(DO)

   SNDPGMMSG MSG('No Cab Requests Processed on Saturday') +
             MSGTYPE(*INFO)

ENDDO

ELSE CMD(DO)

/*--------------------------------------------------------------*/
/* Run Query Manager Query                                      */
/*--------------------------------------------------------------*/
   RUNQMQRY QMQRY(HEXA/DLYCABRQ) +
            OUTPUT(*PRINT)

/*--------------------------------------------------------------*/
/* Monitor Query Errors                                         */
/*--------------------------------------------------------------*/
   MONMSG MSGID(QRY0000 CPF0000) EXEC(DO)

      CHGVAR VAR(&MSG) VALUE('Error occurred while running report')

      SNDPGMMSG MSG(&MSG) +
                MSGTYPE(*ESCAPE)

   ENDDO

ENDDO

/*--------------------------------------------------------------*/
/* Normal Completion Message                                    */
/*--------------------------------------------------------------*/
SNDPGMMSG MSG('HEXA CAB Daily Request Report Generated') +
          MSGTYPE(*COMP)

ENDPGM
