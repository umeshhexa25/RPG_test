**FREE
/********************************************************************/
/* Program : MGRHOME                                                */
/* Purpose : Manager - Home Screen                                  */
/********************************************************************/
ctl-opt dftactgrp(*no)
        actgrp(*caller)
        option(*nodebugio);

/*------------------------------------------------------------------*/
/* Files                                                            */
/*------------------------------------------------------------------*/
dcl-f MGRHMDSP  workstn;
dcl-f LOGINLFMGR usage(*input) keyed;

/*------------------------------------------------------------------*/
/* Prototypes for callees                                           */
/*------------------------------------------------------------------*/
dcl-pr VIEWROST extpgm('MGRROSTV'); end-pr;
dcl-pr VIEWCOMP extpgm('MGRCOMPV'); end-pr;
dcl-pr APPRROST extpgm('MGRROSTA'); end-pr;
dcl-pr RPTMENU  extpgm('ADRPTMN'); end-pr;

/*------------------------------------------------------------------*/
/* Entry Parameter                                                  */
/*------------------------------------------------------------------*/
dcl-pi *n;
   pUserId packed(6:0);
end-pi;

/*------------------------------------------------------------------*/
/* Validate Manager Login                                           */
/*------------------------------------------------------------------*/
chain pUserId LOGINLFMGR;

if %notfound(LOGINLFMGR);
   *inlr = *on;
   return;
endif;

/*------------------------------------------------------------------*/
/* Main Menu Loop                                                   */
/*------------------------------------------------------------------*/
dow '1' = '1';

   exfmt MGRHOME;

   if *in03;
      leave;
   endif;

   if DSPOPT = '1';
      VIEWROST();

   elseif DSPOPT = '2';
      VIEWCOMP();

   elseif DSPOPT = '3';
      APPRROST();

   elseif DSPOPT = '4';
      RPTMENU();

   elseif DSPOPT = '5';
      leave;

   else;
      /* Invalid option – redisplay */
      iter;
   endif;

   clear DSPOPT;

enddo;

*inlr = *on;
return;
