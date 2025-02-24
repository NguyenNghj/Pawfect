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
        <link href="https://fonts.googleapis.com/css?family=Poppins:ital,wght@0,400;0,400;0,500;0,600" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Inter:ital,wght@0,400;0,400" rel="stylesheet" />
        <title>Selymoon</title>
        <!-- Made with Postcards Email Builder by Designmodo -->
        <style>
            html, body {
                margin: 0 !important;
                padding: 0 !important;
                min-height: 100% !important;
                width: 100% !important;
                -webkit-font-smoothing: antialiased;
            }
            * {
                -ms-text-size-adjust: 100%;
            }
            #outlook a {
                padding: 0;
            }
            .ReadMsgBody, .ExternalClass {
                width: 100%;
            }
            .ExternalClass, .ExternalClass p, .ExternalClass td, .ExternalClass div, .ExternalClass span, .ExternalClass font {
                line-height: 100%;
            }
            table, td, th {
                mso-table-lspace: 0 !important;
                mso-table-rspace: 0 !important;
                border-collapse: collapse;
            }
            u + .body table, u + .body td, u + .body th {
                will-change: transform;
            }
            body, td, th, p, div, li, a, span {
                -webkit-text-size-adjust: 100%;
                -ms-text-size-adjust: 100%;
                mso-line-height-rule: exactly;
            }
            img {
                border: 0;
                outline: 0;
                line-height: 100%;
                text-decoration: none;
                -ms-interpolation-mode: bicubic;
            }
            a[x-apple-data-detectors] {
                color: inherit !important;
                text-decoration: none !important;
            }
            .body .pc-project-body {
                background-color: transparent !important;
            }


            @media (min-width: 621px) {
                .pc-lg-hide {
                    display: none;
                }
                .pc-lg-bg-img-hide {
                    background-image: none !important;
                }
            }
        </style>
        <style>
            @media (max-width: 620px) {
                .pc-project-body {
                    min-width: 0px !important;
                }
                .pc-project-container {
                    width: 100% !important;
                }
                .pc-sm-hide, .pc-w620-gridCollapsed-1 > tbody > tr > .pc-sm-hide {
                    display: none !important;
                }
                .pc-sm-bg-img-hide {
                    background-image: none !important;
                }
                .pc-w620-itemsSpacings-0-20 {
                    padding-left: 0px !important;
                    padding-right: 0px !important;
                    padding-top: 10px !important;
                    padding-bottom: 10px !important;
                }
                table.pc-w620-spacing-0-0-24-0 {
                    margin: 0px 0px 24px 0px !important;
                }
                td.pc-w620-spacing-0-0-24-0,th.pc-w620-spacing-0-0-24-0{
                    margin: 0 !important;
                    padding: 0px 0px 24px 0px !important;
                }
                .pc-w620-padding-0-0-0-0 {
                    padding: 0px 0px 0px 0px !important;
                }
                .pc-w620-valign-middle {
                    vertical-align: middle !important;
                }
                td.pc-w620-halign-center,th.pc-w620-halign-center {
                    text-align: center !important;
                }
                table.pc-w620-halign-center {
                    float: none !important;
                    margin-right: auto !important;
                    margin-left: auto !important;
                }
                img.pc-w620-halign-center {
                    margin-right: auto !important;
                    margin-left: auto !important;
                }
                div.pc-w620-align-center,th.pc-w620-align-center,a.pc-w620-align-center,td.pc-w620-align-center {
                    text-align: center !important;
                    text-align-last: center !important;
                }
                table.pc-w620-align-center {
                    float: none !important;
                    margin-right: auto !important;
                    margin-left: auto !important;
                }
                img.pc-w620-align-center {
                    margin-right: auto !important;
                    margin-left: auto !important;
                }
                .pc-w620-width-136 {
                    width: 136px !important;
                }
                .pc-w620-height-auto {
                    height: auto !important;
                }
                .pc-w620-itemsSpacings-24-0 {
                    padding-left: 12px !important;
                    padding-right: 12px !important;
                    padding-top: 0px !important;
                    padding-bottom: 0px !important;
                }

                .pc-w620-width-hug {
                    width: auto !important;
                }
                div.pc-w620-textAlign-center,th.pc-w620-textAlign-center,a.pc-w620-textAlign-center,td.pc-w620-textAlign-center {
                    text-align: center !important;
                    text-align-last: center !important;
                }
                table.pc-w620-textAlign-center {
                    float: none !important;
                    margin-right: auto !important;
                    margin-left: auto !important;
                }
                img.pc-w620-textAlign-center {
                    margin-right: auto !important;
                    margin-left: auto !important;
                }
                .pc-w620-width-100pc {
                    width: 100% !important;
                }
                .pc-w620-padding-40-24-40-24 {
                    padding: 40px 24px 40px 24px !important;
                }
                table.pc-w620-spacing-0-0-0-0 {
                    margin: 0px 0px 0px 0px !important;
                }
                td.pc-w620-spacing-0-0-0-0,th.pc-w620-spacing-0-0-0-0{
                    margin: 0 !important;
                    padding: 0px 0px 0px 0px !important;
                }
                .pc-w620-font-size-32px {
                    font-size: 32px !important;
                }
                .pc-w620-line-height-32px {
                    line-height: 32px !important;
                }
                .pc-w620-font-size-16px {
                    font-size: 16px !important;
                }
                .pc-w620-line-height-24px {
                    line-height: 24px !important;
                }
                .pc-w620-padding-24-0-0-0 {
                    padding: 24px 0px 0px 0px !important;
                }
                .pc-w620-font-size-24px {
                    font-size: 24px !important;
                }
                .pc-w620-line-height-40px {
                    line-height: 40px !important;
                }
                table.pc-w620-spacing-0-0-20-0 {
                    margin: 0px 0px 20px 0px !important;
                }
                td.pc-w620-spacing-0-0-20-0,th.pc-w620-spacing-0-0-20-0{
                    margin: 0 !important;
                    padding: 0px 0px 20px 0px !important;
                }
                .pc-w620-line-height-28px {
                    line-height: 28px !important;
                }
                table.pc-w620-spacing-0-16-20-0 {
                    margin: 0px 16px 20px 0px !important;
                }
                td.pc-w620-spacing-0-16-20-0,th.pc-w620-spacing-0-16-20-0{
                    margin: 0 !important;
                    padding: 0px 16px 20px 0px !important;
                }
                .pc-w620-width-64 {
                    width: 64px !important;
                }

                img.pc-w620-width-64-min {
                    min-width: 64px !important;
                }
                .pc-w620-height-64 {
                    height: 64px !important;
                }
                .pc-w620-view-vertical,.pc-w620-view-vertical > tbody,.pc-w620-view-vertical > tbody > tr,.pc-w620-view-vertical > tbody > tr > th,.pc-w620-view-vertical > tr,.pc-w620-view-vertical > tr > th {
                    display: inline-block;
                    width: 100% !important;
                }
                .pc-w620-fontSize-16 {
                    font-size: 16px !important;
                }
                .pc-w620-lineHeight-26 {
                    line-height: 26px !important;
                }
                .pc-w620-padding-28-32-24-16 {
                    padding: 28px 32px 24px 16px !important;
                }
                .pc-w620-line-height-20px {
                    line-height: 20px !important;
                }
                .pc-w620-padding-18-32-24-16 {
                    padding: 18px 32px 24px 16px !important;
                }
                .pc-w620-line-height-26px {
                    line-height: 26px !important;
                }
                .pc-w620-itemsSpacings-0-30 {
                    padding-left: 0px !important;
                    padding-right: 0px !important;
                    padding-top: 15px !important;
                    padding-bottom: 15px !important;
                }
                table.pc-w620-spacing-0-0-14-0 {
                    margin: 0px 0px 14px 0px !important;
                }
                td.pc-w620-spacing-0-0-14-0,th.pc-w620-spacing-0-0-14-0{
                    margin: 0 !important;
                    padding: 0px 0px 14px 0px !important;
                }
                .pc-w620-width-auto {
                    width: auto !important;
                }
                .pc-w620-text-align-left {
                    text-align: left !important;
                    text-align-last: left !important;
                }
                .pc-w620-padding-32-24-32-24 {
                    padding: 32px 24px 32px 24px !important;
                }
                .pc-w620-fontSize-24px {
                    font-size: 24px !important;
                }
                .pc-w620-lineHeight-40 {
                    line-height: 40px !important;
                }
                .pc-w620-radius-10-10-10-10 {
                    border-radius: 10px 10px 10px 10px !important;
                }
                .pc-w620-itemsSpacings-0-4 {
                    padding-left: 0px !important;
                    padding-right: 0px !important;
                    padding-top: 2px !important;
                    padding-bottom: 2px !important;
                }
                .pc-w620-padding-16-24-16-24 {
                    padding: 16px 24px 16px 24px !important;
                }
                .pc-w620-itemsSpacings-0-16 {
                    padding-left: 0px !important;
                    padding-right: 0px !important;
                    padding-top: 8px !important;
                    padding-bottom: 8px !important;
                }
                td.pc-w620-halign-left,th.pc-w620-halign-left {
                    text-align: left !important;
                }
                table.pc-w620-halign-left {
                    float: none !important;
                    margin-right: auto !important;
                    margin-left: 0 !important;
                }
                img.pc-w620-halign-left {
                    margin-right: auto !important;
                    margin-left: 0 !important;
                }
                div.pc-w620-textAlign-left,th.pc-w620-textAlign-left,a.pc-w620-textAlign-left,td.pc-w620-textAlign-left {
                    text-align: left !important;
                    text-align-last: left !important;
                }
                table.pc-w620-textAlign-left{
                    float: none !important;
                    margin-right: auto !important;
                    margin-left: 0 !important;
                }
                img.pc-w620-textAlign-left{
                    margin-right: auto !important;
                    margin-left: 0 !important;
                }
                td.pc-w620-halign-right,th.pc-w620-halign-right {
                    text-align: right !important;
                }
                table.pc-w620-halign-right {
                    float: none !important;
                    margin-right: 0 !important;
                    margin-left: auto !important;
                }
                img.pc-w620-halign-right {
                    margin-right: 0 !important;
                    margin-left: auto !important;
                }
                .pc-w620-width-fill {
                    width: 100% !important;
                }
                div.pc-w620-align-right,th.pc-w620-align-right,a.pc-w620-align-right,td.pc-w620-align-right {
                    text-align: right !important;
                    text-align-last: right !important;
                }
                table.pc-w620-align-right{
                    float: none !important;
                    margin-left: auto !important;
                    margin-right: 0 !important;
                }
                img.pc-w620-align-right{
                    margin-right: 0 !important;
                    margin-left: auto !important;
                }
                .pc-w620-padding-32-0-4-0 {
                    padding: 32px 0px 4px 0px !important;
                }
                table.pc-w620-spacing-10-0-0-0 {
                    margin: 10px 0px 0px 0px !important;
                }
                td.pc-w620-spacing-10-0-0-0,th.pc-w620-spacing-10-0-0-0{
                    margin: 0 !important;
                    padding: 10px 0px 0px 0px !important;
                }
                .pc-w620-itemsSpacings-6-0 {
                    padding-left: 3px !important;
                    padding-right: 3px !important;
                    padding-top: 0px !important;
                    padding-bottom: 0px !important;
                }
                .pc-w620-padding-12-12-12-12 {
                    padding: 12px 12px 12px 12px !important;
                }
                .pc-w620-padding-24-24-24-24 {
                    padding: 24px 24px 24px 24px !important;
                }
                .pc-w620-itemsSpacings-0-0 {
                    padding-left: 0px !important;
                    padding-right: 0px !important;
                    padding-top: 0px !important;
                    padding-bottom: 0px !important;
                }

                .pc-w620-gridCollapsed-1 > tbody,.pc-w620-gridCollapsed-1 > tbody > tr,.pc-w620-gridCollapsed-1 > tr {
                    display: inline-block !important;
                }
                .pc-w620-gridCollapsed-1.pc-width-fill > tbody,.pc-w620-gridCollapsed-1.pc-width-fill > tbody > tr,.pc-w620-gridCollapsed-1.pc-width-fill > tr {
                    width: 100% !important;
                }
                .pc-w620-gridCollapsed-1.pc-w620-width-fill > tbody,.pc-w620-gridCollapsed-1.pc-w620-width-fill > tbody > tr,.pc-w620-gridCollapsed-1.pc-w620-width-fill > tr {
                    width: 100% !important;
                }
                .pc-w620-gridCollapsed-1 > tbody > tr > td,.pc-w620-gridCollapsed-1 > tr > td {
                    display: block !important;
                    width: auto !important;
                    padding-left: 0 !important;
                    padding-right: 0 !important;
                    margin-left: 0 !important;
                }
                .pc-w620-gridCollapsed-1.pc-width-fill > tbody > tr > td,.pc-w620-gridCollapsed-1.pc-width-fill > tr > td {
                    width: 100% !important;
                }
                .pc-w620-gridCollapsed-1.pc-w620-width-fill > tbody > tr > td,.pc-w620-gridCollapsed-1.pc-w620-width-fill > tr > td {
                    width: 100% !important;
                }
                .pc-w620-gridCollapsed-1 > tbody > .pc-grid-tr-first > .pc-grid-td-first,.pc-w620-gridCollapsed-1 > .pc-grid-tr-first > .pc-grid-td-first {
                    padding-top: 0 !important;
                }
                .pc-w620-gridCollapsed-1 > tbody > .pc-grid-tr-last > .pc-grid-td-last,.pc-w620-gridCollapsed-1 > .pc-grid-tr-last > .pc-grid-td-last {
                    padding-bottom: 0 !important;
                }

                .pc-w620-gridCollapsed-0 > tbody > .pc-grid-tr-first > td,.pc-w620-gridCollapsed-0 > .pc-grid-tr-first > td {
                    padding-top: 0 !important;
                }
                .pc-w620-gridCollapsed-0 > tbody > .pc-grid-tr-last > td,.pc-w620-gridCollapsed-0 > .pc-grid-tr-last > td {
                    padding-bottom: 0 !important;
                }
                .pc-w620-gridCollapsed-0 > tbody > tr > .pc-grid-td-first,.pc-w620-gridCollapsed-0 > tr > .pc-grid-td-first {
                    padding-left: 0 !important;
                }
                .pc-w620-gridCollapsed-0 > tbody > tr > .pc-grid-td-last,.pc-w620-gridCollapsed-0 > tr > .pc-grid-td-last {
                    padding-right: 0 !important;
                }

                .pc-w620-tableCollapsed-1 > tbody,.pc-w620-tableCollapsed-1 > tbody > tr,.pc-w620-tableCollapsed-1 > tr {
                    display: block !important;
                }
                .pc-w620-tableCollapsed-1.pc-width-fill > tbody,.pc-w620-tableCollapsed-1.pc-width-fill > tbody > tr,.pc-w620-tableCollapsed-1.pc-width-fill > tr {
                    width: 100% !important;
                }
                .pc-w620-tableCollapsed-1.pc-w620-width-fill > tbody,.pc-w620-tableCollapsed-1.pc-w620-width-fill > tbody > tr,.pc-w620-tableCollapsed-1.pc-w620-width-fill > tr {
                    width: 100% !important;
                }
                .pc-w620-tableCollapsed-1 > tbody > tr > td,.pc-w620-tableCollapsed-1 > tr > td {
                    display: block !important;
                    width: auto !important;
                }
                .pc-w620-tableCollapsed-1.pc-width-fill > tbody > tr > td,.pc-w620-tableCollapsed-1.pc-width-fill > tr > td {
                    width: 100% !important;
                    box-sizing: border-box !important;
                }
                .pc-w620-tableCollapsed-1.pc-w620-width-fill > tbody > tr > td,.pc-w620-tableCollapsed-1.pc-w620-width-fill > tr > td {
                    width: 100% !important;
                    box-sizing: border-box !important;
                }
            }
        </style>
        <!--[if !mso]><!-- -->
        <style>
            @font-face {
                font-family: 'Poppins';
                font-style: normal;
                font-weight: 500;
                src: url('https://fonts.gstatic.com/s/poppins/v22/pxiByp8kv8JHgFVrLGT9Z1JlEw.woff') format('woff'), url('https://fonts.gstatic.com/s/poppins/v22/pxiByp8kv8JHgFVrLGT9Z1JlFQ.woff2') format('woff2');
            }
            @font-face {
                font-family: 'Poppins';
                font-style: normal;
                font-weight: 400;
                src: url('https://fonts.gstatic.com/s/poppins/v22/pxiEyp8kv8JHgFVrJJnedA.woff') format('woff'), url('https://fonts.gstatic.com/s/poppins/v22/pxiEyp8kv8JHgFVrJJnecg.woff2') format('woff2');
            }
            @font-face {
                font-family: 'Poppins';
                font-style: normal;
                font-weight: 600;
                src: url('https://fonts.gstatic.com/s/poppins/v22/pxiByp8kv8JHgFVrLEj6Z1JlEw.woff') format('woff'), url('https://fonts.gstatic.com/s/poppins/v22/pxiByp8kv8JHgFVrLEj6Z1JlFQ.woff2') format('woff2');
            }
            @font-face {
                font-family: 'Inter';
                font-style: normal;
                font-weight: 400;
                src: url('https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZFhjg.woff') format('woff'), url('https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZFhiA.woff2') format('woff2');
            }
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

    <body class="body pc-font-alt" style="width: 100% !important; min-height: 100% !important; margin: 0 !important; padding: 0 !important; line-height: 1.5; font-weight: normal; color: #2D3A41; mso-line-height-rule: exactly; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; font-variant-ligatures: normal; text-rendering: optimizeLegibility; -moz-osx-font-smoothing: grayscale; background-color: #ffffff;" bgcolor="#ffffff">
        <table class="pc-project-body" style="table-layout: fixed; width: 100%; min-width: 600px; background-color: #ffffff;" bgcolor="#ffffff" border="0" cellspacing="0" cellpadding="0" role="presentation">
            <tr>
                <td align="center" valign="top">
                    <table class="pc-project-container" align="center" style="width: 600px; max-width: 600px;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                        <tr>
                            <td style="padding: 20px 0px 20px 0px;" align="left" valign="top">
                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                    <tr>
                                        <td valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                                <tr>
                                                    <td class="pc-w620-spacing-0-0-0-0" style="padding: 0px 0px 10px 0px;" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                                            <tr>
                                                                <td valign="top" class="pc-w620-padding-24-0-0-0" style="height: unset; background-color: #ffffff;" bgcolor="#ffffff">
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr>
                                                                            <td class="pc-w620-spacing-0-0-24-0" style="padding: 0px 0px 24px 0px;">
                                                                                <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                    <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                                        <td class="pc-grid-td-first pc-w620-itemsSpacings-0-20" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                                                                                            <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                <tr>
                                                                                                    <td class="pc-w620-halign-center pc-w620-valign-middle" align="left" valign="middle">
                                                                                                        <table class="pc-w620-halign-center" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-halign-center" align="left" valign="top" style="line-height: 1;">
                                                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr>
                                                                                                                            <td class="pc-w620-halign-center" align="left" valign="top">
                                                                                                                                <img src="https://cloudfilesdm.com/postcards/6bcf4080513af0370392a31b2b1e5af4.png" class="pc-w620-width-136 pc-w620-height-auto pc-w620-align-center" width="134" height="26" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; object-fit: contain; width: 134px; height: auto; max-width: 100%; border: 0;" />
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
                                                                                        <td class="pc-grid-td-last pc-w620-itemsSpacings-0-20" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                                                                                            <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                <tr>
                                                                                                    <td class="pc-w620-halign-center pc-w620-valign-middle" align="right" valign="middle">
                                                                                                        <table class="pc-w620-halign-center" align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-halign-center" align="right" valign="top">
                                                                                                                    <table class="pc-w620-halign-center" align="right" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr>
                                                                                                                            <td class="pc-w620-valign-middle pc-w620-halign-center" align="right">
                                                                                                                                <table class="pc-width-hug pc-w620-gridCollapsed-0 pc-w620-width-hug pc-w620-halign-center" align="right" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                    <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                                                                                        <td class="pc-grid-td-first pc-w620-itemsSpacings-24-0" valign="middle" style="padding-top: 0px; padding-right: 10px; padding-bottom: 0px; padding-left: 0px;">
                                                                                                                                            <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-halign-center pc-w620-valign-middle" align="center" valign="middle">
                                                                                                                                                        <table class="pc-w620-halign-center" align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td class="pc-w620-halign-center" align="center" valign="top">
                                                                                                                                                                    <table class="pc-w620-halign-center pc-w620-width-100pc" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td valign="top">
                                                                                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                                    <tr>
                                                                                                                                                                                        <td valign="top" class="pc-w620-textAlign-center" align="center">
                                                                                                                                                                                            <a class="pc-font-alt pc-w620-textAlign-center" href="https://designmodo.com/postcards" target="_blank" style="display: block; text-decoration: none; line-height: 140%; letter-spacing: 0px; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 14px; font-weight: normal; color: #001942; text-align: center; text-align-last: center;">
                                                                                                                                                                                                <span>Track Package</span> 
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
                                                                                                                                        <td class="pc-grid-td-last pc-w620-itemsSpacings-24-0" valign="middle" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 10px;">
                                                                                                                                            <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-halign-center pc-w620-valign-middle" align="center" valign="middle">
                                                                                                                                                        <table class="pc-w620-halign-center" align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td class="pc-w620-halign-center" align="center" valign="top">
                                                                                                                                                                    <table class="pc-w620-halign-center pc-w620-width-100pc" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td valign="top">
                                                                                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                                    <tr>
                                                                                                                                                                                        <td valign="top" class="pc-w620-textAlign-center" align="center">
                                                                                                                                                                                            <a class="pc-font-alt pc-w620-textAlign-center" href="https://designmodo.com/postcards" target="_blank" style="display: block; text-decoration: none; line-height: 140%; letter-spacing: 0px; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 14px; font-weight: normal; color: #001942; text-align: center; text-align-last: center;">
                                                                                                                                                                                                <span>Contact Us</span> 
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
                                                                    <table class="pc-width-fill pc-w620-gridCollapsed-0" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                            <td class="pc-grid-td-first pc-grid-td-last" align="center" valign="top" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px;">
                                                                                <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                    <tr>
                                                                                        <td class="pc-w620-padding-40-24-40-24" align="center" valign="bottom" style="padding: 44px 44px 44px 44px; background-color: #ecf1fb; border-radius: 10px 10px 10px 10px;">
                                                                                            <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                <tr>
                                                                                                    <td align="center" valign="top" style="line-height: 1;">
                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td align="center" valign="top" style="padding: 0px 0px 32px 0px;">
                                                                                                                    <img src="https://cloudfilesdm.com/postcards/image-17402946362712.png" width="150" height="162" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 150px; height: auto; max-width: 100%; border: 0;" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td align="center" valign="top" style="line-height: 1;">
                                                                                                        <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td valign="top" style="padding: 0px 0px 20px 0px;">
                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                        <tr>
                                                                                                                            <td valign="top" align="center">
                                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                    <div style="font-size: 32px;line-height: 32px;text-align:center;text-align-last:center;color:#001942;font-weight:600;font-style:normal;">
                                                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 40px; line-height: 100%; letter-spacing: -0.03em;" class="pc-w620-font-size-32px pc-w620-line-height-32px">Cảm ơn vì đã đến!</span>
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
                                                                                                    <td align="center" valign="top" style="line-height: 1;">
                                                                                                        <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td valign="top" style="padding: 10px 0px 20px 0px;">
                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                        <tr>
                                                                                                                            <td valign="top" align="center">
                                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                    <div style="font-size: 16px;line-height: 24px;text-align:left;text-align-last:left;color:#404541;letter-spacing:-0.2px;font-weight:400;font-style:normal;">
                                                                                                                                        <div><span style="font-family: 'Inter', Arial, Helvetica, sans-serif; font-size: 18px; line-height: 30px;" class="pc-w620-font-size-16px pc-w620-line-height-24px">Hey Michael </span><span style="font-family: 'Inter', Arial, Helvetica, sans-serif; font-size: 18px; line-height: 30px;" class="pc-w620-line-height-24px">👋</span><span style="font-family: 'Inter', Arial, Helvetica, sans-serif; font-size: 18px; line-height: 30px;" class="pc-w620-font-size-16px pc-w620-line-height-24px"> </span>
                                                                                                                                        </div>
                                                                                                                                        <div style="letter-spacing:0px;"><span style="font-family: 'Inter', Arial, Helvetica, sans-serif; font-size: 18px; line-height: 30px;" class="pc-w620-font-size-16px pc-w620-line-height-24px">Great news — your order is in! We received it today on Nov 30, 2024, and it’s on its way to you. Expect it to arrive in just 2–5 business days. Exciting times ahead! ✨</span>
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
                                    <tr>
                                        <td valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                                <tr>
                                                    <td class="pc-w620-spacing-0-0-0-0" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                                            <tr>
                                                                <c:forEach items="${orders}" var="o">
                                                                    <td valign="top" class="pc-w620-radius-10-10-10-10 pc-w620-padding-32-24-32-24" style="padding: 40px 24px 40px 24px; height: unset; border-radius: 20px 20px 20px 20px; background-color: #ecf1fb;" bgcolor="#ecf1fb">
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                            <tr>
                                                                                <td class="pc-w620-spacing-0-0-0-0" align="1" valign="top" style="padding: 0px 0px 8px 0px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                        <tr>
                                                                                            <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                    <div style="font-size: 24px;line-height: 24px;text-align:center;text-align-last:center;color:#001942;font-weight:600;font-style:normal;">
                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 100%; letter-spacing: -0.03em;" class="pc-w620-font-size-24px pc-w620-line-height-40px">Đơn hàng của bạn </span>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                            <tr>
                                                                                <td class="pc-w620-spacing-0-0-20-0" align="1" valign="top" style="padding: 0px 0px 30px 0px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                        <tr>
                                                                                            <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                    <div style="font-size: 14px;line-height: 19.6px;text-align:center;text-align-last:center;color:#001942;letter-spacing:0px;font-weight:400;font-style:normal;">
                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%;" class="pc-w620-font-size-16px pc-w620-line-height-28px">Mã đơn hàng: #${o.orderId + 2500000}</span>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                            <tr>
                                                                                <td style="padding: 0px 0px 4px 0px;">
                                                                                    <table class="pc-w620-tableCollapsed-0" border="0" cellpadding="0" cellspacing="0" role="presentation" bgcolor="#FFFFFF" style="width: 100%; background-color:#FFFFFF; border-radius: 10px 10px 10px 10px;">
                                                                                        <tbody>
                                                                                            <c:forEach items="${orderitems}" var="oi">
                                                                                                <tr>
                                                                                                    <td align="left" valign="top" style="padding: 16px 0px 8px 16px; border-bottom: 1px dashed #aab2bb;">
                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr>
                                                                                                                            <td valign="top">
                                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                    <tr>
                                                                                                                                        <th valign="top" style="font-weight: normal; text-align: left;">
                                                                                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-spacing-0-16-20-0" valign="top" style="padding: 0px 20px 0px 0px;">
                                                                                                                                                        <img src="https://cloudfilesdm.com/postcards/image-17402946379006.png" class="pc-w620-width-64 pc-w620-height-64 pc-w620-width-64-min" width="100" height="104" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 100px; height: 104px; border: 0;" />
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                            </table>
                                                                                                                                        </th>
                                                                                                                                        <th valign="top" style="font-weight: normal; text-align: left;">
                                                                                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td>
                                                                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td valign="top">
                                                                                                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <th align="left" valign="top" style="font-weight: normal; text-align: left; padding: 0px 0px 4px 0px;">
                                                                                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                                    <tr>
                                                                                                                                                                                        <td valign="top" align="left" style="padding: 9px 0px 0px 0px;">
                                                                                                                                                                                            <div class="pc-font-alt pc-w620-fontSize-16 pc-w620-lineHeight-26" style="line-height: 140%; letter-spacing: -0.03em; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 16px; font-weight: 600; color: #001942; text-align: left; text-align-last: left;">
                                                                                                                                                                                                <div><span>${oi.productName}</span>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>
                                                                                                                                                                                        </td>
                                                                                                                                                                                    </tr>
                                                                                                                                                                                </table>
                                                                                                                                                                            </th>
                                                                                                                                                                        </tr>
                                                                                                                                                                        <tr>
                                                                                                                                                                            <th align="left" valign="top" style="">
                                                                                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                                    <tr>
                                                                                                                                                                                        <td valign="top" align="left">
                                                                                                                                                                                            <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                                                                                <div style="font-size: 14px;line-height: 19.6px;text-align:left;text-align-last:left;color:#53627a;font-weight:400;font-style:normal;">
                                                                                                                                                                                                    <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;">Số lượng: ${oi.quantity}</span>
                                                                                                                                                                                                    </div>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>
                                                                                                                                                                                        </td>
                                                                                                                                                                                    </tr>
                                                                                                                                                                                </table>
                                                                                                                                                                            </th>
                                                                                                                                                                        </tr>
                                                                                                                                                                        <tr>
                                                                                                                                                                            <th align="left" valign="top" style="padding: 5px 0px 0px 0px;">
                                                                                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                                    <tr>
                                                                                                                                                                                        <td valign="top" align="left">
                                                                                                                                                                                            <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                                                                                <div style="font-size: 14px;line-height: 19.6px;text-align:left;text-align-last:left;color:#53627a;font-weight:400;font-style:normal;">
                                                                                                                                                                                                    <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;">Giá: ${oi.productPrice}</span>
                                                                                                                                                                                                    </div>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>
                                                                                                                                                                                        </td>
                                                                                                                                                                                    </tr>
                                                                                                                                                                                </table>
                                                                                                                                                                            </th>
                                                                                                                                                                        </tr>
                                                                                                                                                                    </table>
                                                                                                                                                                </td>
                                                                                                                                                            </tr>
                                                                                                                                                        </table>
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                            </table>
                                                                                                                                        </th>
                                                                                                                                    </tr>
                                                                                                                                </table>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                    <td class="pc-w620-padding-28-32-24-16" align="right" valign="top" style="padding: 24px 16px 24px 16px; border-bottom: 1px dashed #aab2bb;">
                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                            <tr>
                                                                                                                <td valign="top" align="right">
                                                                                                                    <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                        <div style="font-size: 16px;line-height: 20px;text-align:right;text-align-last:right;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                            <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-16px pc-w620-line-height-20px">${oi.getSubtotal()}</span>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </c:forEach>
                                                                                            
                                                                                        </tbody>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                            <tr>
                                                                                <td style="padding: 0px 0px 4px 0px;">
                                                                                    <table class="pc-w620-tableCollapsed-0" border="0" cellpadding="0" cellspacing="0" role="presentation" bgcolor="#ffffff" style="width: 100%; background-color:#ffffff; border-radius: 10px 10px 10px 10px;">
                                                                                        <tbody>
                                                                                            <tr>
                                                                                                <td align="left" valign="middle" style="padding: 16px 0px 16px 16px;">
                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                        <tr>
                                                                                                            <td valign="top" align="left">
                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                    <div style="font-size: 16px;line-height: 22.4px;text-align:left;text-align-last:left;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-16px pc-w620-line-height-26px">Tạm tính</span>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                                <td align="right" valign="middle" style="padding: 16px 16px 16px 16px;">
                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                        <tr>
                                                                                                            <td valign="top" align="right">
                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                    <div style="font-size: 16px;line-height: 22.4px;text-align:right;text-align-last:right;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;">${basicPrice}</span>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td align="left" valign="middle" style="padding: 16px 0px 16px 16px;">
                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                        <tr>
                                                                                                            <td valign="top" align="left">
                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                    <div style="font-size: 16px;line-height: 22.4px;text-align:left;text-align-last:left;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-16px pc-w620-line-height-26px">${o.shippingMethodName}</span>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                                <td align="right" valign="middle" style="padding: 16px 16px 16px 16px;">
                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                        <tr>
                                                                                                            <td valign="top" align="right">
                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                    <div style="font-size: 16px;line-height: 20px;text-align:right;text-align-last:right;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-16px pc-w620-line-height-20px">${o.shippingMethodFee}</span>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                            <tr>
                                                                                <td style="padding: 0px 0px 32px 0px;">
                                                                                    <table class="pc-w620-tableCollapsed-0" border="0" cellpadding="0" cellspacing="0" role="presentation" bgcolor="#ffffff" style="width: 100%; background-color:#ffffff; border-radius: 10px 10px 10px 10px;">
                                                                                        <tbody>
                                                                                            <tr>
                                                                                                <td valign="middle" style="width: 377px;">
                                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                        <tr>
                                                                                                            <td style="padding: 16px 0px 16px 16px;" align="left">
                                                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                    <tr>
                                                                                                                        <td valign="top" align="left">
                                                                                                                            <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                <div style="font-size: 16px;line-height: 22.4px;text-align:left;text-align-last:left;color:#001942;font-weight:600;font-style:normal;">
                                                                                                                                    <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-16px pc-w620-line-height-26px">Thành tiền</span>
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
                                                                                                <td align="right" valign="middle" style="padding: 16px 16px 16px 16px;">
                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                        <tr>
                                                                                                            <td valign="top" align="right">
                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                    <div style="font-size: 16px;line-height: 20px;text-align:right;text-align-last:right;color:#001942;font-weight:600;font-style:normal;">
                                                                                                                        <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-16px pc-w620-line-height-20px">${o.totalAmount}</span>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                            <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                                <td class="pc-grid-td-first pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 20px; padding-bottom: 0px; padding-left: 0px;">
                                                                                    <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                        <tr>
                                                                                            <td align="left" valign="top">
                                                                                                <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                    <tr>
                                                                                                        <td align="left" valign="top">
                                                                                                            <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                <tr>
                                                                                                                    <td class="pc-w620-spacing-0-0-14-0" valign="top" style="padding: 0px 0px 14px 0px;">
                                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                            <tr>
                                                                                                                                <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                                                                                                                    <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                        <div style="font-size: 16px;line-height: 22.4px;text-align:left;text-align-last:left;color:#001942;letter-spacing:-0.2px;font-weight:600;font-style:normal;">
                                                                                                                                            <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%;">Địa chỉ giao hàng</span>
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
                                                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                <tr>
                                                                                                                    <td class="pc-w620-spacing-0-0-14-0" valign="top" style="padding: 0px 0px 14px 0px;">
                                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="margin-right: auto;">
                                                                                                                            <tr>
                                                                                                                                <td valign="top" style="line-height: 1px; font-size: 1px; border-bottom: 1px solid #cecece;">&nbsp;</td>
                                                                                                                            </tr>
                                                                                                                        </table>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td align="left" valign="top">
                                                                                                            <table border="0" cellpadding="0" cellspacing="0" role="presentation" align="left">
                                                                                                                <tr>
                                                                                                                    <td valign="top" align="left">
                                                                                                                        <div class="pc-font-alt" style="line-height: 140%; letter-spacing: 0px; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 14px; font-weight: normal; color: #001942; text-align: left; text-align-last: left;">
                                                                                                                            <div><span>${o.address}</span>
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
                                                                                <td class="pc-grid-td-last pc-w620-itemsSpacings-0-30" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 20px;">
                                                                                    <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                        <tr>
                                                                                            <td align="left" valign="top">
                                                                                                <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                    <tr>
                                                                                                        <td align="left" valign="top">
                                                                                                            <table align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                <tr>
                                                                                                                    <td class="pc-w620-spacing-0-0-14-0" valign="top" style="padding: 0px 0px 14px 0px;">
                                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                            <tr>
                                                                                                                                <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                                                                                                                    <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                        <div style="font-size: 16px;line-height: 22.4px;text-align:left;text-align-last:left;color:#001942;letter-spacing:-0.2px;font-weight:600;font-style:normal;">
                                                                                                                                            <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%;">Thông tin nhận hàng</span>
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
                                                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                <tr>
                                                                                                                    <td class="pc-w620-spacing-0-0-14-0" valign="top" style="padding: 0px 0px 14px 0px;">
                                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="margin-right: auto;">
                                                                                                                            <tr>
                                                                                                                                <td valign="top" style="line-height: 1px; font-size: 1px; border-bottom: 1px solid #cecece;">&nbsp;</td>
                                                                                                                            </tr>
                                                                                                                        </table>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td align="left" valign="top">
                                                                                                            <table class="pc-w620-width-auto" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                <tr>
                                                                                                                    <td valign="top">
                                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                            <tr>
                                                                                                                                <td valign="top" align="left">
                                                                                                                                    <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                        <div style="font-size: 14px;line-height: 19.6px;text-align:left;text-align-last:left;color:#001942;letter-spacing:0px;font-weight:400;font-style:normal;">
                                                                                                                                            <div class="pc-w620-text-align-left"><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%;">Họ tên: ${o.name}</span>                                                                                                                                               
                                                                                                                                                <br><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%;">Điện thoại: ${o.phone}</span>
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
                                                                </c:forEach>                                                          
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
                                                                <td valign="top" class="pc-w620-padding-32-0-4-0" style="padding: 40px 0px 4px 0px; height: unset; background-color: #ffffff;" bgcolor="#ffffff">
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr>
                                                                            <td class="pc-w620-spacing-0-0-20-0" align="1" valign="top" style="padding: 0px 0px 32px 0px;">
                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                    <tr>
                                                                                        <td valign="top" class="pc-w620-padding-0-0-0-0" align="left">
                                                                                            <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                <div style="font-size: 24px;line-height: 32px;text-align:center;text-align-last:center;color:#001942;font-weight:600;font-style:normal;">
                                                                                                    <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: -0.03em;" class="pc-w620-font-size-24px pc-w620-line-height-32px">Bạn cần hỗ trợ?</span>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <table class="pc-width-fill pc-w620-gridCollapsed-1" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                            <td class="pc-grid-td-first pc-w620-itemsSpacings-0-4" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 2px; padding-bottom: 0px; padding-left: 0px;">
                                                                                <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                    <tr>
                                                                                        <td class="pc-w620-padding-16-24-16-24 pc-w620-halign-center pc-w620-valign-middle" align="left" valign="middle" style="padding: 16px 16px 16px 16px; background-color: #ecf1fb; border-radius: 10px 10px 10px 10px;">
                                                                                            <table class="pc-w620-halign-center" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                <tr>
                                                                                                    <td class="pc-w620-halign-center" align="left" valign="top">
                                                                                                        <table class="pc-w620-halign-center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-valign-middle pc-w620-halign-left">
                                                                                                                    <table class="pc-width-fill pc-w620-gridCollapsed-0 pc-w620-halign-left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                                                                            <td class="pc-grid-td-first pc-w620-itemsSpacings-0-16" align="left" valign="middle" style="padding-top: 0px; padding-right: 8px; padding-bottom: 0px; padding-left: 0px;">
                                                                                                                                <table class="pc-w620-halign-left" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                    <tr>
                                                                                                                                        <td class="pc-w620-halign-left pc-w620-valign-middle" align="left" valign="middle">
                                                                                                                                            <table class="pc-w620-halign-left" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-halign-left" align="left" valign="top">
                                                                                                                                                        <table class="pc-w620-halign-left" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td valign="top" style="padding: 0px 0px 5px 0px;">
                                                                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td valign="top" align="left">
                                                                                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                                                                    <div style="font-size: 12px;line-height: 16.8px;text-align:left;text-align-last:left;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                                                                                        <div class="pc-w620-text-align-left"><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: 0.04em; text-transform: uppercase;">Email chúng tôi</span>
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
                                                                                                                                                    <td class="pc-w620-halign-left" align="left" valign="top">
                                                                                                                                                        <table class="pc-w620-halign-left" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td class="pc-w620-spacing-0-0-0-0" valign="top">
                                                                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td valign="top" class="pc-w620-padding-0-0-0-0 pc-w620-textAlign-left" align="left">
                                                                                                                                                                                <div class="pc-font-alt pc-w620-textAlign-left" style="line-height: 140%; letter-spacing: -0.03em; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 17px; font-weight: 600; color: #001942; text-align: left; text-align-last: left;">
                                                                                                                                                                                    <div><span style="letter-spacing: -0.03em;">hi@sellymoon.com</span>
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
                                                                                                                            <td class="pc-grid-td-last pc-w620-itemsSpacings-0-16" align="left" valign="middle" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 8px;">
                                                                                                                                <table class="pc-w620-width-fill pc-w620-halign-left" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                    <tr>
                                                                                                                                        <td class="pc-w620-halign-right pc-w620-valign-middle" align="right" valign="middle">
                                                                                                                                            <table class="pc-w620-halign-right" align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-halign-right" align="right" valign="top" style="line-height: 1;">
                                                                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td class="pc-w620-halign-right" align="right" valign="top">
                                                                                                                                                                    <img src="https://cloudfilesdm.com/postcards/c2fa1723839cb48cc87fa29b518490bd.png" class="pc-w620-align-right" width="32" height="25" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; object-fit: contain; width: 32px; height: auto; max-width: 100%; border: 0;" />
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
                                                                            <td class="pc-grid-td-last pc-w620-itemsSpacings-0-4" align="left" valign="top" style="width: 50%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 2px;">
                                                                                <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                    <tr>
                                                                                        <td class="pc-w620-padding-16-24-16-24 pc-w620-halign-center pc-w620-valign-middle" align="left" valign="middle" style="padding: 16px 16px 16px 16px; background-color: #ecf1fb; border-radius: 10px 10px 10px 10px;">
                                                                                            <table class="pc-w620-halign-center" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                <tr>
                                                                                                    <td class="pc-w620-halign-center" align="left" valign="top">
                                                                                                        <table class="pc-w620-halign-center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-valign-middle pc-w620-halign-left">
                                                                                                                    <table class="pc-width-fill pc-w620-gridCollapsed-0 pc-w620-halign-left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                                                                            <td class="pc-grid-td-first pc-w620-itemsSpacings-0-16" align="left" valign="middle" style="padding-top: 0px; padding-right: 8px; padding-bottom: 0px; padding-left: 0px;">
                                                                                                                                <table class="pc-w620-halign-left" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                    <tr>
                                                                                                                                        <td class="pc-w620-halign-left pc-w620-valign-middle" align="left" valign="middle">
                                                                                                                                            <table class="pc-w620-halign-left" align="left" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-halign-left" align="left" valign="top">
                                                                                                                                                        <table class="pc-w620-halign-left" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td valign="top" style="padding: 0px 0px 5px 0px;">
                                                                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td valign="top" align="left">
                                                                                                                                                                                <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                                                                                                    <div style="font-size: 12px;line-height: 16.8px;text-align:left;text-align-last:left;color:#001942;font-weight:400;font-style:normal;">
                                                                                                                                                                                        <div class="pc-w620-text-align-left"><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 140%; letter-spacing: 0.04em; text-transform: uppercase;">liên hệ chúng tôi</span>
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
                                                                                                                                                    <td class="pc-w620-halign-left" align="left" valign="top">
                                                                                                                                                        <table class="pc-w620-halign-left" align="left" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td class="pc-w620-spacing-0-0-0-0" valign="top">
                                                                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                                                                                                                                                        <tr>
                                                                                                                                                                            <td valign="top" class="pc-w620-padding-0-0-0-0 pc-w620-textAlign-left" align="left">
                                                                                                                                                                                <div class="pc-font-alt pc-w620-textAlign-left" style="line-height: 140%; letter-spacing: -0.03em; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 17px; font-weight: 600; color: #001942; text-align: left; text-align-last: left;">
                                                                                                                                                                                    <div><span>+1 (234) 567-8901</span>
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
                                                                                                                            <td class="pc-grid-td-last pc-w620-itemsSpacings-0-16" align="left" valign="middle" style="padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 8px;">
                                                                                                                                <table class="pc-w620-width-fill pc-w620-halign-left" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                    <tr>
                                                                                                                                        <td class="pc-w620-halign-right pc-w620-valign-middle" align="right" valign="middle">
                                                                                                                                            <table class="pc-w620-halign-right" align="right" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                <tr>
                                                                                                                                                    <td class="pc-w620-halign-right" align="right" valign="top" style="line-height: 1;">
                                                                                                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                                                            <tr>
                                                                                                                                                                <td class="pc-w620-halign-right" align="right" valign="top">
                                                                                                                                                                    <img src="https://cloudfilesdm.com/postcards/34e7e765c4eb401497370027260523e1.png" class="pc-w620-align-right" width="32" height="32" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; object-fit: contain; width: 32px; height: auto; max-width: 100%; border: 0;" />
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
                                                                <td valign="top" class="pc-w620-radius-10-10-10-10 pc-w620-padding-24-24-24-24" style="padding: 24px 24px 24px 24px; height: unset; border-radius: 10px 10px 10px 10px; background-color: #0067ff;" bgcolor="#0067ff">
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr>
                                                                            <td align="center" valign="top" style="padding: 0px 0px 12px 0px;">
                                                                                <img src="https://cloudfilesdm.com/postcards/ebe8030dba901967d43e7fbf28bab58f.png" width="135" height="26" alt="" style="display: block; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; object-fit: contain; width: 135px; height: auto; max-width: 100%; border: 0;" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr>
                                                                            <td class="pc-w620-spacing-10-0-0-0" align="center" valign="top">
                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%" style="margin-right: auto; margin-left: auto;">
                                                                                    <tr>
                                                                                        <td valign="top" class="pc-w620-padding-0-0-0-0" align="center">
                                                                                            <div class="pc-font-alt" style="text-decoration: none;">
                                                                                                <div style="font-size: 14px;line-height: 20.02px;text-align:center;text-align-last:center;color:#ffffff;letter-spacing:-0.2px;font-weight:400;font-style:normal;">
                                                                                                    <div><span style="font-family: 'Poppins', Arial, Helvetica, sans-serif;line-height: 143%;">600 Nguyễn Văn Cừ nối dài, Ninh Kiều, Cần Thơ</span>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr>
                                                                            <td class="pc-w620-spacing-10-0-0-0" align="1" valign="top" style="padding: 10px 0px 0px 0px;">
                                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%" style="margin-right: auto; margin-left: auto;">
                                                                                    <tr>
                                                                                        <td valign="top" class="pc-w620-padding-0-0-0-0" align="center">
                                                                                            <div class="pc-font-alt" style="line-height: 171%; letter-spacing: -0.2px; font-family: 'Poppins', Arial, Helvetica, sans-serif; font-size: 14px; font-weight: 500; color: #ffffff; text-align: center; text-align-last: center;">
                                                                                                <div><span>﻿</span><a href="https://designmodo.com/postcards/" target="_blank" style="text-decoration: none; color: #ffffff;"><span style="text-decoration: underline;">Unsubscribe</span><span> or </span><span style="text-decoration: underline;">Change email preferences</span></a><span>﻿</span>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                        <tr>
                                                                            <td align="center" style="padding: 24px 0px 0px 0px;">
                                                                                <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                    <tr>
                                                                                        <td valign="top">
                                                                                            <table class="pc-width-hug pc-w620-gridCollapsed-0" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                <tr class="pc-grid-tr-first pc-grid-tr-last">
                                                                                                    <td class="pc-grid-td-first pc-w620-itemsSpacings-6-0" valign="middle" style="width: 20%; padding-top: 0px; padding-right: 12px; padding-bottom: 0px; padding-left: 0px;">
                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-padding-12-12-12-12" align="center" valign="middle" style="border-radius: 500px 500px 500px 500px;">
                                                                                                                    <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr>
                                                                                                                            <td align="center" valign="top" style="line-height: 1;">
                                                                                                                                <a class="pc-font-alt" href="https://designmodo.com/postcards" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                                                                                                                                    <img src="https://cloudfilesdm.com/postcards/d39505db407e6ca83fd432b2866ccda0.png" class="" width="26" height="26" style="display: block; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 26px; height: 26px;" alt="" />
                                                                                                                                </a>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                    <td class="pc-w620-itemsSpacings-6-0" valign="middle" style="width: 20%; padding-top: 0px; padding-right: 12px; padding-bottom: 0px; padding-left: 12px;">
                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-padding-12-12-12-12" align="center" valign="middle" style="border-radius: 500px 500px 500px 500px;">
                                                                                                                    <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr>
                                                                                                                            <td align="center" valign="top" style="line-height: 1;">
                                                                                                                                <a class="pc-font-alt" href="https://designmodo.com/postcards" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                                                                                                                                    <img src="https://cloudfilesdm.com/postcards/502b0595d6ddd6fc8df1fe4bb7f886cd.png" class="" width="26" height="26" style="display: block; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 26px; height: 26px;" alt="" />
                                                                                                                                </a>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                    <td class="pc-w620-itemsSpacings-6-0" valign="middle" style="width: 20%; padding-top: 0px; padding-right: 12px; padding-bottom: 0px; padding-left: 12px;">
                                                                                                        <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                            <tr>
                                                                                                                <td class="pc-w620-padding-12-12-12-12" align="center" valign="middle" style="border-radius: 500px 500px 500px 500px;">
                                                                                                                    <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                                                        <tr>
                                                                                                                            <td align="center" valign="top" style="line-height: 1;">
                                                                                                                                <a class="pc-font-alt" href="https://designmodo.com/postcards" target="_blank" style="text-decoration: none; display: inline-block; vertical-align: top;">
                                                                                                                                    <img src="https://cloudfilesdm.com/postcards/3b897c472dab53429b14734d1fa9a8bd.png" class="" width="26" height="26" style="display: block; border: 0; outline: 0; line-height: 100%; -ms-interpolation-mode: bicubic; width: 26px; height: 26px;" alt="" />
                                                                                                                                </a>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                    <td class="pc-grid-td-last pc-w620-itemsSpacings-6-0" valign="middle" style="width: 20%; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 12px;">
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

