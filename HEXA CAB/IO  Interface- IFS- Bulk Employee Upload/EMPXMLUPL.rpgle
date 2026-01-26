**FREE
/********************************************************************/
/* Program : EMPXMLUPL                                              */
/* Purpose : Bulk Employee Upload from IFS XML                     */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*new)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* File Declarations                                                */
/*------------------------------------------------------------------*/
dcl-f EMPLFXML usage(*update) keyed;

/*------------------------------------------------------------------*/
/* Data Structures for XML-INTO                                     */
/*------------------------------------------------------------------*/
dcl-ds Employees qualified;
   employee likeds(Employee) dim(1000);
end-ds;

dcl-ds Employee qualified;
   EmpId     packed(6:0);
   Name      char(30);
   Address   char(50);
   Phone     char(10);
   Status    char(1);
end-ds;

/*------------------------------------------------------------------*/
/* Variables                                                        */
/*------------------------------------------------------------------*/
dcl-s xmlFile varchar(200) inz('/hexa/input/employee_upload.xml');
dcl-s i       int(5);
dcl-s count   int(5);

/*------------------------------------------------------------------*/
/* Read XML from IFS                                                */
/*------------------------------------------------------------------*/
xml-into Employees
   %xml(xmlFile : 'doc=file case=any');

/*------------------------------------------------------------------*/
/* Process Each Employee                                            */
/*------------------------------------------------------------------*/
for i = 1 to %elem(Employees.employee);

   if Employees.employee(i).EmpId = 0;
      iterate;
   endif;

   chain Employees.employee(i).EmpId EMPLFXML;

   if %found(EMPLFXML);
      // Duplicate – skip
      iterate;
   endif;

   EMPID   = Employees.employee(i).EmpId;
   EMPNAME = %trim(Employees.employee(i).Name);
   ADDRESS = %trim(Employees.employee(i).Address);
   PHONE   = Employees.employee(i).Phone;
   STATUS  = Employees.employee(i).Status;

   write EMPREC;
   count += 1;

endfor;

/*------------------------------------------------------------------*/
/* End Program                                                      */
/*------------------------------------------------------------------*/
*inlr = *on;
return;
