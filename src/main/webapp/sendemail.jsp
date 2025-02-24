<%-- 
    Document   : sendemail
    Created on : Feb 23, 2025, 5:04:45 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

<head>
 <meta charset="UTF-8" />
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <!--[if !mso]><!-- -->
 <meta http-equiv="X-UA-Compatible" content="IE=edge" />
 <!--<![endif]-->
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta name="format-detection" content="telephone=no, date=no, address=no, email=no" />
 <meta name="x-apple-disable-message-reformatting" />
 <link href="https://fonts.googleapis.com/css?family=Bangers:ital,wght@0,400;0,400" rel="stylesheet" />
 <link href="https://fonts.googleapis.com/css?family=Onest:ital,wght@" rel="stylesheet" />
 <title>LeBazar</title>
 <!-- Made with Postcards Email Builder by Designmodo -->
 <style>
 html, body { margin: 0 !important; padding: 0 !important; min-height: 100% !important; width: 100% !important; -webkit-font-smoothing: antialiased; }
         * { -ms-text-size-adjust: 100%; }
         #outlook a { padding: 0; }
         .ReadMsgBody, .ExternalClass { width: 100%; }
         .ExternalClass, .ExternalClass p, .ExternalClass td, .ExternalClass div, .ExternalClass span, .ExternalClass font { line-height: 100%; }
         table, td, th { mso-table-lspace: 0 !important; mso-table-rspace: 0 !important; border-collapse: collapse; }
         u + .body table, u + .body td, u + .body th { will-change: transform; }
         body, td, th, p, div, li, a, span { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; mso-line-height-rule: exactly; }
         img { border: 0; outline: 0; line-height: 100%; text-decoration: none; -ms-interpolation-mode: bicubic; }
         a[x-apple-data-detectors] { color: inherit !important; text-decoration: none !important; }
         .body .pc-project-body { background-color: transparent !important; }
                 
 
         @media (min-width: 621px) {
             .pc-lg-hide {  display: none; } 
             .pc-lg-bg-img-hide { background-image: none !important; }
         }
 </style>
 <style>
 @media (max-width: 620px) {
 .pc-project-body {min-width: 0px !important;}
 .pc-project-container {width: 100% !important;}
 .pc-sm-hide, .pc-w620-gridCollapsed-1 > tbody > tr > .pc-sm-hide {display: none !important;}
 .pc-sm-bg-img-hide {background-image: none !important;}
 .pc-w620-padding-0-0-0-0 {padding: 0px 0px 0px 0px !important;}
 .pc-w620-padding-20-0-0-0 {padding: 20px 0px 0px 0px !important;}
 .pc-w620-itemsSpacings-0-30 {padding-left: 0px !important;padding-right: 0px !important;padding-top: 15px !important;padding-bottom: 15px !important;}
 table.pc-w620-spacing-0-0-40-0 {margin: 0px 0px 40px 0px !important;}
 td.pc-w620-spacing-0-0-40-0,th.pc-w620-spacing-0-0-40-0{margin: 0 !important;padding: 0px 0px 40px 0px !important;}
 .pc-w620-width-70 {width: 70px !important;}
 .pc-w620-height-auto {height: auto !important;}
 .pc-w620-font-size-62px {font-size: 62px !important;}
 .pc-w620-line-height-90pc {line-height: 90% !important;}
 table.pc-w620-spacing-0-0-0-0 {margin: 0px 0px 0px 0px !important;}
 td.pc-w620-spacing-0-0-0-0,th.pc-w620-spacing-0-0-0-0{margin: 0 !important;padding: 0px 0px 0px 0px !important;}
 .pc-w620-padding-20-12-20-12 {padding: 20px 12px 20px 12px !important;}
 .pc-w620-font-size-14px {font-size: 14px !important;}
 .pc-w620-line-height-140pc {line-height: 140% !important;}
 .pc-w620-padding-12-12-12-16 {padding: 12px 12px 12px 16px !important;}
 .pc-w620-width-fill {width: 100% !important;}
 .pc-w620-font-size-20px {font-size: 20px !important;}
 .pc-w620-padding-12-12-12-12 {padding: 12px 12px 12px 12px !important;}
 .pc-w620-padding-20-20-20-20 {padding: 20px 20px 20px 20px !important;}
 .pc-w620-itemsSpacings-0-0 {padding-left: 0px !important;padding-right: 0px !important;padding-top: 0px !important;padding-bottom: 0px !important;}
 .pc-w620-padding-0-0-10-0 {padding: 0px 0px 10px 0px !important;}
 .pc-w620-width-0px {width: 0px !important;}
 table.pc-w620-spacing-5-0-0-0 {margin: 5px 0px 0px 0px !important;}
 td.pc-w620-spacing-5-0-0-0,th.pc-w620-spacing-5-0-0-0{margin: 0 !important;padding: 5px 0px 0px 0px !important;}
 .pc-w620-text-align-left {text-align: left !important;text-align-last: left !important;}
 .pc-w620-font-size-12px {font-size: 12px !important;}
 .pc-w620-letter-spacing-0p9px {letter-spacing: 0.9px !important;}
 .pc-w620-itemsSpacings-0-20 {padding-left: 0px !important;padding-right: 0px !important;padding-top: 10px !important;padding-bottom: 10px !important;}
 table.pc-w620-spacing-20-0-0-0 {margin: 20px 0px 0px 0px !important;}
 td.pc-w620-spacing-20-0-0-0,th.pc-w620-spacing-20-0-0-0{margin: 0 !important;padding: 20px 0px 0px 0px !important;}
 .pc-w620-valign-middle {vertical-align: middle !important;}
 td.pc-w620-halign-center,th.pc-w620-halign-center {text-align: center !important;}
 table.pc-w620-halign-center {float: none !important;margin-right: auto !important;margin-left: auto !important;}
 img.pc-w620-halign-center {margin-right: auto !important;margin-left: auto !important;}
 div.pc-w620-align-center,th.pc-w620-align-center,a.pc-w620-align-center,td.pc-w620-align-center {text-align: center !important;text-align-last: center !important;}
 table.pc-w620-align-center {float: none !important;margin-right: auto !important;margin-left: auto !important;}
 img.pc-w620-align-center {margin-right: auto !important;margin-left: auto !important;}
 .pc-w620-text-align-center {text-align: center !important;text-align-last: center !important;}
 .pc-w620-font-size-36px {font-size: 36px !important;}
 .pc-w620-line-height-120pc {line-height: 120% !important;}
 table.pc-w620-spacing-0-20-0-20 {margin: 0px 20px 0px 20px !important;}
 td.pc-w620-spacing-0-20-0-20,th.pc-w620-spacing-0-20-0-20{margin: 0 !important;padding: 0px 20px 0px 20px !important;}
 table.pc-w620-spacing-0-0-20-0 {margin: 0px 0px 20px 0px !important;}
 td.pc-w620-spacing-0-0-20-0,th.pc-w620-spacing-0-0-20-0{margin: 0 !important;padding: 0px 0px 20px 0px !important;}
 .pc-w620-width-150 {width: 150px !important;}
 .pc-w620-itemsSpacings-20-0 {padding-left: 10px !important;padding-right: 10px !important;padding-top: 0px !important;padding-bottom: 0px !important;}
 .pc-w620-width-20 {width: 20px !important;}
 
 .pc-w620-gridCollapsed-1 > tbody,.pc-w620-gridCollapsed-1 > tbody > tr,.pc-w620-gridCollapsed-1 > tr {display: inline-block !important;}
 .pc-w620-gridCollapsed-1.pc-width-fill > tbody,.pc-w620-gridCollapsed-1.pc-width-fill > tbody > tr,.pc-w620-gridCollapsed-1.pc-width-fill > tr {width: 100% !important;}
 .pc-w620-gridCollapsed-1.pc-w620-width-fill > tbody,.pc-w620-gridCollapsed-1.pc-w620-width-fill > tbody > tr,.pc-w620-gridCollapsed-1.pc-w620-width-fill > tr {width: 100% !important;}
 .pc-w620-gridCollapsed-1 > tbody > tr > td,.pc-w620-gridCollapsed-1 > tr > td {display: block !important;width: auto !important;padding-left: 0 !important;padding-right: 0 !important;margin-left: 0 !important;}
 .pc-w620-gridCollapsed-1.pc-width-fill > tbody > tr > td,.pc-w620-gridCollapsed-1.pc-width-fill > tr > td {width: 100% !important;}
 .pc-w620-gridCollapsed-1.pc-w620-width-fill > tbody > tr > td,.pc-w620-gridCollapsed-1.pc-w620-width-fill > tr > td {width: 100% !important;}
 .pc-w620-gridCollapsed-1 > tbody > .pc-grid-tr-first > .pc-grid-td-first,.pc-w620-gridCollapsed-1 > .pc-grid-tr-first > .pc-grid-td-first {padding-top: 0 !important;}
 .pc-w620-gridCollapsed-1 > tbody > .pc-grid-tr-last > .pc-grid-td-last,.pc-w620-gridCollapsed-1 > .pc-grid-tr-last > .pc-grid-td-last {padding-bottom: 0 !important;}
 
 .pc-w620-gridCollapsed-0 > tbody > .pc-grid-tr-first > td,.pc-w620-gridCollapsed-0 > .pc-grid-tr-first > td {padding-top: 0 !important;}
 .pc-w620-gridCollapsed-0 > tbody > .pc-grid-tr-last > td,.pc-w620-gridCollapsed-0 > .pc-grid-tr-last > td {padding-bottom: 0 !important;}
 .pc-w620-gridCollapsed-0 > tbody > tr > .pc-grid-td-first,.pc-w620-gridCollapsed-0 > tr > .pc-grid-td-first {padding-left: 0 !important;}
 .pc-w620-gridCollapsed-0 > tbody > tr > .pc-grid-td-last,.pc-w620-gridCollapsed-0 > tr > .pc-grid-td-last {padding-right: 0 !important;}
 
 .pc-w620-tableCollapsed-1 > tbody,.pc-w620-tableCollapsed-1 > tbody > tr,.pc-w620-tableCollapsed-1 > tr {display: block !important;}
 .pc-w620-tableCollapsed-1.pc-width-fill > tbody,.pc-w620-tableCollapsed-1.pc-width-fill > tbody > tr,.pc-w620-tableCollapsed-1.pc-width-fill > tr {width: 100% !important;}
 .pc-w620-tableCollapsed-1.pc-w620-width-fill > tbody,.pc-w620-tableCollapsed-1.pc-w620-width-fill > tbody > tr,.pc-w620-tableCollapsed-1.pc-w620-width-fill > tr {width: 100% !important;}
 .pc-w620-tableCollapsed-1 > tbody > tr > td,.pc-w620-tableCollapsed-1 > tr > td {display: block !important;width: auto !important;}
 .pc-w620-tableCollapsed-1.pc-width-fill > tbody > tr > td,.pc-w620-tableCollapsed-1.pc-width-fill > tr > td {width: 100% !important;box-sizing: border-box !important;}
 .pc-w620-tableCollapsed-1.pc-w620-width-fill > tbody > tr > td,.pc-w620-tableCollapsed-1.pc-w620-width-fill > tr > td {width: 100% !important;box-sizing: border-box !important;}
 }
 </style>
 <!--[if !mso]><!-- -->
 <style>
 @font-face { font-family: 'Bangers'; font-style: normal; font-weight: 400; src: url('https://fonts.gstatic.com/s/bangers/v24/FeVQS0BTqb0h60ACH5BQ3g.woff') format('woff'), url('https://fonts.gstatic.com/s/bangers/v24/FeVQS0BTqb0h60ACH5BQ2A.woff2') format('woff2'); }
 </style>
 <!--<![endif]-->
 <!--[if mso]>
    <style type="text/css">
        .pc-font-alt {
            font-family: Arial, Helvetica, sans-serif !important;
        }
    </style>
    <![endif]-->
 <!--[if gte mso 9]>
    <xml>
        <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
        </o:OfficeDocumentSettings>
    </xml>
    <![endif]-->
</head>

<body class="body pc-font-alt" style="width: 100% !important; min-height: 100% !important; margin: 0 !important; padding: 0 !important; line-height: 1.5; font-weight: normal; color: #2D3A41; mso-line-height-rule: exactly; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; font-variant-ligatures: normal; text-rendering: optimizeLegibility; -moz-osx-font-smoothing: grayscale; background-color: #ffe1d8;" bgcolor="#ffe1d8">
 <table class="pc-project-body" style="table-layout: fixed; width: 100%; min-width: 600px; background-color: #ffe1d8;" bgcolor="#ffe1d8" border="0" cellspacing="0" cellpadding="0" role="presentation">
  <tr>
   <td align="center" valign="top">
    <table class="pc-project-container" align="center" style="width: 600px; max-width: 600px;" border="0" cellpadding="0" cellspacing="0" role="presentation">
     <tr>
      <td class="pc-w620-padding-0-0-0-0" style="padding: 20px 0px 20px 0px;" align="left" valign="top">
       <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
        <tr>
         <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
           <tr>
            <td class="pc-w620-spacing-0-0-0-0" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
             <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
              <tr>
               <td valign="top" class="pc-w620-padding-12-12-12-12" style="padding: 12px 12px 12px 12px; height: unset; background-color: #f6f6f6;" bgcolor="#f6f6f6">
                <table class="pc-width-fill pc-w620-gridCollapsed-0" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr class="pc-grid-tr-first pc-grid-tr-last">
                  <td class="pc-grid-td-first pc-grid-td-last" align="center" valign="top" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                   <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr>
                     <td class="pc-w620-padding-20-0-0-0" align="left" valign="middle" style="padding: 10px 0px 0px 0px; background-color: #8c6e63; border-radius: 16px 16px 0px 0px;">
                      <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td align="left" valign="top">
                         <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td class="pc-w620-spacing-0-0-40-0" style="padding: 0px 0px 15px 0px;">
                            <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr class="pc-grid-tr-first pc-grid-tr-last">
                              <td class="pc-grid-td-first pc-grid-td-last pc-w620-itemsSpacings-0-30" align="center" valign="middle" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                               <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td align="center" valign="middle">
                                  <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td align="center" valign="top" style="line-height: 1;">
                                     <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                      <tr>
                                       <td align="center" valign="top">
                                        <a class="pc-font-alt" href="https://postcards.email/" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                                         <img src="https://cloudfilesdm.com/postcards/image-1740375633565.png" class="pc-w620-width-70 pc-w620-height-auto" width="100" height="100" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 100px; height: auto; max-width: 100%; border: 0;" />
                                        </a>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                       <tr>
                        <td align="left" valign="top">
                         <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td valign="top" style="padding: 0px 32px 32px 32px;">
                            <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                             <tr>
                              <td valign="top" align="center">
                               <div class="pc-font-alt" style="text-decoration: none;">
                                <div style="font-size: 59px;line-height: 55.8px;text-align:left;text-align-last:left;color:#ffe1d8;letter-spacing:0px;font-weight:400;font-style:normal;">
                                 <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 140%;" class="pc-w620-font-size-62px pc-w620-line-height-90pc">C</span><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 140%;">ẢM ƠN BẠN ĐÃ ĐẶT HÀNG</span>
                                 </div>
                                </div>
                               </div>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr>
                  <td class="pc-w620-spacing-0-0-0-0">
                   <table class="pc-width-fill pc-w620-gridCollapsed-0" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr class="pc-grid-tr-first pc-grid-tr-last">
                     <td class="pc-grid-td-first pc-grid-td-last" align="center" valign="top" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                      <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td class="pc-w620-padding-20-12-20-12" align="left" valign="middle" style="padding: 32px 32px 32px 32px; background-color: #ffffff; border-radius: 0px 0px 16px 16px;">
                         <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td align="left" valign="top">
                            <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td valign="top" style="padding: 0px 0px 24px 0px;">
                               <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                <tr>
                                 <td valign="top" align="left">
                                  <div class="pc-font-alt" style="text-decoration: none;">
                                   <div style="font-size: 14px;line-height: 19.6px;text-align:center;text-align-last:center;color:#5b5b5b;letter-spacing:0px;font-weight:400;font-style:normal;">
                                    <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 21px; line-height: 140%;" class="pc-w620-font-size-14px pc-w620-line-height-140pc">Xin chào, [tên khách hàng] </span><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 21px; line-height: 140%;">👋</span>
                                     <br><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 21px; line-height: 140%;" class="pc-w620-font-size-14px pc-w620-line-height-140pc">Cảm ơn bạn đã lựa chọn mua hàng tại PawFect! Chúng tôi đã ghi nhận đơn đặt hàng của bạn vào ngày hôm nay [Ngày] và sẽ xử lý trong vòng 2 - 3 ngày làm việc.</span>
                                    </div>
                                   </div>
                                  </div>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                          <tr>
                           <td align="left" valign="top">
                            <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr class="pc-grid-tr-first pc-grid-tr-last">
                              <td class="pc-grid-td-first pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="middle" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                               <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td class="pc-w620-padding-12-12-12-16" align="left" valign="middle" style="padding: 12px 12px 12px 30px; background-color: #f6f6f6; border-radius: 100px 100px 100px 100px;">
                                  <table class="pc-w620-width-fill" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td>
                                     <table class="pc-width-fill pc-w620-gridCollapsed-0 pc-w620-width-fill" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                      <tr class="pc-grid-tr-first pc-grid-tr-last">
                                       <td class="pc-grid-td-first pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="middle" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                                        <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                         <tr>
                                          <td align="left" valign="middle">
                                           <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="left">
                                            <tr>
                                             <td valign="top" align="left">
                                              <div class="pc-font-alt" style="text-decoration: none;">
                                               <div style="font-size: 20px;line-height: 42px;text-align:left;text-align-last:left;color:#979da6;letter-spacing:0px;font-weight:400;font-style:normal;">
                                                <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 30px; line-height: 140%;" class="pc-w620-font-size-20px">mã đơn #:</span><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; color: rgb(40, 60, 92); font-size: 30px; line-height: 140%;" class="pc-w620-font-size-20px"> </span><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; color: rgb(34, 76, 145); font-size: 30px; line-height: 140%;" class="pc-w620-font-size-20px">4783220</span>
                                                </div>
                                               </div>
                                              </div>
                                             </td>
                                            </tr>
                                           </table>
                                          </td>
                                         </tr>
                                        </table>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
               </td>
              </tr>
             </table>
            </td>
           </tr>
          </table>
         </td>
        </tr>
        <tr>
         <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
           <tr>
            <td class="pc-w620-spacing-0-0-0-0" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
             <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
              <tr>
               <td valign="top" class="pc-w620-padding-12-12-12-12" style="padding: 12px 12px 12px 12px; height: unset; background-color: #f6f6f6;" bgcolor="#f6f6f6">
                <table class="pc-w620-width-fill" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr>
                  <td>
                   <table class="pc-width-fill pc-w620-gridCollapsed-1 pc-w620-width-fill" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr class="pc-grid-tr-first pc-grid-tr-last">
                     <td class="pc-grid-td-first pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                      <table class="pc-w620-width-fill" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td class="pc-w620-padding-20-20-20-20" align="left" valign="middle" style="padding: 32px 32px 32px 32px; background-color: #ffffff; border-radius: 16px 16px 16px 16px;">
                         <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td align="left" valign="top">
                            <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td valign="top" style="padding: 0px 0px 32px 0px;">
                               <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                <tr>
                                 <td valign="top" align="center">
                                  <div class="pc-font-alt" style="text-decoration: none;">
                                   <div style="font-size: 30px;line-height: 30px;text-align:left;text-align-last:left;color:#d66c08;letter-spacing:0px;font-weight:400;font-style:normal;">
                                    <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 100%;">ĐƠN HÀNG CỦA BẠN</span>
                                    </div>
                                   </div>
                                  </div>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                          <tr>
                           <td align="left" valign="top">
                            <table class="pc-w620-width-fill" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td style="padding: 0px 0px 20px 0px;">
                               <table class="pc-width-fill pc-w620-gridCollapsed-1 pc-w620-width-fill" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr class="pc-grid-tr-first pc-grid-tr-last">
                                 <td class="pc-grid-td-first pc-w620-itemsSpacings-0-0" align="left" valign="top" style="padding-top: 0px; padding-right: 5px; padding-bottom: 0px; padding-left: 0px;">
                                  <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td class="pc-w620-padding-0-0-10-0" align="left" valign="top">
                                     <a class="pc-font-alt" href="https://postcards.email/" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                                      <img src="https://cloudfilesdm.com/postcards/image-17403124281415.png" width="80" height="65" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 80px; height: auto; max-width: 100%; border: 0;" />
                                     </a>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                 <td class="pc-w620-itemsSpacings-0-0" align="left" valign="top" style="padding-top: 0px; padding-right: 5px; padding-bottom: 0px; padding-left: 5px;">
                                  <table class="pc-w620-width-fill" style="width: 300px; height: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td align="left" valign="top">
                                     <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                      <tr>
                                       <td align="left" valign="top">
                                        <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                         <tr>
                                          <td class="pc-w620-spacing-0-0-0-0" valign="top" style="padding: 0px 0px 4px 0px;">
                                           <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                            <tr>
                                             <td valign="top" align="left">
                                              <div class="pc-font-alt" style="text-decoration: none;">
                                               <div style="font-size: 14px;line-height: 24px;text-align:left;text-align-last:left;color:#141414;letter-spacing:0px;font-weight:400;font-style:normal;">
                                                <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 20px; line-height: 120%;" class="pc-w620-font-size-14px">SUPER AMP HUB (XR)</span>
                                                </div>
                                               </div>
                                              </div>
                                             </td>
                                            </tr>
                                           </table>
                                          </td>
                                         </tr>
                                        </table>
                                       </td>
                                      </tr>
                                      <tr>
                                       <td align="left" valign="top">
                                        <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                         <tr>
                                          <td class="pc-w620-spacing-5-0-0-0" valign="top" style="padding: 3px 0px 10px 0px;">
                                           <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                            <tr>
                                             <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                              <div class="pc-font-alt" style="text-decoration: none;">
                                               <div style="font-size: 16px;line-height: 10px;text-align:left;text-align-last:left;color:#979da6;letter-spacing:0.9px;font-weight:400;font-style:normal;">
                                                <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;">Giá: 40.000đ</span>
                                                </div>
                                               </div>
                                              </div>
                                             </td>
                                            </tr>
                                           </table>
                                          </td>
                                         </tr>
                                        </table>
                                       </td>
                                      </tr>
                                      <tr>
                                       <td align="left" valign="top">
                                        <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                         <tr>
                                          <td class="pc-w620-spacing-5-0-0-0" valign="top" style="padding: 3px 0px 0px 0px;">
                                           <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                            <tr>
                                             <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                              <div class="pc-font-alt" style="text-decoration: none;">
                                               <div style="font-size: 16px;line-height: 10px;text-align:left;text-align-last:left;color:#979da6;letter-spacing:0.9px;font-weight:400;font-style:normal;">
                                                <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;">SỐ LƯỢNG: 1</span>
                                                </div>
                                               </div>
                                              </div>
                                             </td>
                                            </tr>
                                           </table>
                                          </td>
                                         </tr>
                                        </table>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                 <td class="pc-grid-td-last pc-w620-itemsSpacings-0-0" align="left" valign="top" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 5px;">
                                  <table style="width: 20px;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td class="pc-w620-padding-0-0-0-0" align="right" valign="top">
                                     <table align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                      <tr>
                                       <td align="right" valign="top">
                                        <table align="right" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                         <tr>
                                          <td class="pc-w620-spacing-5-0-0-0" valign="top">
                                           <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                            <tr>
                                             <td valign="top" align="left">
                                              <div class="pc-font-alt" style="text-decoration: none;">
                                               <div style="font-size: 14px;line-height: 25.2px;text-align:right;text-align-last:right;color:#333333;letter-spacing:0px;font-weight:400;font-style:normal;">
                                                <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 18px; line-height: 140%;" class="pc-w620-font-size-14px">120.000đ</span>
                                                </div>
                                               </div>
                                              </div>
                                             </td>
                                            </tr>
                                           </table>
                                          </td>
                                         </tr>
                                        </table>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                          <tr>
                           <td align="left" valign="top">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td valign="top" style="padding: 0px 0px 32px 0px;">
                               <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="margin-right: auto;">
                                <tr>
                                 <td valign="top" style="line-height: 1px; font-size: 1px; border-bottom: 1px solid #dfdfdf;">&nbsp;</td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                          <tr>
                           <td align="left" valign="top">
                            <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr class="pc-grid-tr-first pc-grid-tr-last">
                              <td class="pc-grid-td-first pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 25%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                               <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td align="left" valign="middle">
                                  <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="left">
                                   <tr>
                                    <td valign="top" align="left">
                                     <div class="pc-font-alt" style="text-decoration: none;">
                                      <div style="font-size: 12px;line-height: 10px;text-align:left;text-align-last:left;color:#979da6;letter-spacing:0.9px;font-weight:400;font-style:normal;">
                                       <div class="pc-w620-text-align-left"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 18px;text-transform: uppercase;" class="pc-w620-font-size-12px pc-w620-letter-spacing-0p9px">TẠM TÍNH</span>
                                       </div>
                                      </div>
                                     </div>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                              <td class="pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 25%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                               <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td align="right" valign="middle">
                                  <table align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td align="right" valign="top">
                                     <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="right">
                                      <tr>
                                       <td valign="top" align="right">
                                        <div class="pc-font-alt" style="text-decoration: none;">
                                         <div style="font-size: 20px;line-height: 24px;text-align:left;text-align-last:left;color:#141414;letter-spacing:0px;font-weight:400;font-style:normal;">
                                          <div class="pc-w620-text-align-left"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 120%;">350.000đ</span>
                                          </div>
                                         </div>
                                        </div>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                          <tr>
                           <td align="left" valign="top">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td style="padding: 5px 0px 5px 0px;">
                               <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr class="pc-grid-tr-first pc-grid-tr-last">
                                 <td class="pc-grid-td-first pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 25%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                                  <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td align="left" valign="middle">
                                     <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="left">
                                      <tr>
                                       <td valign="top" align="left">
                                        <div class="pc-font-alt" style="text-decoration: none;">
                                         <div style="font-size: 12px;line-height: 10px;text-align:left;text-align-last:left;color:#979da6;letter-spacing:0.9px;font-weight:400;font-style:normal;">
                                          <div class="pc-w620-text-align-left"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 18px;text-transform: uppercase;" class="pc-w620-font-size-12px pc-w620-letter-spacing-0p9px">[pHƯƠNG THỨC GIAO HÀNG]</span>
                                          </div>
                                         </div>
                                        </div>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                 <td class="pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 25%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                                  <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td align="right" valign="middle">
                                     <table align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                      <tr>
                                       <td align="right" valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="right">
                                         <tr>
                                          <td valign="top" align="right">
                                           <div class="pc-font-alt" style="text-decoration: none;">
                                            <div style="font-size: 20px;line-height: 24px;text-align:left;text-align-last:left;color:#141414;letter-spacing:0px;font-weight:400;font-style:normal;">
                                             <div class="pc-w620-text-align-left"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 120%;" class="pc-w620-font-size-20px">30.000đ</span>
                                             </div>
                                            </div>
                                           </div>
                                          </td>
                                         </tr>
                                        </table>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                          <tr>
                           <td align="left" valign="top">
                            <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr class="pc-grid-tr-first pc-grid-tr-last">
                              <td class="pc-grid-td-first pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 25%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                               <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td align="left" valign="middle">
                                  <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="left">
                                   <tr>
                                    <td valign="top" align="left">
                                     <div class="pc-font-alt" style="text-decoration: none;">
                                      <div style="font-size: 12px;line-height: 10px;text-align:left;text-align-last:left;color:#979da6;letter-spacing:0.9px;font-weight:400;font-style:normal;">
                                       <div class="pc-w620-text-align-left"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 18px;text-transform: uppercase;" class="pc-w620-font-size-12px pc-w620-letter-spacing-0p9px">TỔNG CỘNG</span>
                                       </div>
                                      </div>
                                     </div>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                              <td class="pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 25%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                               <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td align="right" valign="middle">
                                  <table align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td align="right" valign="top">
                                     <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="right">
                                      <tr>
                                       <td valign="top" align="right">
                                        <div class="pc-font-alt" style="text-decoration: none;">
                                         <div style="font-size: 20px;line-height: 24px;text-align:left;text-align-last:left;color:#c12d2d;letter-spacing:0px;font-weight:400;font-style:normal;">
                                          <div class="pc-w620-text-align-left"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 120%;" class="pc-w620-font-size-20px">370.000đ</span>
                                          </div>
                                         </div>
                                        </div>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
               </td>
              </tr>
             </table>
            </td>
           </tr>
          </table>
         </td>
        </tr>
        <tr>
         <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
           <tr>
            <td class="pc-w620-spacing-0-0-0-0" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
             <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
              <tr>
               <td valign="top" class="pc-w620-padding-12-12-12-12" style="padding: 12px 12px 12px 12px; height: unset; background-color: #f6f6f6;" bgcolor="#f6f6f6">
                <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr class="pc-grid-tr-first pc-grid-tr-last">
                  <td class="pc-grid-td-first pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                   <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr>
                     <td align="left" valign="top" style="background-color: #ffe7d6; border-radius: 16px 16px 16px 16px;">
                      <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td class="pc-w620-spacing-20-0-0-0 pc-w620-valign-middle pc-w620-halign-center" style="padding: 10px 32px 0px 0px;">
                         <table class="pc-width-fill pc-w620-gridCollapsed-1 pc-w620-halign-center" style="direction: rtl;" width="100%" dir="rtl" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr class="pc-grid-tr-first pc-grid-tr-last">
                           <td class="pc-grid-td-first pc-w620-itemsSpacings-0-20" align="left" valign="middle" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; direction: ltr;" dir="ltr">
                            <table class="pc-w620-halign-center" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td class="pc-w620-halign-center pc-w620-valign-middle" align="left" valign="middle">
                               <table class="pc-w620-halign-center" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td class="pc-w620-halign-center" align="left" valign="top">
                                  <table class="pc-w620-halign-center" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td valign="top" style="padding: 0px 0px 12px 0px;">
                                     <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                      <tr>
                                       <td valign="top" align="left">
                                        <div class="pc-font-alt" style="text-decoration: none;">
                                         <div style="font-size: 36px;line-height: 40px;text-align:left;text-align-last:left;color:#333333;letter-spacing:0px;font-weight:400;font-style:normal;">
                                          <div class="pc-w620-text-align-center"><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; font-size: 40px; line-height: 100%;" class="pc-w620-font-size-36px pc-w620-line-height-120pc">BẠN CÓ CÂU HỎI?</span>
                                          </div>
                                         </div>
                                        </div>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                                <tr>
                                 <td class="pc-w620-halign-center" align="left" valign="top">
                                  <table class="pc-w620-halign-center" width="100%" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td class="pc-w620-spacing-0-20-0-20" valign="top">
                                     <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%" align="1">
                                      <tr>
                                       <td valign="top" align="left">
                                        <div class="pc-font-alt" style="text-decoration: none;">
                                         <div style="font-size: 18px;line-height: 25.2px;text-align:left;text-align-last:left;color:#3a88ad;font-style:normal;font-weight:400;letter-spacing:0px;">
                                          <div><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif;line-height: 140%;">Nếu bạn cần bất kỳ sự trợ giúp hoặc có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi tại</span><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; color: rgb(20, 20, 20);line-height: 140%;"> </span><span style="font-family: 'Bangers', Arial, Helvetica, sans-serif; color: rgb(209, 79, 45);line-height: 140%;">info@lebazar.com.</span>
                                          </div>
                                         </div>
                                        </div>
                                       </td>
                                      </tr>
                                     </table>
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                           <td class="pc-grid-td-last pc-w620-itemsSpacings-0-20" align="left" valign="middle" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; direction: ltr;" dir="ltr">
                            <table class="pc-w620-halign-center" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td class="pc-w620-halign-center pc-w620-valign-middle" align="left" valign="middle">
                               <table class="pc-w620-halign-center" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tr>
                                 <td class="pc-w620-halign-center" align="left" valign="top" style="line-height: 1;">
                                  <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                   <tr>
                                    <td class="pc-w620-halign-center" align="left" valign="top">
                                     <img src="https://cloudfilesdm.com/postcards/image-174031243010711.png" class="pc-w620-align-center" width="272" height="auto" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 100%; height: auto; border: 0;" />
                                    </td>
                                   </tr>
                                  </table>
                                 </td>
                                </tr>
                               </table>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
               </td>
              </tr>
             </table>
            </td>
           </tr>
          </table>
         </td>
        </tr>
        <tr>
         <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
           <tr>
            <td class="pc-w620-spacing-0-0-0-0" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
             <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
              <tr>
               <td valign="top" class="pc-w620-padding-20-20-20-20" style="padding: 8px 48px 28px 48px; height: unset; background-color: #f6f6f6;" bgcolor="#f6f6f6">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr>
                  <td class="pc-w620-spacing-0-0-20-0 pc-w620-align-center" style="padding: 0px 0px 10px 0px;">
                   <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr class="pc-grid-tr-first pc-grid-tr-last">
                     <td class="pc-grid-td-first pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                      <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td align="center" valign="middle">
                         <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td align="center" valign="top" style="line-height: 1;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                             <tr>
                              <td align="center" valign="top">
                               <a class="pc-font-alt" href="https://postcards.email/" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                                <img src="https://cloudfilesdm.com/postcards/image-1740375629968.png" class="pc-w620-width-150 pc-w620-height-auto" width="150" height="150" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 150px; height: auto; max-width: 100%; border: 0;" />
                               </a>
                              </td>
                             </tr>
                            </table>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr>
                  <td class="pc-w620-spacing-0-0-20-0" valign="top" style="padding: 0px 0px 20px 0px;">
                   <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr>
                     <td valign="top" style="line-height: 1px; font-size: 1px; border-bottom: 1px solid #e9e9e9;">&nbsp;</td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                 <tr>
                  <td class="pc-w620-spacing-0-0-20-0" align="center">
                   <table class="pc-width-hug pc-w620-gridCollapsed-0" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tr class="pc-grid-tr-first pc-grid-tr-last">
                     <td class="pc-grid-td-first pc-w620-itemsSpacings-20-0" valign="middle" style="padding-top: 0px; padding-right: 15px; padding-bottom: 0px; padding-left: 0px;">
                      <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td align="center" valign="middle">
                         <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td align="center" valign="top" style="line-height: 1;">
                            <a class="pc-font-alt" href="https://postcards.email/" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                             <img src="https://cloudfilesdm.com/postcards/1036a3043daf096fbc30177572798da9.png" class="" width="19" height="19" style="display: block; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 19px; height: 19px;" alt="" />
                            </a>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                     <td class="pc-w620-itemsSpacings-20-0" valign="middle" style="padding-top: 0px; padding-right: 15px; padding-bottom: 0px; padding-left: 15px;">
                      <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td align="center" valign="middle">
                         <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td align="center" valign="top" style="line-height: 1;">
                            <a class="pc-font-alt" href="https://postcards.email/" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                             <img src="https://cloudfilesdm.com/postcards/53563ebb0be9c83c85369d03371dedfe.png" class="pc-w620-width-20 pc-w620-height-auto" width="19" height="19" style="display: block; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 19px; height: 19px;" alt="" />
                            </a>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                     <td class="pc-grid-td-last pc-w620-itemsSpacings-20-0" valign="middle" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 15px;">
                      <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                       <tr>
                        <td align="center" valign="middle">
                         <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                          <tr>
                           <td align="center" valign="top" style="line-height: 1;">
                            <a class="pc-font-alt" href="https://postcards.email/" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                             <img src="https://cloudfilesdm.com/postcards/1c946d26bdca9cd0a91f1694a97c56fa.png" class="pc-w620-width-20 pc-w620-height-auto" width="19" height="19" style="display: block; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 19px; height: 19px;" alt="" />
                            </a>
                           </td>
                          </tr>
                         </table>
                        </td>
                       </tr>
                      </table>
                     </td>
                    </tr>
                   </table>
                  </td>
                 </tr>
                </table>
               </td>
              </tr>
             </table>
            </td>
           </tr>
          </table>
         </td>
        </tr>
        <tr>
         <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
           <tr>
            <td align="center" valign="top" style="padding-top: 20px; padding-bottom: 20px; vertical-align: top;">
             <a href="https://postcards.email/?uid=Mjk0MDA4&type=footer" target="_blank" style="text-decoration: none; overflow: hidden; border-radius: 2px; display: inline-block;">
              <img src="https://cloudfilesdm.com/postcards/promo-footer-dark.jpg" width="198" height="46" alt="Made with (o -) postcards" style="width: 198px; height: auto; margin: 0 auto; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; vertical-align: top;">
             </a>
             <img src="https://api-postcards.designmodo.com/tracking/mail/promo?uid=Mjk0MDA4" width="1" height="1" alt="" style="display:none; width: 1px; height: 1px;">
            </td>
           </tr>
          </table>
         </td>
        </tr>
       </table>
      </td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</body>

</html>



