<cfcomponent displayname="SFCL_Tracking" hint="SunFish Recruitment Tracking Process Object" extends="SFBP">
    <cfset strckArgument = {  
        "Module" 			= "RC",
        "ObjectName" 		= "CL_Tracking",
        "ObjectTable" 		= "TRCMAPPPERSONAL",
        "ObjectTitle" 		= "Recruitment Tracking",
        "KeyField" 			= "",
        "TitleField" 		= "",
        "GridColumn" 		= "",
        "PKeyField" 		= "",
        "ObjectApproval" 	= "",
        "DocApproval" 		= "",
        "bIsTransaction" 	= true
        } />
    <cfset Init(argumentCollection = strckArgument) />

    <!--- Assets --->
    <!--- Suggest Position --->
    <cffunction  name="suggestPosition">
        <cfparam  name="search" default="">
        <cfparam  name="getVal" default="id">
        <cfparam  name="autoPick" default="">

        <cfset LOCAL.searchText = trim(search)>
        <cfset LOCAL.valField = IIF(getVal eq "id", "'nval'", "'ntitle'")>
        
        <cfquery name="LOCAL.qCatCode" datasource="#REQUEST.SDSN#">
            SELECT REQUEST_NO, REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG# FROM TRCMRECRUITREQ WHERE REQUEST_NO = <cfqueryparam value="#searchText#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfquery name="LOCAL.qLookUp" datasource="#REQUEST.SDSN#">
            SELECT REQUEST_NO nval, REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG# ntitle FROM TRCMRECRUITREQ
            <cfif searchText neq "???">
                <cfif qCatCode.recordcount neq 0>
                    <cfif len(autoPick)>
                        WHERE REQUEST_NO = <cfqueryparam value="#searchText#" cfsqltype="cf_sql_varchar">
                    <cfelse>
                        WHERE REQUEST_NO LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">
                    </cfif>
                <cfelse>
                    WHERE (#Application.SFUtil.DBConcat(["REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG#","[","RECRUITER","]"])# LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">
                    OR REQUEST_NO LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">)
                </cfif>
            </cfif>
            ORDER BY ntitle
        </cfquery>

        <cfset LOCAL.jsfunc = "function () { loadsuggest(); try { srcApp(); } catch(err) {} }">
        <cfset APPLICATION.SFLookUp.tipLookUp(qLookUp,"Position",valField,"nval","ntitle",false,searchText,jsfunc)>
    </cffunction>

    <!--- Suggest Recruiter --->
    <cffunction  name="suggestRecruiter">
        <cfparam  name="search" default="">
        <cfparam  name="getVal" default="id">
        <cfparam  name="autoPick" default="">

        <cfset LOCAL.searchText = trim(search)>
        <cfset LOCAL.valField = IIF(getVal eq "id", "'nval'", "'ntitle'")>
        
        <cfquery name="LOCAL.qCatCode" datasource="#REQUEST.SDSN#">
            SELECT EMP_ID, FULL_NAME FROM TRCMRECRUITREQ A INNER JOIN TEOMEMPPERSONAL B ON A.RECRUITER = B.EMP_ID WHERE EMP_ID = <cfqueryparam value="#searchText#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfquery name="LOCAL.qLookUp" datasource="#REQUEST.SDSN#">
            SELECT EMP_ID nval, FULL_NAME ntitle FROM TRCMRECRUITREQ A INNER JOIN TEOMEMPPERSONAL B ON A.RECRUITER = B.EMP_ID
            <cfif searchText neq "???">
                <cfif qCatCode.recordcount neq 0>
                    <cfif len(autoPick)>
                        WHERE EMP_ID = <cfqueryparam value="#searchText#" cfsqltype="cf_sql_varchar">
                    <cfelse>
                        WHERE EMP_ID LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">
                    </cfif>
                <cfelse>
                    WHERE (#Application.SFUtil.DBConcat(["FULL_NAME","' ['","EMP_ID","']'"])# LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                    OR EMP_ID LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">)
                </cfif>
            </cfif>
            ORDER BY ntitle
        </cfquery>

        <cfset LOCAL.jsfunc = "function () { loadsuggest(); try { srcApp(); } catch(err) {} }">
        <cfset APPLICATION.SFLookUp.tipLookUp(qLookUp,"Position",valField,"nval","ntitle",false,searchText,jsfunc)>
    </cffunction>

    <!--- Suggest Status --->
    <cffunction  name="suggestStatus">
        <cfparam  name="search" default="">
        <cfparam  name="getVal" default="id">
        <cfparam  name="autoPick" default="">

        <cfset LOCAL.searchText = trim(search)>
        <cfset LOCAL.valField = IIF(getVal eq "id", "'nval'", "'ntitle'")>
        
        <cfquery name="LOCAL.qCatCode" datasource="#REQUEST.SDSN#">
            SELECT CODE, NAME_#REQUEST.SCOOKIE.LANG# FROM TRCDAPPSUGSTATUS WHERE CODE = <cfqueryparam value="#searchText#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfquery name="LOCAL.qLookUp" datasource="#REQUEST.SDSN#">
            SELECT CODE nval, NAME_#REQUEST.SCOOKIE.LANG# ntitle FROM TRCDAPPSUGSTATUS
            <cfif searchText neq "???">
                <cfif qCatCode.recordcount neq 0>
                    <cfif len(autoPick)>
                        WHERE CODE = <cfqueryparam value="#searchText#" cfsqltype="cf_sql_varchar">
                    <cfelse>
                        WHERE CODE LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">
                    </cfif>
                <cfelse>
                    WHERE (#Application.SFUtil.DBConcat(["NAME_#REQUEST.SCOOKIE.LANG#","[","CODE","]"])# LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">
                    OR CODE LIKE <cfqueryparam value="%#searchText#%" cfsqltype="cf_sql_varchar">)
                </cfif>
            </cfif>
            ORDER BY ntitle
        </cfquery>

        <cfset LOCAL.jsfunc = "function () { loadsuggest(); try { srcApp(); } catch(err) {} }">
        <cfset APPLICATION.SFLookUp.tipLookUp(qLookUp,"Position",valField,"nval","ntitle",false,searchText,jsfunc)>
    </cffunction>

    <!--- Option Status --->
    <cffunction  name="optStatus">
        <cfquery name="LOCAL.qOptStatus" datasource="#REQUEST.SDSN#">
            SELECT CODE optvalue, NAME_#REQUEST.SCOOKIE.LANG# opttext FROM TRCDAPPOPTSTATUS
        </cfquery>
        <cfreturn qOptStatus>
    </cffunction>

    <!--- Add Detail  --->
    <cffunction  name="getAddDetail">
        <cfquery name="local.qExtensionPhoto" datasource="#REQUEST.SDSN#">
            SELECT EXT_LIST FROM TSFMUPLOADSETTING WHERE UPLOAD_CODE = 'apptracking_photo'
        </cfquery>
        <cfset strckData['extApplicantPhoto'] = qExtensionPhoto.EXT_LIST>

        <cfquery name="local.qExtensionCV" datasource="#REQUEST.SDSN#">
            SELECT EXT_LIST FROM TSFMUPLOADSETTING WHERE UPLOAD_CODE = 'apptracking_pdf'
        </cfquery>
        <cfset strckData['extApplicantCV'] = qExtensionCV.EXT_LIST>
        
        <cfset strckData["status"] = 0>
        <cfset strckData["recordcount"] = 1>
        <cfreturn strckData>
    </cffunction>

    <!--- Edit Detail  --->
    <cffunction  name="getEditDetail">
        <!--- Get Extension File  --->
        <cfquery name="LOCAL.qExtensionPhoto" datasource="#REQUEST.SDSN#">
            SELECT EXT_LIST FROM TSFMUPLOADSETTING WHERE UPLOAD_CODE = 'apptracking_photo'
        </cfquery>
        <cfset strckData['extApplicantPhoto'] = qExtensionPhoto.EXT_LIST>

        <cfquery name="LOCAL.qExtensionCV" datasource="#REQUEST.SDSN#">
            SELECT EXT_LIST FROM TSFMUPLOADSETTING WHERE UPLOAD_CODE = 'apptracking_pdf'
        </cfquery>
        <cfset strckData['extApplicantCV'] = qExtensionCV.EXT_LIST>
        <cfset strckData['extApplicantFile'] = qExtensionCV.EXT_LIST>

        <!--- Master Applicant Personal  --->
        <cfquery name="LOCAL.qMasterAppPersonal" dataresource="#REQUEST.SDSN#">
            SELECT APPLICANT_ID, FIRST_NAME, MIDDLE_NAME, LAST_NAME, GENDER, EMAIL, PHOTO FROM TRCMAPPPERSONAL WHERE APPLICANT_ID = <cfqueryparam value="#URL.APPLICANT_ID#" cfquerytyp="cf_sql_varchar">
        </cfquery>
        <cfset strckData['applicant_id'] = qMasterAppPersonal.APPLICANT_ID>
        <cfset strckData['first_name'] = qMasterAppPersonal.FIRST_NAME>
        <cfset strckData['middle_name'] = qMasterAppPersonal.MIDDLE_NAME>
        <cfset strckData['last_name'] = qMasterAppPersonal.LAST_NAME>
        <cfset strckData['gender'] = qMasterAppPersonal.GENDER>
        <cfset strckData['email'] = qMasterAppPersonal.EMAIL>
        <cfset strckData['photo'] = qMasterAppPersonal.PHOTO>

        <!--- Detail Applicant Personal  --->
        <cfquery name="LOCAL.qDetailAppPersonal" dataresource="#REQUEST.SDSN#">
            SELECT PHONE, IDENTITY_NO FROM TRCDAPPPERSONAL WHERE APPLICANT_ID = <cfqueryparam value="#URL.applicant_id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfset strckData['phone'] = qDetailAppPersonal.PHONE>
        <cfset strckData['identity_no'] = qDetailAppPersonal.IDENTITY_NO>

        <!--- Detail Applicant Tracking  --->
        <cfquery name="LOCAL.qDetailAppTracking" dataresource="#REQUEST.SDSN#">
            SELECT CV, POSITION_APPLIED, RECRUITER, STATUS, EST_JOIN_DATE, PTK_APPLIED, PE_DATE, PE_STATUS, PE_NOTED, PE_FILE, IN_DATE, IN_STATUS, IN_NOTED, IN_FILE, NE_DATE, NE_STATUS, NE_NOTED, NE_FILE, MEDIC_DATE, MEDIC_STATUS, MEDIC_NOTED, MEDIC_FILE, DOC_DATE, DOC_STATUS, DOC_NOTED, DOC_FILE, OFF_DATE, OFF_STATUS, OFF_NOTED, OFF_FILE WHERE APPLICANT_ID = <cfqueryparam value="#URL.applicant_id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfset strckData['cv'] = qDetailAppTracking.CV>
        <cfset strckData['position_applied'] = qDetailAppTracking.POSITION_APPLIED>
        <cfset strckData['recruiter'] = qDetailAppTracking.RECRUITER>
        <cfset strckData['app_status'] = qDetailAppTracking.STATUS>
        <cfset strckData['est_join_date'] = qDetailAppTracking.EST_JOIN_DATE>
        <cfset strckData['pt_applied'] = qDetailAppTracking.PT_APPLIED>
        <cfset strckData['pe_date'] = qDetailAppTracking.PE_DATE>
        <cfset strckData['pe_status'] = qDetailAppTracking.PE_STATUS>
        <cfset strckData['pe_noted'] = qDetailAppTracking.PE_NOTED>
        <cfset strckData['pe_file'] = qDetailAppTracking.PE_FILE>
        <cfset strckData['in_date'] = qDetailAppTracking.IN_DATE>
        <cfset strckData['in_status'] = qDetailAppTracking.IN_STATUS>
        <cfset strckData['in_noted'] = qDetailAppTracking.IN_NOTED>
        <cfset strckData['in_file'] = qDetailAppTracking.IN_FILE>
        <cfset strckData['ne_date'] = qDetailAppTracking.NE_DATE>
        <cfset strckData['ne_status'] = qDetailAppTracking.NE_STATUS>
        <cfset strckData['ne_noted'] = qDetailAppTracking.NE_NOTED>
        <cfset strckData['ne_file'] = qDetailAppTracking.NE_FILE>
        <cfset strckData['medic_date'] = qDetailAppTracking.MEDIC_DATE>
        <cfset strckData['medic_status'] = qDetailAppTracking.MEDIC_STATUS>
        <cfset strckData['medic_noted'] = qDetailAppTracking.MEDIC_NOTED>
        <cfset strckData['medic_file'] = qDetailAppTracking.MEDIC_FILE>
        <cfset strckData['doc_date'] = qDetailAppTracking.DOC_DATE>
        <cfset strckData['doc_status'] = qDetailAppTracking.DOC_STATUS>
        <cfset strckData['doc_noted'] = qDetailAppTracking.DOC_NOTED>
        <cfset strckData['doc_file'] = qDetailAppTracking.DOC_FILE>
        <cfset strckData['off_date'] = qDetailAppTracking.OFF_DATE>
        <cfset strckData['off_status'] = qDetailAppTracking.OFF_STATUS>
        <cfset strckData['off_noted'] = qDetailAppTracking.OFF_NOTED>
        <cfset strckData['off_file'] = qDetailAppTracking.OFF_FILE>

        <cfset strckData["status"] = 0>
        <cfset strckData["recordcount"] = 1>
    </cffunction>

    <!--- End Assets --->

    <!--- Main --->
    <cffunction  name="Listing">
        <cfset LOCAL.scParam = paramRequest()>
        <cfset LOCAL.lsField = "A.APPLICANT_ID, 
                                A.PHOTO, 
                                C.PE_FILE,
                                DATE_FORMAT(A.CREATED_DATE,'%d %M %Y') AS REGISTER_DATE, 
                                CONCAT(A.FIRST_NAME,' ', A.MIDDLE_NAME,' ',A.LAST_NAME) AS APPLICANT_NAME, 
                                E.REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG# AS POSITION, 
                                D.FULL_NAME AS RECRUITER, 
                                B.PHONE AS PHONE,
                                A.EMAIL AS EMAIL,
                                C.CV AS CV, 
                                CASE    WHEN C.PE_DATE IS NOT NULL AND C.PE_STATUS IS NOT NULL AND C.PE_NOTED IS NOT NULL AND C.PE_FILE IS NOT NULL THEN 'Pre-Eliminary' 
                                        WHEN C.IN_DATE IS NOT NULL AND C.IN_STATUS IS NOT NULL AND C.IN_NOTED IS NOT NULL AND C.IN_FILE IS NOT NULL THEN 'Interview' 
                                        WHEN C.NE_DATE IS NOT NULL AND C.NE_STATUS IS NOT NULL AND C.NE_NOTED IS NOT NULL AND C.NE_FILE IS NOT NULL THEN 'Negosiasi' 
                                        WHEN C.MEDIC_DATE IS NOT NULL AND C.MEDIC_STATUS IS NOT NULL AND C.MEDIC_NOTED IS NOT NULL AND C.MEDIC_FILE IS NOT NULL THEN 'Medical Check Up' 
                                        WHEN C.DOC_DATE IS NOT NULL AND C.DOC_STATUS IS NOT NULL AND C.DOC_NOTED IS NOT NULL AND C.DOC_FILE IS NOT NULL THEN 'Document Approval' 
                                        WHEN C.OFF_DATE IS NOT NULL AND C.OFF_STATUS IS NOT NULL AND C.OFF_NOTED IS NOT NULL AND C.OFF_FILE IS NOT NULL THEN 'Offering/SPK' END AS LAST_PROGRESS,
                                CONCAT(C.STATUS,' [',DATE_FORMAT(C.EST_JOIN_DATE,'%d %M %Y'),'] ') AS STATUS, 
                                CASE    WHEN C.PE_DATE IS NOT NULL THEN DATE_FORMAT(C.PE_DATE,'%d %M %Y') 
                                        WHEN C.IN_DATE IS NOT NULL THEN DATE_FORMAT(C.IN_DATE,'%d %M %Y') 
                                        WHEN C.NE_DATE IS NOT NULL THEN DATE_FORMAT(C.NE_DATE,'%d %M %Y')
                                        WHEN C.MEDIC_DATE IS NOT NULL THEN DATE_FORMAT(C.MEDIC_DATE,'%d %M %Y')
                                        WHEN C.DOC_DATE IS NOT NULL THEN DATE_FORMAT(C.DOC_DATE,'%d %M %Y') 
                                        WHEN C.OFF_DATE IS NOT NULL THEN DATE_FORMAT(C.OFF_DATE,'%d %M %Y') END AS LAST_PROGRESS_DATE,
                                CONCAT('[APPLY]',' - ',E.REQUEST_NO,'(',E.REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG#,')') AS APPLICANT_APPLY,
                                CASE WHEN C.PE_DATE IS NOT NULL AND C.PE_STATUS IS NOT NULL AND C.PE_NOTED IS NOT NULL AND C.PE_FILE IS NOT NULL THEN CONCAT('[Link]',' - ',C.PE_NOTED) END AS PER_ELIMINARY,
                                CASE WHEN C.IN_DATE IS NOT NULL AND C.IN_STATUS IS NOT NULL AND C.IN_NOTED IS NOT NULL AND C.IN_FILE IS NOT NULL THEN CONCAT('[Link]',' - ',C.IN_NOTED) END AS INTERVIEW,
                                CASE WHEN C.NE_DATE IS NOT NULL AND C.NE_STATUS IS NOT NULL AND C.NE_NOTED IS NOT NULL AND C.NE_FILE IS NOT NULL THEN CONCAT('[Link]',' - ',C.NE_NOTED) END AS NEGO,
                                CASE WHEN C.MEDIC_DATE IS NOT NULL AND C.MEDIC_STATUS IS NOT NULL AND C.MEDIC_NOTED IS NOT NULL AND C.MEDIC_FILE IS NOT NULL THEN CONCAT('[Link]',' - ',C.MEDIC_NOTED) END AS MEDICAL_CHECKUP,
                                CASE WHEN C.DOC_DATE IS NOT NULL AND C.DOC_STATUS IS NOT NULL AND C.DOC_NOTED IS NOT NULL AND C.DOC_FILE IS NOT NULL THEN CONCAT('[Link]',' - ',C.DOC_NOTED) END AS DOCUMENT_APPROVAL,
                                CASE WHEN C.OFF_DATE IS NOT NULL AND C.OFF_STATUS IS NOT NULL AND C.OFF_NOTED IS NOT NULL AND C.OFF_FILE IS NOT NULL THEN CONCAT('[Link]',' - ',C.OFF_NOTED) END AS OFFERING
                                    ">
        <cfset LOCAL.lsTable = "TRCMAPPPERSONAL A INNER JOIN TRCDAPPPERSONAL B ON A.APPLICANT_ID = B.APPLICANT_ID      
                                                  INNER JOIN TRCDAPPTRACKER C ON C.APPLICANT_ID = A.APPLICANT_ID
                                                  INNER JOIN TEOMEMPPERSONAL D ON C.RECRUITER = D.EMP_ID 
                                                  INNER JOIN TRCMRECRUITREQ E ON C.POSITION_APPLIED = E.REQUEST_NO
                                    ">
         <cfset ListingData(scParam,{lsField=lsField,lsField=lsField,lsTable=lsTable,pid=""})>
    </cffunction>
    <cffunction  name="Add">
        <!--- Var --->
        <cfparam  name="first_name" default="">
        <cfparam  name="middle_name" default="">
        <cfparam  name="last_name" default="">
        <cfparam  name="gender" default="">
        <cfparam  name="phone" default="">
        <cfparam  name="email" default="">
        <cfparam  name="identity_no" default="">
        <cfparam  name="photo" default="">
        <cfparam  name="cv" default="">
        <cfparam  name="hdn_position_applied" default="">
        <cfparam  name="hdn_recruiter" default="">

        <cfset applicant_id = Application.SFUtil.getCode("APP_ID",false)>
        <cfset company_code = request.scookie.cocode>
        <cfset full_name = first_name &" "& middle_name &" "& last_name>
        <cfset applicant_sts = "ACTIVE">
        <cfset src_online = 0>
        <cfset accept_online = 0>
        <cfset security_code = "s">

        <!--- Validation Backend --->
        <cfif len(identityno) GT 1 AND len(identityno) LT 15>
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSFailed No. KTP no less then 16 characters",true)>
            <cfoutput>
                <script>
                    alert("#SFLANG#");
                </script>
            </cfoutput>
            <cfabort>
        </cfif>


        <!--- Upload file to server --->
        <cfif photo neq "">
            <cfset var file_name = applicant_id&'_'&'APP_PHOTO'>
            <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_photo" FILEFIELD="photo" REWRITE="" RENAME="#file_name#" output="vTest">
            <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
            <cfset app_photo = dateFormat(now(), "yyyymm")&'/'&file_name_save />
        <cfelse>
            <cfset app_photo = '' />
        </cfif>

        <cfif cv neq "">
            <cfset var file_name = applicant_id&'_'&'APP_CV' />
            <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="cv" REWRITE="" RENAME="#file_name#" output="vTest">
            <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
            <cfset app_photo = &file_name_save />
        <cfelse>
            <cfset app_cv = '' />
        </cfif>

        <!--- Query Insert Data --->
        <cfquery name="qCheckCount" datasource="#REQUEST.SDSN#">
            SELECT identity_no FROM TRCDAPPPERSONAL WHERE identity_no = <cfqueryparam value="#identityno#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif not qCheckCount.recordcount>
            <cfquery name="qInsertMasterApplicantPersonal" datasource="#REQUEST.SDSN#">
                INSERT INTO (applicant_id, company_code, first_name, middle_name, last_name, gender, user_id, taxno, email, photo, geocoord, status, req_status, lastreqno, created_date, created_by, modified_date, modified_by, official_name, initial_name, app_image, app_signature, full_name, applicant_sts, src_online, security_code, accept_online, job_exp, app_region, jobcategory_code, gradecategory_code, inactive_reason)
                VALUES (cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#company_code#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#first_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#middle_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#last_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#gender#" cfsqltype="cf_sql_varchar">, null, '', <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#app_photo#" cfsqltype="cf_sql_varchar">,null, 1, 0, null,<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, null, null, null, null,<cfqueryparam value="#full_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#applicant_sts#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#src_online#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#security_code#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#accept_online#" cfsqltype="cf_sql_varchar">, 0, null,null, null, null)
            </cfquery>
            <cfquery name="qInsertDetailApplicantPersonal" datasource="#REQUEST.SDSN#">
                INSERT INTO TRCDAPPPERSONAL (applicant_id, birthplace, birthdate, nationality_code, religion_code, race_code, identity_no, identity_expdate, salutation_code, dialect_code, maritalstatus, married_date, married_place, phone, edutitle1, edutitle2, gmt_id, created_date, created_by, modified_date, modified_by, app_rumpun, is_employee, exp_jdate)
                VALUES (<cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">, null, null, null, null, null, <cfqueryparam value="#identity_no#" cfsqltype="cf_sql_varchar">, null, null, null, 0, null, null, <cfqueryparam value="#phone#" cfsqltype="cf_sql_varchar">, null, null, null, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, null, 0, null)
            </cfquery>
            <cfquery name="qInsertDetailApplicantTracker" datasource="#REQUEST.SDSN#">
                INSERT INTO TRCDAPPTRACKER (applicant_id, position_applied, recruiter, cv, status, est_join_date, ptk_applied, pe_date, pe_status, pe_noted, pe_file, in_date, in_status, in_noted, in_file, ne_date, ne_status, ne_noted, ne_file, medic_date, medic_status, medic_noted, medic_file, doc_date, doc_status, doc_noted, doc_file, off_date, off_status, off_noted, off_file, created_date, created_by, modified_date, modified_by)
                VALUES (<cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#hdn_position_applied#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#hdn_recruiter#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#app_cv#" cfsqltype="cf_sql_varchar">, null,null,null, null,null,null,null, null,null,null,null, null,null,null,null, null,null,null,null, null,null,null,null, null,null,null,null, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">)
            </cfquery>

            <!--- Carrer Account --->
            <cfquery name="qInsert">
            INSERT INTO TCLMUSERAPP ()
            </cfquery>
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfuly Add Recruitment Tracking",true)>
            <cfoutput>
                <script>
                    alert("#SFLANG#");
                    parent.popClose();
                    parent.refreshPage();
                </script>
            </cfoutput>
        <cfelse>
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSFailed No. KTP already exists",true)>
            <cfoutput>
                <script>
                    alert("#SFLANG#");
                </script>
            </cfoutput>
        </cfif>
    </cffunction>
    <cffunction  name="Edit">
        <cfparam  name="applicant_id" default="">
        <cfparam  name="identity_no" default="">

        <!--- Validation Backend --->
        <cfif len(identityno) GT 1 AND len(identityno) LT 15>
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSFailed No. KTP no less then 16 characters",true)>
            <cfoutput>
                <script>
                    alert("#SFLANG#");
                </script>
            </cfoutput>
            <cfabort>
        </cfif>

        <cfquery name="LOCAL.qCheckCount" datasource="#REQUEST.SDSN#">
            SELECT APPLICANT_ID FROM TRCDAPPPERSONAL WHERE IDENTITY_NO = <cfqueryparam value="#identity_no#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif not qCheckCount.recordcount>
            <!--- Update Master Applicant Personal --->
            <cfparam  name="first_name" default="">
            <cfparam  name="middle_name" default="">
            <cfparam  name="last_name" default="">
            <cfparam  name="gender" default="">
            <cfparam  name="photo" default="">
            <cfparam  name="app_photo" default="">
            <cfparam  name="email" default="">
            <cfset full_name = first_name&" "&middle_name&" "&last_name>

            <!--- Upload Photo Applicant --->
            <cfif photo neq "">
                <cfif app_photo eq "">
                    <cfset var file_name = applicant_id&'_'&'APPLICANT_PHOTO' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_photo" FILEFIELD="photo" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset photo = dateFormat(now(), "yyyymm")&'/'&file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'APPLICANT_PHOTO' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_photo" filename="#app_photo#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_photo" FILEFIELD="photo" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset photo = "#dateFormat(now(), "yyyymm")#"&'/'&file_name_save />
                </cfif>
            <cfelse>
                <cfset photo = app_photo />
            </cfif>
            
            <cfquery name="qUpdateMasterAppPersonal" datasource="#REQUEST.SDSN#">
                UPDATE TRCMAPPPERSONAL
                SET FIRST_NAME = <cfqueryparam varchar="#first_name#" cfsqltype="cf_sql_varchar">,
                    MIDDLE_NAME = <cfqueryparam varchar="#middle_name#" cfsqltype="cf_sql_varchar">,
                    LAST_NAME = <cfqueryparam varchar="#last_name#" cfsqltype="cf_sql_varchar">,
                    GENDER = <cfqueryparam varchar="#gender#" cfsqltype="cf_sql_varchar">,
                    EMAIL = <cfqueryparam varchar="#email#" cfsqltype="cf_sql_varchar">,
                    PHOTO = <cfqueryparam varchar="#photo#" cfsqltype="cf_sql_varchar">,
                    FULL_NAME = <cfqueryparam varchar="#full_name#" cfsqltype="cf_sql_varchar">,
                    MODIFIED_DATE = <cfqueryparam varchar="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_varchar">,
                    MODIFIED_BY = <cfqueryparam varchar="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">
                WHERE APPLICANT_ID = <cfqueryparam varchar="#applicant_id#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <!--- Update Detail Applicant Personal --->
            <cfparam  name="phone" default="">

            <cfquery name="qUpdateDetailAppPersonal" datasource="#REQUEST.SDSN#">
                UPDATE TRCDAPPPERSONAL
                SET IDENTITY_NO = <cfqueryparam value="#identity_no#" cfsqltype="cf_sql_varchar">,
                    PHONE =<cfqueryparam value="#phone#" cfsqltype="cf_sql_varchar">,
                    MODIFIED_DATE = <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">,
                    MODIFIED_BY = <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">
                WHERE APPLICANT_ID = <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <!--- Update Detail Applicant Tracking --->
            <cfparam  name="hdn_position_applied" default="">
            <cfparam  name="hdn_recruiter" default="">
            <cfparam  name="cv" default="">
            <cfparam  name="app_status" default="">
            <cfparam  name="cal_est_join_date" default="">
            <cfif cal_est_join_date eq ''>
                <cfset cal_est_join_date = cal_est_join_date>
            <cfelse>
                <cfset cal_est_join_date = CreateODBCDateTime(cal_est_join_date)>
            </cfif>
            <cfparam  name="cal_pe_date" default="">
            <cfif cal_pe_date eq ''>
                <cfset cal_pe_date = cal_pe_date>
            <cfelse>
                <cfset cal_pe_date = CreateODBCDateTime(cal_pe_date)>
            </cfif>
            <cfparam  name="pe_status" default="">
            <cfparam  name="pe_noted" default="">
            <cfparam  name="pe_file" default="">
            <cfparam  name="app_pe_file" default="">
            <cfparam  name="cal_in_date" default="">
            <cfif cal_in_date eq ''>
                <cfset cal_in_date = cal_in_date>
            <cfelse>
                <cfset cal_in_date = CreateODBCDateTime(cal_in_date)>
            </cfif>
            <cfparam  name="in_status" default="">
            <cfparam  name="in_noted" default="">
            <cfparam  name="in_file" default="">
            <cfparam  name="app_in_file" default="">
            <cfparam  name="cal_ne_date" default="">
            <cfif cal_ne_date eq ''>
                <cfset cal_ne_date = cal_ne_date>
            <cfelse>
                <cfset cal_ne_date = CreateODBCDateTime(cal_ne_date)>
            </cfif>
            <cfparam  name="ne_status" default="">
            <cfparam  name="ne_noted" default="">
            <cfparam  name="ne_file" default="">
            <cfparam  name="app_ne_file" default="">
            <cfparam  name="cal_medic_date" default="">
            <cfif cal_medic_date eq ''>
                <cfset cal_medic_date = cal_medic_date>
            <cfelse>
                <cfset cal_medic_date = CreateODBCDateTime(cal_medic_date)>
            </cfif>
            <cfparam  name="medic_status" default="">
            <cfparam  name="medic_noted" default="">
            <cfparam  name="medic_file" default="">
            <cfparam  name="app_medic_file" default="">
            <cfparam  name="cal_doc_date" default="">
            <cfif cal_doc_date eq ''>
                <cfset cal_doc_date = cal_doc_date>
            <cfelse>
                <cfset cal_doc_date = CreateODBCDateTime(cal_doc_date)>
            </cfif>
            <cfparam  name="doc_status" default="">
            <cfparam  name="doc_noted" default="">
            <cfparam  name="doc_file" default="">
            <cfparam  name="app_doc_file" default="">
            <cfparam  name="cal_off_date" default="">
            <cfif cal_off_date eq ''>
                <cfset cal_off_date = cal_off_date>
            <cfelse>
                <cfset cal_off_date = CreateODBCDateTime(cal_off_date)>
            </cfif>
            <cfparam  name="off_status" default="">
            <cfparam  name="off_noted" default="">
            <cfparam  name="off_file" default="">
            <cfparam  name="app_off_file" default="">

            <!--- Upload CV Applicant --->
            <cfif cv neq "">
                <cfif app_cv eq "">
                    <cfset var file_name = applicant_id&'_'&'APPLICANT_CV' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="cv" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset cv = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'APPLICANT_CV' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_cv#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="cv" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset cv = file_name_save />
                </cfif>
            <cfelse>	
                <cfset cv = app_cv />
            </cfif>

            <!--- Upload Per-Eliminary --->
            <cfif pe_file neq "">
                <cfif app_pe_file eq "">
                    <cfset var file_name = applicant_id&'_'&'PERELIMINARY' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="pe_file" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset pe_file = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'PERELIMINARY' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_pe_file#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="pe_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset pe_file = file_name_save />
                </cfif>
            <cfelse>	
                <cfset pe_file = app_pe_file />
            </cfif>
            
            <!--- Upload Interview --->
            <cfif in_file neq "">
                <cfif app_in_file eq "">
                    <cfset var file_name = applicant_id&'_'&'INTERVIEW' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="in_file" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset in_file = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'INTERVIEW' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_in_file#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="in_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset in_file = file_name_save />
                </cfif>
            <cfelse>	
                <cfset in_file = app_in_file />
            </cfif>

            <!--- Upload Nego --->
            <cfif ne_file neq "">
                <cfif app_ne_file eq "">
                    <cfset var file_name = applicant_id&'_'&'NEGO' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="ne_file" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset ne_file = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'NEGO' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_ne_file#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="ne_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset ne_file = file_name_save />
                </cfif>
            <cfelse>	
                <cfset ne_file = app_ne_file />
            </cfif>

            <!--- Upload Medical Check Up --->
            <cfif medic_file neq "">
                <cfif app_medic_file eq "">
                    <cfset var file_name = applicant_id&'_'&'MEDICALCHECKUP' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="medic_file" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset medic_file = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'MEDICALCHECKUP' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_medic_file#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="medic_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset medic_file = file_name_save />
                </cfif>
            <cfelse>	
                <cfset medic_file = app_medic_file />
            </cfif>
            
            <!--- Upload Document Approval --->
            <cfif doc_file neq "">
                <cfif app_doc_file eq "">
                    <cfset var file_name = applicant_id&'_'&'DOCUMENTAPPROVAL' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="doc_file" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset doc_file = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'DOCUMENTAPPROVAL' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_doc_file#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="doc_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset doc_file = file_name_save />
                </cfif>
            <cfelse>	
                <cfset doc_file = app_doc_file />
            </cfif>

            <!--- Upload Offering/SPK --->
            <cfif off_file neq "">
                <cfif app_off_file eq "">
                    <cfset var file_name = applicant_id&'_'&'OFFERING' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="off_file" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset off_file = file_name_save />
                <cfelse>
                    <cfset var file_name = applicant_id&'_'&'OFFERING' />
                    <CF_SFUPLOAD ACTION="DELETE" CODE="apptracking_pdf" filename="#app_off_file#">
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="apptracking_pdf" FILEFIELD="off_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset off_file = file_name_save />
                </cfif>
            <cfelse>	
                <cfset off_file = app_off_file />
            </cfif>
            
            <cfquery>
                UPDATE TRCDAPPTRACKER
                SET POSITION_APPLIED = <cfqueryparam value="#hdn_position_applied#" cfsqltype="cf_sql_varchar">,
                    RECRUITER = <cfqueryparam value="#hdn_recruiter#" cfsqltype="cf_sql_varchar">,
                    CV = <cfqueryparam value="#cv#" cfsqltype="cf_sql_varchar">,
                    STATUS = <cfqueryparam value="#app_status#" cfsqltype="cf_sql_varchar">,
                    EST_JOIN_DATE = <cfqueryparam value="#cal_est_join_date#" cfsqltype="cf_sql_timestamp">,
                    PE_DATE = <cfqueryparam value="#cal_pe_date#" cfsqltype="cf_sql_timestamp">,
                    PE_STATUS = <cfqueryparam value="#pe_status#" cfsqltype="cf_sql_varchar">,
                    PE_NOTED = <cfqueryparam value="#pe_noted#" cfsqltype="cf_sql_varchar">,
                    PE_FILE = <cfqueryparam value="#pe_file#" cfsqltype="cf_sql_varchar">,
                    IN_DATE = <cfqueryparam value="#cal_in_date#" cfsqltype="cf_sql_timestamp">,
                    IN_STATUS = <cfqueryparam value="#in_status#" cfsqltype="cf_sql_varchar">,
                    IN_NOTED = <cfqueryparam value="#in_noted#" cfsqltype="cf_sql_varchar">,
                    IN_FILE = <cfqueryparam value="#in_file#" cfsqltype="cf_sql_varchar">,
                    NE_DATE = <cfqueryparam value="#cal_ne_date#" cfsqltype="cf_sql_timestamp">,
                    NE_STATUS = <cfqueryparam value="#ne_status#" cfsqltype="cf_sql_varchar">,
                    NE_NOTED = <cfqueryparam value="#ne_noted#" cfsqltype="cf_sql_varchar">,
                    NE_FILE = <cfqueryparam value="#ne_file#" cfsqltype="cf_sql_varchar">,
                    MEDIC_DATE = <cfqueryparam value="#cal_medic_date#" cfsqltype="cf_sql_timestamp">,
                    MEDIC_STATUS = <cfqueryparam value="#medic_status#" cfsqltype="cf_sql_varchar">,
                    MEDIC_NOTED = <cfqueryparam value="#medic_noted#" cfsqltype="cf_sql_varchar">,
                    MEDIC_FILE = <cfqueryparam value="#medic_file#" cfsqltype="cf_sql_varchar">,
                    DOC_DATE = <cfqueryparam value="#cal_doc_date#" cfsqltype="cf_sql_timestamp">,
                    DOC_STATUS = <cfqueryparam value="#doc_status#" cfsqltype="cf_sql_varchar">,
                    DOC_NOTED = <cfqueryparam value="#doc_noted#" cfsqltype="cf_sql_varchar">,
                    DOC_FILE = <cfqueryparam value="#doc_file#" cfsqltype="cf_sql_varchar">,
                    OFF_DATE = <cfqueryparam value="#cal_off_date#" cfsqltype="cf_sql_timestamp">,
                    OFF_STATUS = <cfqueryparam value="#off_status#" cfsqltype="cf_sql_varchar">,
                    OFF_NOTED = <cfqueryparam value="#off_noted#" cfsqltype="cf_sql_varchar">,
                    OFF_FILE = <cfqueryparam value="#off_file#" cfsqltype="cf_sql_varchar">,

            </cfquery>
        </cfif>
    </cffunction>
    <!--- End Main --->
</cfcomponent>