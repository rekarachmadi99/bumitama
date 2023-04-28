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

            <!--- Add File Extension For Applicant Photo And CV --->
            <cffunction name="extLeave">
                <cfquery name="local.qExtAppPhoto" datasource="#REQUEST.SDSN#">
                    SELECT EXT_LIST FROM TSFMUPLOADSETTING WHERE UPLOAD_CODE = 'applicant_photo'
                </cfquery>
                
                <cfquery name="local.qExtAppCV" datasource="#REQUEST.SDSN#">
                    SELECT EXT_LIST FROM TSFMUPLOADSETTING WHERE UPLOAD_CODE = 'apptracking_pdf'
                </cfquery>
                
                <cfset strckData['extapp_photo'] = qExtAppPhoto.ext_list>
                <cfset strckData['extapp_cv'] = qExtAppCV.ext_list>
                <cfset strckData["status"] = 0>
                <cfset strckData["recordcount"] = 1>
                <cfreturn strckData>
            </cffunction>
            <!--- Edit --->
            <cffunction name="viewEditTracking">
                <cfquery name="local.qMAppPersonal" datasource="#REQUEST.SDSN#">
                    SELECT applicant_id, first_name, middle_name, last_name, gender, email, photo FROM TRCMAPPPERSONAL WHERE applicant_id = <cfqueryparam value="#URL.applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>
                
                <cfquery name="local.qDAppPersonal" datasource="#REQUEST.SDSN#">
                    SELECT applicant_id, phone, identity_no FROM TRCDAPPPERSONAL WHERE applicant_id = <cfqueryparam value="#URL.applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>

                <cfquery name="local.qDAppTracker" datasource="#REQUEST.SDSN#">
                    SELECT applicant_id, cv, position_applied, recruiter, status, est_join_date, ptk_applied, 
                    pe_date, pe_status, pe_noted, pe_file,
                    in_date, in_status, in_noted, in_file,
                    ne_date, ne_status, ne_noted, ne_file,
                    medic_date, medic_status, medic_noted, medic_file,
                    doc_date, doc_status, doc_noted, doc_file,
                    off_date, off_status, off_noted, off_file
                    FROM TRCDAPPTRACKER WHERE applicant_id = <cfqueryparam value="#URL.applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>

                <cfquery name="local.qExtAppPhoto" datasource="#REQUEST.SDSN#">
                    SELECT ext_list FROM TSFMUPLOADSETTING WHERE upload_code = 'applicant_photo'
                </cfquery>
                
                <cfquery name="local.qExtAppCV" datasource="#REQUEST.SDSN#">
                    SELECT ext_list FROM TSFMUPLOADSETTING WHERE upload_code = 'apptracking_pdf'
                </cfquery>
                <!--- Master Applicant Personal --->
                <cfset strckData['applicant_id'] = qMAppPersonal.applicant_id>
                <cfset strckData['first_name'] = qMAppPersonal.first_name>
                <cfset strckData['middle_name'] = qMAppPersonal.middle_name>
                <cfset strckData['last_name'] = qMAppPersonal.last_name>
                <cfset strckData['gender'] = qMAppPersonal.gender>
                <cfset strckData['email'] = qMAppPersonal.email>
                <cfset strckData['photo'] = qMAppPersonal.photo>

                <!--- Detail Applicant Personal --->
                <cfset strckData['phone'] = qDAppPersonal.phone>
                <cfset strckData['identityno'] = qDAppPersonal.identity_no>

                <!--- Detail Applicant Tracker --->
                <cfset strckData['cv'] = qDAppTracker.cv>
                <cfset strckData['position_applied'] = qDAppTracker.position_applied>
                <cfset strckData['recruiter'] = qDAppTracker.recruiter>
                <cfset strckData['status_app'] = qDAppTracker.status>
                <cfset strckData['est_join_date'] = qDAppTracker.est_join_date>
                <cfset strckData['pe_date'] = qDAppTracker.pe_date>
                <cfset strckData['pe_status'] = qDAppTracker.pe_status>
                <cfset strckData['pe_noted'] = qDAppTracker.pe_noted>
                <cfset strckData['pe_file'] = qDAppTracker.pe_file>
                <cfset strckData['in_date'] = qDAppTracker.in_date>
                <cfset strckData['in_status'] = qDAppTracker.in_status>
                <cfset strckData['in_noted'] = qDAppTracker.in_noted>
                <cfset strckData['in_file'] = qDAppTracker.in_file>
                <cfset strckData['ne_date'] = qDAppTracker.ne_date>
                <cfset strckData['ne_status'] = qDAppTracker.ne_status>
                <cfset strckData['ne_noted'] = qDAppTracker.ne_noted>
                <cfset strckData['ne_file'] = qDAppTracker.ne_file>
                <cfset strckData['medic_date'] = qDAppTracker.medic_date>
                <cfset strckData['medic_status'] = qDAppTracker.medic_status>
                <cfset strckData['medic_noted'] = qDAppTracker.medic_noted>
                <cfset strckData['medic_file'] = qDAppTracker.medic_file>
                <cfset strckData['doc_date'] = qDAppTracker.doc_date>
                <cfset strckData['doc_status'] = qDAppTracker.doc_status>
                <cfset strckData['doc_noted'] = qDAppTracker.doc_noted>
                <cfset strckData['doc_file'] = qDAppTracker.doc_file>
                <cfset strckData['off_date'] = qDAppTracker.off_date>
                <cfset strckData['off_status'] = qDAppTracker.off_status>
                <cfset strckData['off_noted'] = qDAppTracker.off_noted>
                <cfset strckData['off_file'] = qDAppTracker.off_file>

                <!--- Descrip --->
                <cfset strckData['extapp_photo'] = qExtAppPhoto.ext_list>
                <cfset strckData['extapp_cv'] = qExtAppCV.ext_list>
                <cfset strckData['extpe_file'] = qExtAppCV.ext_list>
                <cfset strckData['extin_file'] = qExtAppCV.ext_list>
                <cfset strckData['extne_file'] = qExtAppCV.ext_list>
                <cfset strckData['extmedic_file'] = qExtAppCV.ext_list>
                <cfset strckData['extdoc_file'] = qExtAppCV.ext_list>
                <cfset strckData['extoff_file'] = qExtAppCV.ext_list>
                <cfset strckData["status"] = 0>
                <cfset strckData["recordcount"] = 1>

                <cfreturn strckData>
            </cffunction>
            
            <!--- Select Option --->
            <cffunction  name="getStatus">
                <cfquery name="LOCAl.qStatus" datasource="#REQUEST.SDSN#">
                    SELECT code optvalue, name_#REQUEST.SCOOKIE.LANG# opttext 
                    FROM TRCDAPPSTATUSREC
                </cfquery>
                <cfreturn qStatus>
            </cffunction>

            <!--- Filter Position --->
            <cffunction name="filterPosition">
                <cfparam name="search" default="">
                <cfparam name="getval" default="id">
                <cfparam name="autopick" default="">
                <cfset LOCAL.searchText=trim(search)>
                <cfset LOCAL.valfield=IIF(getval eq "id","'nval'","'ntitle'")>
                <cfquery name="LOCAL.qcatcode" datasource="#REQUEST.SDSN#">
                    SELECT REQUEST_NO, REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG# FROM TRCMRECRUITREQ A INNER JOIN TEOMEMPPERSONAL B ON A.RECRUITER = B.EMP_ID
                    WHERE REQUEST_NO = <cfqueryparam value="#searchText#" cfsqltype="CF_SQL_VARCHAR">
                </cfquery>
                
                <cfquery name="LOCAL.qLookUp" datasource="#REQUEST.SDSN#">
                        SELECT REQUEST_NO nval, REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG# ntitle FROM TRCMRECRUITREQ A INNER JOIN TEOMEMPPERSONAL B ON A.RECRUITER = B.EMP_ID
                        
                        <cfif searchText neq "???">
                            <cfif qcatcode.recordcount neq 0>
                                <cfif LEN(autopick)>
                                    WHERE REQUEST_NO = <cfqueryparam value="#searchText#" cfsqltype="CF_SQL_VARCHAR">
                                <cfelse>
                                    WHERE  REQUEST_NO LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                                </cfif>
                            <cfelse>
                                WHERE (#Application.SFUtil.DBConcat(["REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG#","[","RECRUITER","]"])# LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                                OR REQUEST_NO LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">)
                            </cfif>
                        </cfif>
                        ORDER BY ntitle
                </cfquery>
                
                <cfset LOCAL.jsfunc="function () { loadsuggest(); try { srcApp(); } catch(err) {} }"> <!--- // runTriggerCategory(); BUG51017-84318 --->
                <cfset Application.SFLookUp.tipLookUp(qLookup,"Position",valfield,"nval","ntitle",false,searchText,jsfunc)>
            </cffunction>

            <!--- Filter Recruter --->
            <cffunction name="filterRecruiter">
                <cfparam name="search" default="">
                <cfparam name="getval" default="id">
                <cfparam name="autopick" default="">
                <cfset LOCAL.searchText=trim(search)>
                <cfset LOCAL.valfield=IIF(getval eq "id","'nval'","'ntitle'")>
                <cfquery name="LOCAL.qcatcode" datasource="#REQUEST.SDSN#">
                    SELECT EMP_ID, FULL_NAME FROM TRCMRECRUITREQ A INNER JOIN TEOMEMPPERSONAL B ON A.RECRUITER = B.EMP_ID
                    WHERE REQUEST_NO = <cfqueryparam value="#searchText#" cfsqltype="CF_SQL_VARCHAR">
                </cfquery>
                
                <cfquery name="LOCAL.qLookUp" datasource="#REQUEST.SDSN#">
                        SELECT EMP_ID nval, FULL_NAME ntitle FROM  TRCMRECRUITREQ  A INNER JOIN TEOMEMPPERSONAL B ON A.RECRUITER = B.EMP_ID
                        <cfif searchText neq "???">
                            <cfif qcatcode.recordcount neq 0>
                                <cfif LEN(autopick)>
                                    WHERE EMP_ID = <cfqueryparam value="#searchText#" cfsqltype="CF_SQL_VARCHAR">
                                <cfelse>
                                    WHERE  EMP_ID LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                                </cfif>
                            <cfelse>
                                WHERE (#Application.SFUtil.DBConcat(["FULL_NAME","' ['","EMP_ID","']'"])# LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                                OR EMP_ID LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">)
                            </cfif>
                        </cfif>
                        ORDER BY ntitle
                </cfquery>
                
                <cfset LOCAL.jsfunc="function () { loadsuggest(); try { srcApp(); } catch(err) {} }"> <!--- // runTriggerCategory(); BUG51017-84318 --->
                <cfset Application.SFLookUp.tipLookUp(qLookup,"Position",valfield,"nval","ntitle",false,searchText,jsfunc)>
            </cffunction>

            <!--- Filter Status --->
            <cffunction name="filterStatus">
                <cfparam name="search" default="">
                <cfparam name="getval" default="id">
                <cfparam name="autopick" default="">
                <cfset LOCAL.searchText=trim(search)>
                <cfset LOCAL.valfield=IIF(getval eq "id","'nval'","'ntitle'")>
                <cfquery name="LOCAL.qcatcode" datasource="#REQUEST.SDSN#">
                    SELECT CODE, NAME_#REQUEST.SCOOKIE.LANG# FROM TRCDSTATUSTRACKER
                    WHERE CODE = <cfqueryparam value="#searchText#" cfsqltype="CF_SQL_VARCHAR">
                </cfquery>
                
                <cfquery name="LOCAL.qLookUp" datasource="#REQUEST.SDSN#">
                        SELECT CODE nval, NAME_#REQUEST.SCOOKIE.LANG# ntitle FROM TRCDSTATUSTRACKER
                        <cfif searchText neq "???">
                            <cfif qcatcode.recordcount neq 0>
                                <cfif LEN(autopick)>
                                    WHERE CODE = <cfqueryparam value="#searchText#" cfsqltype="CF_SQL_VARCHAR">
                                <cfelse>
                                    WHERE  CODE LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                                </cfif>
                            <cfelse>
                                WHERE (#Application.SFUtil.DBConcat(["NAME_#REQUEST.SCOOKIE.LANG# ","' ['","CODE","']'"])# LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">
                                OR CODE LIKE <cfqueryparam value="%#searchText#%" cfsqltype="CF_SQL_VARCHAR">)
                            </cfif>
                        </cfif>
                        ORDER BY ntitle
                </cfquery>
                
                <cfset LOCAL.jsfunc="function () { loadsuggest(); try { srcApp(); } catch(err) {} }"> <!--- // runTriggerCategory(); BUG51017-84318 --->
                <cfset Application.SFLookUp.tipLookUp(qLookup,"Status",valfield,"nval","ntitle",false,searchText,jsfunc)>
            </cffunction>

            <cffunction name="Listing">
                <!--- Passing Parameter --->
                <cfset LOCAL.scParam=paramRequest()>
                <!--- Query Field Definition ---> 
                <cfset LOCAL.lsField="A.APPLICANT_ID, A.PHOTO, C.PE_FILE,
                DATE_FORMAT(A.CREATED_DATE,'%d %M %Y') AS REGISTER_DATE, 
                CONCAT(A.FIRST_NAME,' ', A.MIDDLE_NAME,' ',A.LAST_NAME) AS APPLICANT_NAME, 
                E.REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG# AS POSITION, 
                D.FULL_NAME AS RECRUITER, 
                B.PHONE AS PHONE,
                A.EMAIL AS EMAIL,
                C.CV AS CV, 
                CASE WHEN C.PE_DATE IS NOT NULL AND C.PE_STATUS IS NOT NULL AND C.PE_NOTED IS NOT NULL AND C.PE_FILE IS NOT NULL THEN 'Pre-Eliminary' 
                    WHEN C.IN_DATE IS NOT NULL AND C.IN_STATUS IS NOT NULL AND C.IN_NOTED IS NOT NULL AND C.IN_FILE IS NOT NULL THEN 'Interview' 
                    WHEN C.NE_DATE IS NOT NULL AND C.NE_STATUS IS NOT NULL AND C.NE_NOTED IS NOT NULL AND C.NE_FILE IS NOT NULL THEN 'Negosiasi' 
                    WHEN C.MEDIC_DATE IS NOT NULL AND C.MEDIC_STATUS IS NOT NULL AND C.MEDIC_NOTED IS NOT NULL AND C.MEDIC_FILE IS NOT NULL THEN 'Medical Check Up' 
                    WHEN C.DOC_DATE IS NOT NULL AND C.DOC_STATUS IS NOT NULL AND C.DOC_NOTED IS NOT NULL AND C.DOC_FILE IS NOT NULL THEN 'Document Approval' 
                    WHEN C.OFF_DATE IS NOT NULL AND C.OFF_STATUS IS NOT NULL AND C.OFF_NOTED IS NOT NULL AND C.OFF_FILE IS NOT NULL THEN 'Offering/SPK' END AS LAST_PROGRESS,
                CONCAT(C.STATUS,' [',DATE_FORMAT(C.EST_JOIN_DATE,'%d %M %Y'),'] ') AS STATUS, 
                CASE WHEN C.PE_DATE IS NOT NULL THEN DATE_FORMAT(C.PE_DATE,'%d %M %Y') 
                    WHEN C.IN_DATE IS NOT NULL THEN DATE_FORMAT(C.IN_DATE,'%d %M %Y') 
                    WHEN C.NE_DATE IS NOT NULL THEN DATE_FORMAT(C.NE_DATE,'%d %M %Y')
                    WHEN C.MEDIC_DATE IS NOT NULL THEN DATE_FORMAT(C.MEDIC_DATE,'%d %M %Y')
                    WHEN C.DOC_DATE IS NOT NULL THEN DATE_FORMAT(C.DOC_DATE,'%d %M %Y') 
                    WHEN C.OFF_DATE IS NOT NULL THEN DATE_FORMAT(C.OFF_DATE,'%d %M %Y') END AS LAST_PROGRESS_DATE,
                CONCAT('[APPLY]',' - ',E.REQUEST_NO,'(',E.REQUEST_POSNAME_#REQUEST.SCOOKIE.LANG#,')') AS APPLICANT_APPLY,
                CASE WHEN C.PE_DATE IS NOT NULL AND C.PE_STATUS IS NOT NULL AND C.PE_NOTED IS NOT NULL AND C.PE_FILE IS NOT NULL THEN CONCAT('[LINK]',' - ',C.PE_NOTED) END AS PER_ELIMINARY,
                CASE WHEN C.IN_DATE IS NOT NULL AND C.IN_STATUS IS NOT NULL AND C.IN_NOTED IS NOT NULL AND C.IN_FILE IS NOT NULL THEN CONCAT('[LINK]',' - ',C.IN_NOTED) END AS INTERVIEW,
                CASE WHEN C.NE_DATE IS NOT NULL AND C.NE_STATUS IS NOT NULL AND C.NE_NOTED IS NOT NULL AND C.NE_FILE IS NOT NULL THEN CONCAT('[LINK]',' - ',C.NE_NOTED) END AS NEGO,
                CASE WHEN C.MEDIC_DATE IS NOT NULL AND C.MEDIC_STATUS IS NOT NULL AND C.MEDIC_NOTED IS NOT NULL AND C.MEDIC_FILE IS NOT NULL THEN CONCAT('[LINK]',' - ',C.MEDIC_NOTED) END AS MEDICAL_CHECKUP,
                CASE WHEN C.DOC_DATE IS NOT NULL AND C.DOC_STATUS IS NOT NULL AND C.DOC_NOTED IS NOT NULL AND C.DOC_FILE IS NOT NULL THEN CONCAT('[LINK]',' - ',C.DOC_NOTED) END AS DOCUMENT_APPROVAL,
                CASE WHEN C.OFF_DATE IS NOT NULL AND C.OFF_STATUS IS NOT NULL AND C.OFF_NOTED IS NOT NULL AND C.OFF_FILE IS NOT NULL THEN CONCAT('[LINK]',' - ',C.OFF_NOTED) END AS OFFERING">
                <!--- Table Join Definition --->
                <cfset LOCAL.lsTable="  TRCMAPPPERSONAL A INNER JOIN TRCDAPPPERSONAL B ON A.APPLICANT_ID = B.APPLICANT_ID 
                                        INNER JOIN TRCDAPPTRACKER C ON C.APPLICANT_ID = A.APPLICANT_ID 
                                        INNER JOIN TEOMEMPPERSONAL D ON C.RECRUITER = D.EMP_ID 
                                        INNER JOIN TRCMRECRUITREQ E ON C.POSITION_APPLIED = E.REQUEST_NO">
                <cfset ListingData(scParam,{lsField=lsField,lsField=lsField,lsTable=lsTable,pid=""})>
            </cffunction>
            
            <cffunction  name="Add">
                <!--- Value --->
                <cfparam  name="first_name" default="">
                <cfparam  name="middle_name" default="">
                <cfparam  name="last_name" default="">
                <cfparam  name="gender" default="">
                <cfparam  name="phone" default="">
                <cfparam  name="photo" default="">
                <cfparam  name="email" default="">
                <cfparam  name="identityno" default="">
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
                <!--- End Validation --->
                
                <!--- Tambah File --->
                <!--- Applicant Photo --->
                <cfif photo neq "">
                    <cfset var file_name = applicant_id&'_'&'APP_PHOTO' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="appphoto" FILEFIELD="photo" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset app_photo = dateFormat(now(), "yyyymm")&'/'&file_name_save />
                <cfelse>	
                    <cfset app_photo = '' />
                </cfif>
                
                <!--- CV --->
                <cfif cv neq "">
                    <cfset var file_name = applicant_id&'_'&'APP_CV' />
                    <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="cv" REWRITE="" RENAME="#file_name#" output="vTest">
                    <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                    <cfset app_cv = file_name_save />
                <cfelse>	
                    <cfset app_cv = '' />
                </cfif>
                <!--- End Tambah File --->

                <cfquery name="qCheckCount" datasource="#REQUEST.SDSN#">
                    SELECT identity_no FROM TRCDAPPPERSONAL WHERE identity_no = <cfqueryparam value="#identityno#" cfsqltype="cf_sql_varchar">
                </cfquery>
                
                <cfif qCheckCount.identity_no eq ''>
                    <cfquery name="qInsertApplicant" datasource="#REQUEST.SDSN#">
                        INSERT INTO TRCMAPPPERSONAL(
                            applicant_id, company_code, 
                            first_name, middle_name, last_name, 
                            gender, user_id, taxno, email,
                            photo,
                            geocoord, status, req_status, lastreqno,
                            created_date, created_by, modified_date, modified_by, 
                            official_name, initial_name, app_image, app_signature, 
                            full_name, applicant_sts, src_online, security_code, 
                            accept_online, job_exp, app_region, 
                            jobcategory_code, gradecategory_code, inactive_reason
                        )VALUES(
                            <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#company_code#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#first_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#middle_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#last_name#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#gender#" cfsqltype="cf_sql_varchar">, null, '', <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#app_photo#" cfsqltype="cf_sql_varchar">,
                            null, 1, 0, null,
                            <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">,
                            null, null, null, null, 
                            <cfqueryparam value="#full_name#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#applicant_sts#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#src_online#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#security_code#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#accept_online#" cfsqltype="cf_sql_varchar">, 0, null,
                            null, null, null
                        )
                    </cfquery>
                    <cfquery name="qInsertDetailApplicant" datasource="#REQUEST.SDSN#">
                        INSERT INTO TRCDAPPPERSONAL(
                            applicant_id, birthplace, birthdate, nationality_code,
                            religion_code, race_code, identity_no, identity_expdate,
                            salutation_code, dialect_code, maritalstatus, married_date, married_place,
                            phone, edutitle1, edutitle2, gmt_id,
                            created_date, created_by, modified_date, modified_by,
                            app_rumpun, is_employee, exp_jdate
                        )VALUES(
                            <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">, null, null, null,
                            null, null, <cfqueryparam value="#identityno#" cfsqltype="cf_sql_varchar">, null,
                            null, null, 0, null, null,
                            <cfqueryparam value="#phone#" cfsqltype="cf_sql_varchar">, null, null, null,
                            <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">,
                            null, 0, null
                        )
                    </cfquery>
                    <cfquery name="qInsertApplicantTracker" datasource="#REQUEST.SDSN#">
                        INSERT INTO TRCDAPPTRACKER(
                            applicant_id, position_applied, recruiter, cv,
                            status, est_join_date, ptk_applied,
                            pe_date, pe_status, pe_noted, pe_file,
                            in_date, in_status, in_noted, in_file,
                            ne_date, ne_status, ne_noted, ne_file,
                            medic_date, medic_status, medic_noted, medic_file,
                            doc_date, doc_status, doc_noted, doc_file,
                            off_date, off_status, off_noted, off_file,
                            created_date, created_by, modified_date, modified_by
                        )VALUES(
                            <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#hdn_position_applied#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#hdn_recruiter#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#app_cv#" cfsqltype="cf_sql_varchar">,
                            null,null,null,
                            null,null,null,null,
                            null,null,null,null,
                            null,null,null,null,
                            null,null,null,null,
                            null,null,null,null,
                            null,null,null,null,
                            <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">, <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">                    
                        )
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

            <cffunction name="Edit">
                <!--- Value --->
                <cfparam  name="applicant_id" default="">
                <cfparam  name="first_name" default="">
                <cfparam  name="middle_name" default="">
                <cfparam  name="last_name" default="">
                <cfparam  name="gender" default="">
                <cfparam  name="phone" default="">
                <cfparam  name="email" default="">
                <cfparam  name="identityno" default="">
                <cfparam  name="photo" default="">
                <cfparam  name="cv" default="">
                <cfparam  name="hdn_position_applied" default="">
                <cfparam  name="hdn_recruiter" default="">
                <cfparam  name="hdn_status" default="">
                <cfparam  name="cal_est_join_date" default="">
                <cfif cal_est_join_date eq ''>
                    <cfset cal_est_join_date = cal_est_join_date>
                <cfelse>
                    <cfset cal_est_join_date = CreateODBCDateTime(cal_est_join_date)>
                </cfif>
                <cfparam  name="ptk_applied" default="">
                <cfparam  name="cal_pe_date" default="">
                <cfparam  name="pe_status" default="">
                <cfparam  name="pe_noted" default="">
                <cfparam  name="pe_file" default="">
                <cfif cal_pe_date eq ''>
                    <cfset cal_pe_date = cal_pe_date>
                <cfelse>
                    <cfset cal_pe_date = CreateODBCDateTime(cal_pe_date)>
                </cfif>
                <cfparam  name="cal_in_date" default="">
                <cfparam  name="in_status" default="">
                <cfparam  name="in_noted" default="">
                <cfparam  name="in_file" default="">
                <cfif cal_in_date eq ''>
                    <cfset cal_in_date = cal_in_date>
                <cfelse>
                    <cfset cal_in_date = CreateODBCDateTime(cal_in_date)>
                </cfif>
                <cfparam  name="cal_ne_date" default="">
                <cfparam  name="ne_status" default="">
                <cfparam  name="ne_noted" default="">
                <cfparam  name="ne_file" default="">
                <cfif cal_ne_date eq ''>
                    <cfset cal_ne_date = cal_ne_date>
                <cfelse>
                    <cfset cal_ne_date = CreateODBCDateTime(cal_ne_date)>
                </cfif>
                
                <cfparam  name="cal_medic_date" default="">
                <cfparam  name="medic_status" default="">
                <cfparam  name="medic_noted" default="">
                <cfparam  name="medic_file" default="">
                <cfif cal_medic_date eq ''>
                    <cfset cal_medic_date = cal_medic_date>
                <cfelse>
                    <cfset cal_medic_date = CreateODBCDateTime(cal_medic_date)>
                </cfif>
                
                <cfparam  name="cal_doc_date" default="">
                <cfparam  name="doc_status" default="">
                <cfparam  name="doc_noted" default="">
                <cfparam  name="doc_file" default="">
                <cfif cal_doc_date eq ''>
                    <cfset cal_doc_date = cal_doc_date>
                <cfelse>
                    <cfset cal_doc_date = CreateODBCDateTime(cal_doc_date)>
                </cfif>

                <cfparam  name="cal_off_date" default="">
                <cfparam  name="off_status" default="">
                <cfparam  name="off_noted" default="">
                <cfparam  name="off_file" default="">
                <cfif cal_off_date eq ''>
                    <cfset cal_off_date = cal_off_date>
                <cfelse>
                    <cfset cal_off_date = CreateODBCDateTime(cal_off_date)>
                </cfif>
                <cfset applicant_id = applicant_id>
                <cfset full_name = first_name &" "& middle_name &" "& last_name>
                <!--- Upload File --->
                
                <cfquery name="LOCAL.qCheckDateUp" datasource="#REQUEST.SDSN#">
                    SELECT  created_date FROM TRCMAPPPERSONAL WHERE APPLICANT_ID = <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <!--- Applicant Photo --->
                <cfif photo neq "">
                    <cfif app_photo eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_PHOTO' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appphoto" FILEFIELD="photo" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset photo = dateFormat(now(), "yyyymm")&'/'&file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_PHOTO' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appphoto" filename="#app_photo#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appphoto" FILEFIELD="photo" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset photo = "#dateFormat(now(), "yyyymm")#"&'/'&file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset photo = app_photo />
                </cfif>

                <!--- Applicant CV --->
                <cfif cv neq "">
                    <cfif app_cv eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_CV' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="cv" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset cv = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_CV' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_cv#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="cv" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset cv = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset cv = app_cv />
                </cfif>

                <!--- Per-Eliminary --->
                <cfif pe_file neq "">
                    <cfif app_pe_file eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_PERELIMINARY' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="pe_file" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset pe_file = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_PERELIMINARY' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_pe_file#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="pe_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset pe_file = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset pe_file = app_pe_file />
                </cfif>
                
                <!--- Interview --->
                <cfif in_file neq "">
                    <cfif app_in_file eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_INTERVIEW' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="in_file" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset in_file = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_INTERVIEW' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_in_file#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="in_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset in_file = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset in_file = app_in_file />
                </cfif>

                <!--- Nego --->
                <cfif ne_file neq "">
                    <cfif app_ne_file eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_NEGO' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="ne_file" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset ne_file = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_NEGO' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_ne_file#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="ne_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset ne_file = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset ne_file = app_ne_file />
                </cfif>

                <!--- Medical Check Up --->
                <cfif medic_file neq "">
                    <cfif app_medic_file eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_MEDICALCHECKUP' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="medic_file" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset medic_file = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_MEDICALCHECKUP' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_medic_file#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="medic_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset medic_file = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset medic_file = app_medic_file />
                </cfif>
                
                <!--- Document Approval --->
                <cfif doc_file neq "">
                    <cfif app_doc_file eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_DOCUMENTAPPROVAL' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="doc_file" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset doc_file = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_DOCUMENTAPPROVAL' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_doc_file#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="doc_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset doc_file = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset doc_file = app_doc_file />
                </cfif>

                <!--- Offering/SPK --->
                <cfif off_file neq "">
                    <cfif app_off_file eq "">
                        <cfset var file_name = applicant_id&'_'&'APP_OFFERING' />
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="off_file" REWRITE="" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset off_file = file_name_save />
                    <cfelse>
                        <cfset var file_name = applicant_id&'_'&'APP_OFFERING' />
                        <CF_SFUPLOAD ACTION="DELETE" CODE="appcvattach" filename="#app_off_file#">
                        <CF_SFUPLOAD ACTION="UPLOAD" CODE="appcvattach" FILEFIELD="off_file" REWRITE="YES" RENAME="#file_name#" output="vTest">
                        <cfset var file_name_save = #file_name#&'.'&#vTest.clientFileExt#/>
                        <cfset off_file = file_name_save />
                    </cfif>
                <cfelse>	
                    <cfset off_file = app_off_file />
                </cfif>
                <!--- End Upload File --->
                <cfquery name="qUpdateMasterApplicantPersonal" datasource="#REQUEST.SDSN#">
                    UPDATE TRCMAPPPERSONAL
                    SET first_name = <cfqueryparam value="#first_name#" cfsqltype="cf_sql_varchar">,
                        middle_name = <cfqueryparam value="#middle_name#" cfsqltype="cf_sql_varchar">,
                        last_name = <cfqueryparam value="#last_name#" cfsqltype="cf_sql_varchar">,
                        gender = <cfqueryparam value="#gender#" cfsqltype="cf_sql_varchar">,
                        email = <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">,
                        photo = <cfqueryparam value="#photo#" cfsqltype="cf_sql_varchar">,
                        full_name = <cfqueryparam value="#full_name#" cfsqltype="cf_sql_varchar">,
                        modified_date = <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">,
                        modified_by = <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">
                    WHERE APPLICANT_ID = <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>

                <cfquery name="qUpdateDetailApplicantPersonal" datasource="#REQUEST.SDSN#">
                    UPDATE TRCDAPPPERSONAL
                    SET identity_no = <cfqueryparam value="#identityno#" cfsqltype="cf_sql_varchar">,
                        phone = <cfqueryparam value="#phone#" cfsqltype="cf_sql_varchar">,
                        modified_date = <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">,
                        modified_by = <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">
                    WHERE APPLICANT_ID = <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>

                <cfquery name="qUpdateApplicantTracker" datasource="#REQUEST.SDSN#">
                    UPDATE TRCDAPPTRACKER 
                    SET position_applied = <cfqueryparam value="#hdn_position_applied#" cfsqltype="cf_sql_varchar">,
                        recruiter = <cfqueryparam value="#hdn_recruiter#" cfsqltype="cf_sql_varchar">,
                        cv = <cfqueryparam value="#cv#" cfsqltype="cf_sql_varchar">,
                        status = <cfqueryparam value="#hdn_status#" cfsqltype="cf_sql_varchar">,
                        est_join_date = <cfqueryparam value="#cal_est_join_date#" cfsqltype="cf_sql_timestamp">,
                        pe_date = <cfqueryparam value="#cal_pe_date#" cfsqltype="cf_sql_timestamp">,
                        pe_status = <cfqueryparam value="#pe_status#" cfsqltype="cf_sql_varchar">,
                        pe_noted = <cfqueryparam value="#pe_noted#" cfsqltype="cf_sql_varchar">,
                        pe_file = <cfqueryparam value="#pe_file#" cfsqltype="cf_sql_varchar">,
                        in_date = <cfqueryparam value="#cal_in_date#" cfsqltype="cf_sql_timestamp">,
                        in_status = <cfqueryparam value="#in_status#" cfsqltype="cf_sql_varchar">,
                        in_noted = <cfqueryparam value="#in_noted#" cfsqltype="cf_sql_varchar">,
                        in_file = <cfqueryparam value="#in_file#" cfsqltype="cf_sql_varchar">,
                        ne_date = <cfqueryparam value="#cal_ne_date#" cfsqltype="cf_sql_timestamp">,
                        ne_status = <cfqueryparam value="#ne_status#" cfsqltype="cf_sql_varchar">,
                        ne_noted = <cfqueryparam value="#ne_noted#" cfsqltype="cf_sql_varchar">,
                        ne_file = <cfqueryparam value="#ne_file#" cfsqltype="cf_sql_varchar">,
                        medic_date = <cfqueryparam value="#cal_medic_date#" cfsqltype="cf_sql_timestamp">,
                        medic_status = <cfqueryparam value="#medic_status#" cfsqltype="cf_sql_varchar">,
                        medic_noted = <cfqueryparam value="#medic_noted#" cfsqltype="cf_sql_varchar">,
                        medic_file = <cfqueryparam value="#medic_file#" cfsqltype="cf_sql_varchar">,
                        doc_date = <cfqueryparam value="#cal_doc_date#" cfsqltype="cf_sql_timestamp">,
                        doc_status = <cfqueryparam value="#doc_status#" cfsqltype="cf_sql_varchar">,
                        doc_noted = <cfqueryparam value="#doc_noted#" cfsqltype="cf_sql_varchar">,
                        doc_file = <cfqueryparam value="#doc_file#" cfsqltype="cf_sql_varchar">,
                        off_date = <cfqueryparam value="#cal_off_date#" cfsqltype="cf_sql_timestamp">,
                        off_status = <cfqueryparam value="#off_status#" cfsqltype="cf_sql_varchar">,
                        off_noted = <cfqueryparam value="#off_noted#" cfsqltype="cf_sql_varchar">, 
                        off_file = <cfqueryparam value="#off_file#" cfsqltype="cf_sql_varchar">,
                        modified_date = <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp">,
                        modified_by = <cfqueryparam value="#REQUEST.SCookie.User.uname#" cfsqltype="cf_sql_varchar">
                    WHERE APPLICANT_ID = <cfqueryparam value="#applicant_id#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfuly Updated Recruitment Tracking",true)>
                <cfoutput>
                    <script>
                        alert("#SFLANG#");
                        parent.popClose();
                        parent.refreshPage();
                    </script>
                </cfoutput>
            </cffunction>
        </cfcomponent>
