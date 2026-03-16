**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

/* File Declaration */
dcl-f EMPMAST usage(*input) keyed;

/* Variables */
dcl-s empId packed(6:0) inz(1001);
dcl-s empName char(30);

/* Error Handling Block */

monitor;

   chain empId EMPMAST;

   if %found(EMPMAST);
      empName = EMPNAME;
      dsply ('Employee Found: ' + %trim(empName));
   else;
      dsply 'Employee Not Found';
   endif;

on-error;

   dsply 'An unexpected error occurred while accessing file';

endmon;

*inlr = *on;
return;

