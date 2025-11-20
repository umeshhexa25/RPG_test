H DEBUG(*YES)
F INVITEMP   UF A E             DISK    KRENAM(INVITEMR:INVITEM)
F INVENTD    CF   E             WORKSTN

D ITMFND          S              1A
 /FREE
     // Main program loop
     DoW  *In03 = *Off;
         // Display entry screen
         ExFmt  INVENTR;

         // Check for F3 (Exit)
         If  *In03 = *On;
             Leave;
         EndIf;

         // Check for F6 (Add/Update)
         If  *In06 = *On;
             // Check if item exists
             Chain  (ITMNUM) INVITEMP;

             // If found, update the record
             If  %Found;
                 Update INVITEMR;
             Else;
                 Write INVITEMR;
             EndIf;

             // Clear fields after a successful operation
             ITMNUM  = *Blanks;
             ITMDSCR = *Blanks;
             ITMQTY  = 0;
             ITMCST  = 0;
             ITMSLPR = 0;
             ITMRORD = 0;
         EndIf;
     EndDo;

     *InLr = *On;
 /END-FREE
