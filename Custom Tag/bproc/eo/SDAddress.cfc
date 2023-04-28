<cfcomponent displayname="SFAddress" hint="SunFish Address Business Process Object" extends="SFBP">
        <cfset strckArgument = {
               "Module" = "EO",
               "ObjectName" = "Address",
               "ObjectTable" = "TEODEMPADDRESS",
               "ObjectTitle" = "Address",
               "KeyField" = "emp_id,addresstype_code",
               "TitleField" = "addresstype_code",
               "GridColumn" = "emp_id,addresstype_code,address,city_id,state_id,zipcode,country_id,phone",
               "PKeyField" = "",
               "ObjectApproval" = "EMPLOYEE.Address",
               "DocApproval" = "EMPDATACHANGES"
        } />
   <cfset Init(argumentCollection = strckArgument) />
   <!---cfset Init("EO","Address","TEODEMPADDRESS","Address","emp_id,addresstype_code","addresstype_code","emp_id,addresstype_code,address,city_id,state_id,zipcode,country_id,phone","","EMPLOYEE.Address","EMPDATACHANGES")--->
   <!---<cffunction name="Init">
        <cfif not listfindnocase(Application.SFLICENSE.MODULES,"EO")>
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSRestricted SunFish License+JSYou may not use EO Module",true,"+")>
        <cfoutput>
            <script>
                alert("#SFLANG#");
            </script>
        </cfoutput>
        <CF_SFABORT>
        </cfif>
    </cffunction>--->
    
    <cffunction name="viewAddress" return="Query">
        <cfparam name="addresstype_code" default="0">
        <cfparam name="emp_id" default="">
        <cfparam name="empid" default="">
        <cfif len(empid)>
            <cfset LOCAL.emp_id=empid>
        </cfif>
      <!---cfset LOCAL.arrValue = ArrayNew(1)/>
         <cfsavecontent variable="LOCAL.sqlQuery">
         <cfoutput>
         SELECT TEODEmpAddress.addresstype_code,TEODEmpAddress.address
         ,TEODEmpAddress.rt,TEODEmpAddress.rw,TEODEmpAddress.zipcode
         ,TEODEmpAddress.phone,TEODEmpAddress.living_status,TEODEmpAddress.owner_status
         ,TEODEmpAddress.address_distance,TEODEmpAddress.lat_lng
         ,TEODEmpAddress.city_id
         ,TEODEmpAddress.state_id
         ,TEODEmpAddress.country_id
         ,TEODEmpAddress.district
         ,TEODEmpAddress.subdistrict
         ,TEOMEmpPersonal.full_name AS emp_name, EC.emp_no
         ,TEOMEmpPersonal.emp_id
         ,TGEMCOUNTRY.country_code
         <!---,coun.country_code--->
          FROM TEODEmpAddress 
          INNER JOIN TEODEmpCompany EC
          ON TEODEmpAddress.emp_id = EC.emp_id AND EC.company_id = #val(REQUEST.SCookie.COID)# AND is_main=1
          LEFT JOIN TEOMEmpPersonal
          ON TEOMEmpPersonal.emp_id = TEODEmpAddress.emp_id
          LEFT JOIN TGEMCOUNTRY
          ON TGEMCOUNTRY.country_id = TEODEmpAddress.country_id
          LEFT JOIN TGEMSTATE
          ON TGEMSTATE.state_id = TEODEmpAddress.state_id
          AND TGEMSTATE.country_id = TEODEmpAddress.country_id
          LEFT JOIN TGEMCITY
          ON TGEMCITY.city_id = TEODEmpAddress.city_id 
          AND TGEMCITY.state_id = TEODEmpAddress.state_id
          <!---AND TGEMCITY.country_id = TEODEmpAddress.country_id --->
          LEFT JOIN TGEMDISTRICT
          ON TGEMDISTRICT.district_id = TEODEmpAddress.district
          AND TGEMDISTRICT.city_id = TEODEmpAddress.city_id
          LEFT JOIN TGEMSUBDISTRICT
          ON TGEMSUBDISTRICT.subdistrict_id = TEODEmpAddress.subdistrict
          AND TGEMSUBDISTRICT.district_id = TEODEmpAddress.district
          <!---LEFT JOIN TEODEMPCOMPANY Pec
             ON EC.EMP_ID=TEOMEmpPersonal.EMP_ID
             LEFT JOIN TEOMCOMPANY comp ON comp.company_id=Pec.company_id
             LEFT JOIN TGEMCOUNTRY coun ON coun.country_id=COMP.country_id--->
          WHERE TEODEmpAddress.emp_id = ? <cfset ArrayAppend(arrValue, [emp_id, "CF_SQL_VARCHAR"]) />
          AND TEODEmpAddress.addresstype_code = ? <cfset ArrayAppend(arrValue, [addresstype_code, "CF_SQL_VARCHAR"]) />
         </cfoutput>
    </cfsavecontent>
        <cfset bResult = Application.SFDB.RunQuery(sqlQuery, arrValue) />
         <!---cfif bResult.QueryResult--->
        <cfset LOCAL.qData = bResult.QueryRecords />
        </cfif--->
        <cfoutput>
        <cf_sfqueryemp name="LOCAL.qData" datasource="#REQUEST.SDSN#" maxrows="1" ACCESSCODE="hrm.employee">
            SELECT TEODEmpAddress.addresstype_code,TEODEmpAddress.address
            <cfif REQUEST.SCOOKIE.COTAXCO eq 'ID'>
            ,TEODEmpAddress.rt,TEODEmpAddress.rw
            </cfif>
            ,TEODEmpAddress.zipcode
            ,TEODEmpAddress.phone,TEODEmpAddress.living_status,TEODEmpAddress.owner_status
            ,TEODEmpAddress.address_distance,TEODEmpAddress.lat_lng
            ,TEODEmpAddress.city_id
            ,TEODEmpAddress.state_id
            ,TEODEmpAddress.country_id
            ,TEODEmpAddress.district
            ,TEODEmpAddress.subdistrict
            <cfif REQUEST.SCOOKIE.COTAXCO eq 'TH' OR REQUEST.SCOOKIE.COTAXCO eq 'VN'>
            ,TEODEmpAddress.local_address
            </cfif>
            ,TEOMEmpPersonal.full_name AS emp_name, EC.emp_no
            ,TEOMEmpPersonal.emp_id
            ,TGEMCOUNTRY.country_code
            <!---,coun.country_code--->
            FROM TEODEmpAddress 
            INNER JOIN TEODEmpCompany EC
            ON TEODEmpAddress.emp_id = EC.emp_id AND EC.company_id = #val(REQUEST.SCookie.COID)# AND is_main=1
            LEFT JOIN TEOMEmpPersonal
            ON TEOMEmpPersonal.emp_id = TEODEmpAddress.emp_id
            LEFT JOIN TGEMCOUNTRY
            ON TGEMCOUNTRY.country_id = TEODEmpAddress.country_id
            LEFT JOIN TGEMSTATE
            ON TGEMSTATE.state_id = TEODEmpAddress.state_id
            AND TGEMSTATE.country_id = TEODEmpAddress.country_id
            LEFT JOIN TGEMCITY
            ON TGEMCITY.city_id = TEODEmpAddress.city_id 
            AND TGEMCITY.state_id = TEODEmpAddress.state_id
            <!---AND TGEMCITY.country_id = TEODEmpAddress.country_id --->
            LEFT JOIN TGEMDISTRICT
            ON TGEMDISTRICT.district_id = TEODEmpAddress.district
            AND TGEMDISTRICT.city_id = TEODEmpAddress.city_id
            LEFT JOIN TGEMSUBDISTRICT
            ON TGEMSUBDISTRICT.subdistrict_id = TEODEmpAddress.subdistrict
            AND TGEMSUBDISTRICT.district_id = TEODEmpAddress.district
            <!---LEFT JOIN TEODEMPCOMPANY Pec
               ON EC.EMP_ID=TEOMEmpPersonal.EMP_ID
               LEFT JOIN TEOMCOMPANY comp ON comp.company_id=Pec.company_id
               LEFT JOIN TGEMCOUNTRY coun ON coun.country_id=COMP.country_id--->
            WHERE TEODEmpAddress.emp_id = 
            <cf_sfqparamemp value="#emp_id#" cfsqltype="CF_SQL_VARCHAR">
            AND TEODEmpAddress.addresstype_code = 
            <cf_sfqparamemp value="#addresstype_code#" cfsqltype="CF_SQL_VARCHAR">
         </cf_sfqueryemp>
      </cfoutput>
      <cfset REQUEST.KeyFields="addresstype_code=#qData.addresstype_code#|emp_id=#qData.emp_id#">
      <cfreturn qData>
    </cffunction>
   
    <cffunction name="Listing">
      <!--- Passing Parameter --->
      <cfset LOCAL.scParam=paramRequest()>
      <!--- Query Field Definition --->
      <cfset LOCAL.lsField="a.emp_id, a.addresstype_code, a.address, c.city_name city_id, d.state_name state_id, a.zipcode, a.country_id, a.phone,">
      <cfset lsField = lsField & " b.name_#request.scookie.lang# as addresstype_name, full_name emp_name, emp_no">
      <cfif request.dbdriver eq "ORACLE">
         <cfset lsField = lsField & " ,NVL2(lat_lng, '1', '0') maps">
         <cfelseif request.dbdriver eq "MYSQL">
         <cfset lsField = lsField & " ,(CASE WHEN lat_lng is null then '0' WHEN lat_lng is not null then '1' END) maps">
         <cfelse>
         <cfset lsField = lsField & " ,maps = CASE WHEN lat_lng is null then '0' WHEN lat_lng is not null then '1' END">
      </cfif>
      <cfset LOCAL.dataQuery=Application.SFSec.DAuthSQL("0,1,2,3","hrm.employee","a.emp_id")>
      <cfset LOCAL.AuthData="EMPLOYEE">
      <!--- Table Join Definition --->
      <cfset LOCAL.lsTable="TEODEMPADDRESS a==View_Employee V(a.emp_id,V.company_id=#val(REQUEST.SCookie.COID)#)">
      <cfset lsTable = lsTable & ":=TEOMADDRESSTYPE b(a.addresstype_code = b.code):=TGEMCITY c(a.city_id):=TGEMSTATE d(a.state_id)"> 
      <!---<cfset lsTable = lsTable & ":=TEOMADDRESSTYPE b(a.addresstype_code = b.code):=TGEMCITY c(a.city_id):=TGEMSTATE d(c.state_id=d.state_id)">--->
      <!--- Query Filter Definition --->
      <cfset LOCAL.lsFilter="a.emp_id='#url.emp_id#'">
      <cfset ListingData(scParam,{fsort="a.emp_id",dataQuery=dataQuery,AuthData=AuthData,lsField=lsField,lsFilter=lsFilter,lsTable=lsTable,pid="addresstype_code"})>
      <!---<cf_sfwritelog dump="qCEmp" prefix="noemp_">--->
    </cffunction>
    
    <cffunction name="getAddress">
      <!---<cf_sfwritelog dump="qCEmp" prefix="noemp_">--->
      <cfreturn Listing()>
      <!---<cfparam name="emp_id" default="">
         <cfparam name="at_name" default="">
         <cfparam name="address" default="">
         <cfparam name="addresstype_code" default="">
         <cfparam name="city_id" default="0">
         <cfparam name="state_id" default="">
         <cfparam name="country_id" default="">
         <cfparam name="phone" default="">
         <cfparam name="zipcode" default="">
         <cfinclude template="#Application.PATH.CFINC#/include/_initdata.cfm">
         <cfset LOCAL.arrValue = ArrayNew(1) />
         <cfset LOCAL.arrParam = ArrayNew(1)>
         <cfif city_id neq "">
         <cfquery name="qGetCityName" datasource="#REQUEST.SDSN#">
         SELECT city_id FROM TGEMCITY where city_name LIKE '%#city_id#%'
         </cfquery>
         <cfset city_id = qGetCityName.city_id>
         </cfif>
         <cfif country_id neq "">
         <cfquery name="qGetCountryName" datasource="#REQUEST.SDSN#">
         SELECT country_id FROM TGEMcountry where country_name LIKE '%#country_id#%'
         </cfquery>
         <cfset country_id = qGetCountryName.country_id>
         </cfif>
         <cfif state_id neq "">
         <cfquery name="qGetStateName" datasource="#REQUEST.SDSN#">
         SELECT state_id FROM TGEMSTATE where state_name LIKE '%#state_id#%'
         </cfquery>
         <cfset state_id = qGetStateName.state_id>
         </cfif>
         <cfsavecontent variable="LOCAL.sqlQuery">
         <cfoutput>
         SELECT a.emp_id,a.addresstype_code,a.address,a.city_id,a.state_id,a.zipcode,a.country_id,a.phone,b.name_#request.scookie.lang# as at_name,
         CASE 
         WHEN lat_lng is null then '0' 
         WHEN lat_lng is not null then '1' END maps
         ,full_name emp_name,emp_no
         FROM TEODEMPADDRESS a
         INNER JOIN View_Employee V ON a.emp_id=V.emp_id AND V.company_id=#val(REQUEST.SCookie.COID)#
         LEFT JOIN TEOMADDRESSTYPE b ON a.addresstype_code = b.code
         <!---LEFT JOIN TGEMCITY c on a.city_id = c.city_id
         LEFT JOIN TGEMSTATE d on a.state_id = d.state_id
         LEFT JOIN TGEMcountry e on a.country_id = e.country_id--->
      WHERE 
      (	a.emp_id = ?
      <cfset ArrayAppend(arrValue, [emp_id, "CF_SQL_VARCHAR"]) />
      <cfset arrParam[ArrayLen(arrParam)+1]=emp_id>
      <cfif len(addresstype_code)>
         #vopr#
         <cfif listfind("',"",[",left(addresstype_code,1)) and listfind("',"",]",right(addresstype_code,1))>
         b.name_#request.scookie.lang# = ?
         <cfset ArrayAppend(arrValue, [mid(addresstype_code,2,len(addresstype_code)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=addresstype_code>
         <cfelse>
         b.name_#request.scookie.lang# LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & addresstype_code & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#addresstype_code#%">
      </cfif>
      </cfif>
      <cfif len(address)>
         #vopr#
         <cfif listfind("',"",[",left(address,1)) and listfind("',"",]",right(address,1))>
         a.address = ?
         <cfset ArrayAppend(arrValue, [mid(address,2,len(address)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=address>
         <cfelse>
         a.address LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & address & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#address#%">
      </cfif>
      </cfif>
      <cfif len(city_id)>
         #vopr#
         <cfif listfind("',"",[",left(city_id,1)) and listfind("',"",]",right(city_id,1))>
         a.city_id = ?
         <cfset ArrayAppend(arrValue, [mid(city_id,2,len(city_id)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=city_id>
         <cfelse>
         a.city_id LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & city_id & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#city_id#%">
      </cfif>
      </cfif>
      <cfif len(state_id)>
         #vopr#
         <cfif listfind("',"",[",left(state_id,1)) and listfind("',"",]",right(state_id,1))>
         a.state_id = ?
         <cfset ArrayAppend(arrValue, [mid(state_id,2,len(state_id)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=state_id>
         <cfelse>
         a.state_id LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & state_id & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#state_id#%">
      </cfif>
      </cfif>
      <cfif len(country_id)>
         #vopr#
         <cfif listfind("',"",[",left(country_id,1)) and listfind("',"",]",right(country_id,1))>
         a.country_id = ?
         <cfset ArrayAppend(arrValue, [mid(country_id,2,len(country_id)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=country_id>
         <cfelse>
         a.country_id LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & country_id & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#country_id#%">
      </cfif>
      </cfif>
      <cfif len(phone)>
         #vopr#
         <cfif listfind("',"",[",left(phone,1)) and listfind("',"",]",right(phone,1))>
         a.phone = ?
         <cfset ArrayAppend(arrValue, [mid(phone,2,len(phone)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=phone>
         <cfelse>
         a.phone LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & phone & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#phone#%">
      </cfif>
      </cfif>
      <cfif len(zipcode)>
         #vopr#
         <cfif listfind("',"",[",left(zipcode,1)) and listfind("',"",]",right(zipcode,1))>
         a.zipcode = ?
         <cfset ArrayAppend(arrValue, [mid(zipcode,2,len(zipcode)-2), "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]=zipcode>
         <cfelse>
         a.zipcode LIKE ?
         <cfset ArrayAppend(arrValue, ["%" & zipcode & "%", "CF_SQL_VARCHAR"]) />
         <cfset arrParam[ArrayLen(arrParam)+1]="%#zipcode#%">
      </cfif>
      </cfif>
      )
      ORDER BY 
      <cfif len(fsort)>
         #fsort#
         <cfelse>
         a.emp_id
      </cfif>
      </cfoutput>
      </cfsavecontent>
      <!--- <cf_sfwritelog content="#sqlQuery#"> --->
      <cfset LOCAL.objModel = CreateObject("component", "SMAddress") />
      <cfset LOCAL.bResult = objModel.RunQuery(sqlQuery, arrValue, rps * cpage) />
      <cfif bResult.QueryResult>
         <cfset LOCAL.qData = objModel.mRecordlist />
         <cfset LOCAL.vSQL = objModel.mStruct />
      </cfif>
      <cfset LOCAL.pid="addresstype_code">
      <cfset LOCAL.pDSN=REQUEST.SDSN>
      <cfset datatype = {}>
      <cfset dataarray = "arrData">
      <cfinclude template="#Application.PATH.CFINC#/include/_closedata.cfm">
      --->
    </cffunction>
    
    <cffunction name="checkLocalAddress">
      <cfif request.dbdriver eq 'MSSQL'>
         <cfquery name="qAlterEnabEmpLocAddressExist" datasource="#REQUEST.SDSN#">
            IF NOT EXISTS (SELECT column_name 
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE table_name = 'TPYMTAXCOUNTRY'
            AND column_name = 'enable_employeelocaladdress')
            BEGIN
            ALTER TABLE TPYMTAXCOUNTRY 
            ADD enable_employeelocaladdress VARCHAR(1);
            END;
         </cfquery>
         <cfelse>
         <cfquery name="qAlterEnabEmpLocAddressExist" datasource="#REQUEST.SDSN#">
            ALTER TABLE TPYMTAXCOUNTRY 
            ADD COLUMN IF NOT EXISTS enable_employeelocaladdress VARCHAR(1);
         </cfquery>
      </cfif>
      <cfquery name="qIsEnableLocalAddressExist" datasource="#REQUEST.SDSN#">
         SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS
         WHERE table_name = 'TPYMTAXCOUNTRY' 
         AND column_name = 'enable_employeelocaladdress'
      </cfquery>
      
      <cfif qIsEnableLocalAddressExist.recordcount neq 0>
         <cfif request.dbdriver eq 'MSSQL'>
            <cfquery name="qUpdateEnableLocalAddress" datasource="#REQUEST.SDSN#">
               UPDATE TPYMTAXCOUNTRY
               SET enable_employeelocaladdress = 'Y' , modified_by = 'superadmin', modified_date = GETDATE()
               WHERE code = 'TH' OR code = 'VN'
            </cfquery>
            <cfelse>
            <cfquery name="qUpdateEnableLocalAddress" datasource="#REQUEST.SDSN#">
               UPDATE TPYMTAXCOUNTRY
               SET enable_employeelocaladdress = 'Y' , modified_by = 'superadmin', modified_date =NOW()
               WHERE code = 'TH' OR code = 'VN'
            </cfquery>
         </cfif>
      </cfif>
      <cfquery name="qIsLocalAddressExist" datasource="#REQUEST.SDSN#">
         SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS
         WHERE table_name = 'TEODEMPADDRESS' 
         AND column_name = 'local_address'
      </cfquery>
      <cfif qIsLocalAddressExist.recordcount neq 0 AND qIsEnableLocalAddressExist.recordcount neq 0>
         <cfquery name="qCheckLocalAddress" datasource="#REQUEST.SDSN#">
            SELECT enable_employeelocaladdress 
            FROM TPYMTAXCOUNTRY 
            WHERE code='#REQUEST.SCookie.COTAXCO#'
            AND enable_employeelocaladdress = 'Y'
         </cfquery>
         <cfif qCheckLocalAddress.recordcount neq 0 >
            <cfoutput>
               {"RESULT":"#qCheckLocalAddress.enable_employeelocaladdress#"}
            </cfoutput>
            <cfelse>
            <cfoutput>
               {"RESULT":"N"}
            </cfoutput>
         </cfif>
         <cfelse>
         <cfoutput>
            {"RESULT":"N"}
         </cfoutput>
      </cfif>
   </cffunction>
   <!--- <cffunction name="GetRegionX">
      <cfparam name="city_id" default="">
      <cfparam name="zipcode_id" default="">
      <cfparam name="hdn_subdistrict_id" default="">
      <cfparam name="hdn_district_id" default="">
      <cfparam name="hdn_city_id" default="">
      <cfparam name="hdn_state_id" default="">
      <cfparam name="hdn_country_id" default="">
      <cfparam name="phone" default="">
      <cfset LOCAL.objState = CreateObject("component", "SFState") />
      <cfset FORM.hdn_state_id=objState.cekState(hdn_state_id,state_id,hdn_country_id)>
      <cfset LOCAL.objCity = CreateObject("component", "SFCity") />
      <cfset FORM.city_id=objCity.cekCity(hdn_city_id,city_id,hdn_state_id,hdn_country_id)>
      <cfset FORM.subdistrict=hdn_subdistrict_id>
      <cfset FORM.district=hdn_district_id>
      <cfset FORM.zipcode=zipcode_id>
      <!---<cfset FORM.city_id=hdn_city_id>--->
   <cfset FORM.state_id=hdn_state_id>
   <cfset FORM.country_id=hdn_country_id>
   <!---<cfoutput><script>alert("#hdn_state_id#");</script></cfoutput><CF_SFABORT>--->
   </cffunction>--->
   
   <cffunction name="Add">
        <!---<cfset GetRegion()>--->
        <cfparam name="hdn_country_code" default="" >
        <cfset LOCAL.strckData = StructNew()/>
        <cfset strckData=SUPER.GetRegion(FORM)>
        <cfif not StructKeyExists(strckData,"hdn_state_id") and strckData.hdn_state_id neq "" and strckData.hdn_state_id neq false>
            <cfset FORM.hdn_state_id=strckData.hdn_state_id>
        </cfif>
        <cfif not StructKeyExists(strckData,"hdn_city_id") and strckData.hdn_city_id neq "" and strckData.hdn_city_id neq false>
            <cfset FORM.hdn_city_id=strckData.hdn_city_id>
        </cfif>
        <cfif not StructKeyExists(strckData,"hdn_district_id") and strckData.hdn_district_id neq "" and strckData.hdn_district_id neq false>
            <cfset FORM.hdn_district_id=strckData.hdn_district_id>
        </cfif>
        <cfif not StructKeyExists(strckData,"hdn_subdistrict_id") and strckData.hdn_subdistrict_id neq "" and strckData.hdn_subdistrict_id neq false>
            <cfset FORM.hdn_subdistrict_id=strckData.hdn_subdistrict_id>
        </cfif>
        <cfset SUPER.Add()>
    </cffunction>
    
    <!---<cffunction name="Save">
      <cfparam name="hdn_state_id" default="">
      <cfset GetRegion()>
      <cfset SUPER.Save()>
    </cffunction> --->
    
    <cffunction name="Save">
        <cfparam name="FORM.zipcode_id" default="">
        <cfparam name="FORM.zipcode" default="#FORM.zipcode_id#">
        <cfparam name="FORM.address_distance" default="">
        
        <!--- TW, 2 July 2014: zipcode included in Region Input Type must be named zipcode_id & addr distance float-int conversion --->
        <cfif val(FORM.address_distance)>
            <cfset FORM.address_distance=Int(FORM.address_distance)>
        </cfif>
            <cfset LOCAL.strckData = StructNew()/>
            <cfset strckData=SUPER.GetRegion(FORM)>
        <cfif not StructKeyExists(strckData,"hdn_state_id") and strckData.hdn_state_id neq "" and strckData.hdn_state_id neq false>
            <cfset FORM.hdn_state_id=strckData.hdn_state_id>
        </cfif>
        <cfif not StructKeyExists(strckData,"hdn_city_id") and strckData.hdn_city_id neq "" and strckData.hdn_city_id neq false>
            <cfset FORM.hdn_city_id=strckData.hdn_city_id>
        </cfif>
        <cfif not StructKeyExists(strckData,"hdn_district_id") and strckData.hdn_district_id neq "" and strckData.hdn_district_id neq false>
            <cfset FORM.hdn_district_id=strckData.hdn_district_id>
        </cfif>
        <cfif not StructKeyExists(strckData,"hdn_subdistrict_id") and strckData.hdn_subdistrict_id neq "" and strckData.hdn_subdistrict_id neq false>
            <cfset FORM.hdn_subdistrict_id=strckData.hdn_subdistrict_id>
        </cfif>
        <cfset SUPER.Save()>
   </cffunction>

   <cffunction name="SaveMaps">
    <cfparam name="txtlatlng" default="">
    <cfparam name="empid" default="">
    <cfset LOCAL.strckData = FORM/>
    <cfset addresstype_code = strckData["addresstype_code"] >
    <cfset txtlatlng	= strckData["txtlatlng"] >
    <cfset emp_id	= strckData["emp_id"] >
    <cfif isdefined("txtlatlng") AND Len(Trim(txtlatlng))>
        <cfquery name="qryMaps" datasource="#REQUEST.SDSN#">
            <cftransaction>
                UPDATE TEODEMPADDRESS
                SET TEODEMPADDRESS.lat_lng = 
                <cfqueryparam value="#txtlatlng#" CFSQLType="cf_sql_varchar">
                ,created_date = TEODEMPADDRESS.created_date
                ,created_by = TEODEMPADDRESS.created_by
                ,modified_date = #CreateODBCDateTime(Now())#
                ,modified_by = '#REQUEST.Scookie.User.Uname#'
                WHERE addresstype_code = <cfqueryparam value="#addresstype_code#" CFSQLType="cf_sql_varchar">
                AND emp_id	= <cfqueryparam value="#emp_id#" cfsqltype="cf_sql_varchar">
            </cftransaction>
        </cfquery>
        <cfquery name="qGetPersonalAddress" datasource="#REQUEST.SDSN#">
            SELECT *
            FROM TEODEMPADDRESS
            WHERE addresstype_code = <cfqueryparam value="#addresstype_code#" CFSQLType="cf_sql_varchar">
                AND emp_id	= <cfqueryparam value="#emp_id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfquery name="qInsertPersonalAddress" datasource="#REQUEST.SDSN#">
            INSERT INTO TTAMATTLOCATION
            (
                LOCATION_CODE,
                COMPANY_ID,
                LOCATION_NAME,
                LOCATION_ADDRESS,
                COUNTRY_ID,
                STATE_ID,
                CITY_ID,
                LAT_LNG,
                MAX_RADIUS,
                ACTIVE,
                CREATED_DATE,
                CREATED_BY,
                MODIFIED_DATE,
                MODIFIED_BY
                GMT_ID,
                DESTINATION_CODE
            ) VALUES (
                <CFQUERYPARAM VALUE="#qGetPersonalAddress.LASTREQNO#_CURRENT" CFSQLTYPE="CF_SQL_VARCHAR">,
                <CFQUERYPARAM VALUE="#REQUEST.Scookie.COID#" CFSQLTYPE="CF_SQL_INTEGER">,
                <CFQUERYPARAM VALUE="#qGetPersonalAddress.LASTREQNO#_CURRENT" CFSQLTYPE="CF_SQL_VARCHAR">,
                <CFQUERYPARAM VALUE="#qGetPersonalAddress.ADDRESS#" CFSQLTYPE="CF_SQL_VARCHAR">,
                <CFQUERYPARAM VALUE="#qGetPersonalAddress.COUNTRY_ID#" CFSQLTYPE="CF_SQL_BIGINT">,
                <CFQUERYPARAM VALUE="#qGetPersonalAddress.STATE_ID#" CFSQLTYPE="CF_SQL_INTEGER">,
                <CFQUERYPARAM VALUE="#qGetPersonalAddress.CITY_ID#" CFSQLTYPE="CF_SQL_INTEGER">,
                <CFQUERYPARAM VALUE="#txtlatlng#" CFSQLTYPE="CF_SQL_DECIMAL" SCALE="4">,
                <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                30,
                null
            )
        </cfquery>
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Save Maps Address",true)>
            <cfoutput>
                <script>
                    alert("#SFLANG#");
                    popClose();
                    refreshPage();
                </script>
            </cfoutput>
        <cfelse>
      
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSMaps Not Defined address",true)>
            <cfoutput>
                <script>
                    alert("#SFLANG#");
                </script>
            </cfoutput>
        </cfif>
   </cffunction>
   
   <cffunction name="ViewMaps">
        <cfparam name="worklocation_code" default="">
        <cfoutput>
            <style type="text/css">
                html, body {
                    height: 100%;
                    margin: 0;
                    padding: 0;
                }
                ##map_canvas {
                    height: 100%;
                }
            </style>
        <cfparam name="emp_id" default="">
        <cfparam name="addresstype_code" default="">
        <cfquery name="qAddr" datasource="#REQUEST.SDSN#">
            SELECT TEODEMPADDRESS.addresstype_code,
            TEOMADDRESSTYPE.name_#request.scookie.lang# worklocation_name,
            TEODEMPADDRESS.lat_lng,
            TEODEMPADDRESS.zipcode,
            TEODEMPADDRESS.address
            FROM TEODEMPADDRESS,
            TEOMADDRESSTYPE
            WHERE TEOMADDRESSTYPE.code	= TEODEMPADDRESS.addresstype_code
            AND TEODEMPADDRESS.addresstype_code = <cfqueryparam value="#addresstype_code#" cfsqltype="cf_sql_varchar">
            AND TEODEMPADDRESS.emp_id = <cfqueryparam value="#emp_id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <!---
            <cfset nickName=''>
            <cfset space=''>
            <cfif isdefined("qAddr.district") AND Len(Trim(qAddr.district))>
            <cfset nickName = qAddr.district>
            <cfset space=','>
            <cfelse>
            <cfset space=''>
            </cfif>
            <cfif isdefined("qAddr.subdistrict") AND Len(Trim(qAddr.subdistrict))>
            <cfset nickName = nickName & space &qAddr.subdistrict>
            <cfset space=','>
            <cfelse>
            <cfif Len(Trim(space)) eq 0>
            <cfset space=''>
            </cfif>
            </cfif>
            <cfif isdefined("qAddr.First_Name") AND Len(Trim(qAddr.First_Name))>
            <cfset nickName = nickName & space &qAddr.First_Name>
            <cfset space=','>
            <cfelse>
            <cfif Len(Trim(space)) eq 0>
            <cfset space=''>
            </cfif>
            </cfif>
            <cfif isdefined("qAddr.Middle_Name") AND Len(Trim(qAddr.Middle_Name))>
            <cfset nickName = nickName & space &qAddr.Middle_Name>
            <cfset space=','>
            <cfelse>
            <cfif Len(Trim(space)) eq 0>
            <cfset space=''>
            </cfif>
            </cfif>
            <!---<cfif isdefined("qAddr.zipcode") AND Len(Trim(qAddr.zipcode))>
            <cfset nickName = nickName & space &qAddr.zipcode>
            <cfset space=','>
            <cfelse>
            <cfif Len(Trim(space)) eq 0>
            <cfset space=''>
            </cfif>
            </cfif>--->
        <cfif isdefined("qAddr.Last_Name") AND Len(Trim(qAddr.Last_Name))>
            <cfset nickName = nickName & space & qAddr.Last_Name>
        <cfelse>
            <cfif Len(Trim(space))>
                <cfset space=''>
            </cfif>
        </cfif>
        --->
        <cfset inputLatLng=''>
        <cfif isdefined("qAddr.lat_lng") AND Len(Trim(qAddr.lat_lng))>
        <cfset inputLatLng=qAddr.lat_lng>
        </cfif>
        <cfset inputAddress=''>
        <cfif isdefined("qAddr.address") AND Len(Trim(qAddr.address))>
        <cfset inputAddress=qAddr.address>
        </cfif>
        <!---
            <cfif isdefined("nickName") AND Len(Trim(nickName))>
            <cfif isdefined("inputAddress") AND Len(Trim(inputAddress))>
            <cfset inputAddress = inputAddress & space & nickName>
            <cfelse>
            <cfset inputAddress = nickName>
            </cfif>	
            </cfif>
        --->
        <body onresize="">
            <table width="100%" border="0" cellspacing="0" cellpadding="1">
               <tr>
                  <td valign="top">
                     <input id="txtlatlng" name="txtlatlng" type="hidden" value="" style="width:290px;"/>
                     <input id="chklatlng" name="chklatlng" type="checkbox" value="1" style="display:none;"/>
                     <input id="txtaddress" name="txtaddress" type="text" value="#HTMLEditFormat(inputAddress)#" style="width:80%;"/>
                     <input id="btngeocode" type="button" value="Search" onClick="codeAddress();" <!---<cfif isdefined("url.edit") AND url.edit eq 0>disabled="disabled"</cfif>--->/>
                  </td>
               </tr>
               <tr>
                  <td valign="top">
                     <div id="map_canvas" style="height:100%; width:100%; border: 1px solid ##979797;"></div>
                  </td>
               </tr>
               <tr></tr>
            </table>
        </body>
        <script type="text/javascript">
            var geocoder=null;
            var map=null;
            var marker = null;
            var latlng = null;
            var gInfoWindow=null;
            var chklatlng = document.getElementById("chklatlng");
            chklatlng.checked = false;
            var qinick = "#HTMLEditFormat(JSStringFormat(qAddr.worklocation_name))#";
            var qiaddress = "#HTMLEditFormat(JSStringFormat(inputAddress))#";
            var qilatlng = "#HTMLEditFormat(JSStringFormat(inputLatLng))#";
            setWindowSize();
			function loadGMAPI() {
				var script = document.createElement("script");
				script.type = "text/javascript";
				script.src = "<cfif CGI.HTTPS eq 'on'>https<cfelse>https</cfif>://maps.googleapis.com/maps/api/js?key=#request.config.mapsapi#&sensor=false&callback=initialize"; //TCK0718-194083: nambahin parameter key
				document.body.appendChild(script);
			}

			function initialize() {
				<!---/*initialize the map geocoder*/--->
				geocoder = new google.maps.Geocoder();
				latlng = new google.maps.LatLng(-0.789275, 113.92132700000002);
				var myOptions = {
					zoom: 5,
					streetViewControl: false,
					navigationControlOptions: {
						style: google.maps.NavigationControlStyle.ZOOM_PAN
					},
					mapTypeId: google.maps.MapTypeId.ROADMAP
				}
				<!---/*initialize the map with default UI*/--->
				map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
				<!---/*initialize the marker with default UI*/--->
				marker = new google.maps.Marker({
					map: map,
					draggable: true,
					title: qinick
				});
				gInfoWindow = new google.maps.InfoWindow();
				<!---/*add listener*/--->
				google.maps.event.addListener(map, 'click', function () {
					gInfoWindow.close();
				});
				google.maps.event.addListener(marker, 'click', function () {
					gInfoWindow.open(map, marker);
				});
				google.maps.event.addListener(marker, 'drag', function () {
					<!---/*('Dragging...')*/--->
					gInfoWindow.close();
					//updateMarkerPosition(marker.getPosition());
				});
				google.maps.event.addListener(marker, 'dragend', function () {
					<!---/*('Drag ended')*/--->
					updateMarkerPosition(marker.getPosition());
					geocodePosition(marker.getPosition());
				});
				google.maps.event.addListener(map, 'zoom_changed', function () {
					setTimeout(function () {
						marker.setPosition(marker.getPosition());
					}, 10);
				});
				google.maps.event.addListener(map, 'dblclick', function () {
					setTimeout(function () {
						marker.setPosition(marker.getPosition());
					}, 10);
				});
				setTimeout(function () {
					if (qilatlng !== '') {
						chklatlng.checked = true;
						codeLatLng(qilatlng);
					} else if (qiaddress !== '') {
						codeAddress(qiaddress);
					}
				}, 100);
			}

			function loadDefaultMarker() {
				geocodePosition(marker.getPosition());
				map.setCenter(latlng);
				marker.setPosition(latlng);
				updateMarkerPosition(marker.getPosition());
				map.setZoom(5);
			}
			
			function isValidCoordinates(coordinates){
    			var args = coordinates.split(',');
    
    			var lat = /^(-?[1-8]?\d(?:\.\d{1,18})?|90(?:\.0{1,18})?)$/;
    			var lon = /^(-?(?:1[0-7]|[1-9])?\d(?:\.\d{1,18})?|180(?:\.0{1,18})?)$/;
    			  
    			console.log("'" + args[0] + "', '" +  args[1] + "'");
    
    			if(lat.test(args[0].trim()) == true && lon.test(args[1].trim()) == true){ 
    			//	console.log("Prana1");
    				return true;
    			} else{
    			//	console.log("PRN2");
    				return false;
    			}
    		}

			function codeAddress(qiaddress) {
				gInfoWindow.close();
				if (qiaddress === '' || typeof (qiaddress) === 'undefined') {
					var qiaddress = document.getElementById("txtaddress").value;
				}
				var arrqiaddress = qiaddress.split(",");
				if(isValidCoordinates(qiaddress)) {
    				codeLatLng(qiaddress);
    			} else {
    				geocoder.geocode({
    					'address': qiaddress
    				}, function (results, status) {
    					setTimeout(function () {
    						if (status == google.maps.GeocoderStatus.OK) {
    							map.setCenter(results[0].geometry.location);
    							map.setZoom(15);
    							setTimeout(function () {
    								marker.setPosition(results[0].geometry.location);
    								updateMarkerPosition(marker.getPosition());
    							}, 10);
    							gInfoWindow.setContent(formatHtml(results[0].formatted_address));
    						} else {
    							<!---/*Geocode was not successful. No results found, try again*/--->
    							if (arrqiaddress.length > 1) {
    								qiaddress = '';
    								for (var q = 1; q < arrqiaddress.length; q++) {
    									if (arrqiaddress[q] !== '') {
    										if (q > 1) {
    											qiaddress += ',';
    										}
    										qiaddress += arrqiaddress[q];
    									}
    								}
    								codeAddress(qiaddress);
    							} else {
    								alert("No results found");
    								loadDefaultMarker();
    							}
    						}
    					}, 200);
    				});
    			}
			}

			function codeLatLng(setlatlang) {
				var input = setlatlang;
				var latlngStr = input.split(",", 2);
				var lat = parseFloat(latlngStr[0]);
				var lng = parseFloat(latlngStr[1]);
				var latlng = new google.maps.LatLng(lat, lng);
				geocoder.geocode({
					'latLng': latlng
				}, function (results, status) {
					setTimeout(function () {
						if (status == google.maps.GeocoderStatus.OK) {
							if (results[1]) {
								map.setCenter(latlng);
								map.setZoom(15);
								setTimeout(function () {
									marker.setPosition(latlng);
									updateMarkerPosition(marker.getPosition());
								}, 10);
								gInfoWindow.setContent(formatHtml(results[0].formatted_address));
							} else {
								alert("No results found");
							}
						} else {
							alert("No results found");
						}
					}, 100);
				});
			}

			function geocodePosition(pos) {
				geocoder.geocode({
					latLng: pos
				}, function (responses) {
					if (responses && responses.length > 0) {
						gInfoWindow.setContent(formatHtml(responses[0].formatted_address));
					} else {
						gInfoWindow.setContent('<div>Cannot determine address at this location.</div>');
					}
				});
			}

			function formatHtml(address_) {
				return '<div class="address">' + address_ + '</div>\n<br/><span onclick="zoomIn(\'gmzoom1\');" style="color: ##0000FF; cursor: pointer; text-decoration: underline;">Zoom in</span>';
			}

			function zoomIn(request) {
				switch (request) {
					case 'gmzoom1':
						{
							gInfoWindow.close();
							map.setCenter(marker.getPosition());
							//if(map.getZoom() < 19){
							map.setZoom(map.getZoom() + 1);
							//}
							break;
						}
				}
			}

			function updateMarkerPosition(latLng) {
				<!---/*update_marker:[input hidden]*/--->
				if (document.getElementById('txtlatlng') !== null) {
					document.getElementById('txtlatlng').value = [latLng.lat(), latLng.lng()].join(',');
				}
			}

			function setWindowSize() {
				if (typeof window.innerHeight != 'undefined') { //viewportwidth = window.innerWidth;
					viewportheight = window.innerHeight;
				}
				<!---/*IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)*/--->
				else if (typeof document.documentElement != 'undefined' &&
					typeof document.documentElement.clientHeight != 'undefined' &&
					document.documentElement.clientHeight != 0) { //viewportwidth = document.documentElement.clientWidth;
					viewportheight = document.documentElement.clientHeight;
				}
				<!---/*older versions of IE*/--->
				else { //viewportwidth = document.getElementsByTagName('body')[0].clientWidth;
					viewportheight = document.getElementsByTagName('body')[0].clientHeight;
				}
				document.getElementById("map_canvas").style.height = (viewportheight - 73) + "px";
			}
			<!---/*Onload handler to fire off the app.*/--->
			loadGMAPI();	
        </script>
        </cfoutput>
   </cffunction>
   
   <cffunction name="DeleteMaps">
        <cfparam name="empid" default="">
        <cfset LOCAL.strckData = FORM/>
        <cfset addresstype_code = strckData["addresstype_code"] >
        <cfset emp_id	= strckData["emp_id"] >
        <cfquery name="qryMapsDefined" datasource="#REQUEST.SDSN#">
        <cftransaction>
            SELECT TEODEMPADDRESS.lat_lng
            FROM TEODEMPADDRESS
            WHERE emp_id = <cfqueryparam value="#emp_id#" CFSQLType="cf_sql_varchar">
            AND addresstype_code = <cfqueryparam value="#addresstype_code#" CFSQLType="cf_sql_varchar">
        </cftransaction>
        </cfquery>
        
        <cfif isdefined("qryMapsDefined.lat_lng") AND Len(Trim(qryMapsDefined.lat_lng))>
        
        <cfquery name="qryMaps" datasource="#REQUEST.SDSN#">
        <cftransaction>
            UPDATE FROM TEODEMPADDRESS
            SET TEODEMPADDRESS.lat_lng = NULL
            ,created_date = TEODEMPADDRESS.created_date
            ,created_by = TEODEMPADDRESS.created_by
            ,modified_date = #CreateODBCDateTime(Now())#
            ,modified_by = '#REQUEST.Scookie.User.Uname#'
            WHERE addresstype_code = 
            <cfqueryparam value="#addresstype_code#" CFSQLType="cf_sql_varchar">
            AND emp_id	= 
            <cfqueryparam value="#emp_id#" cfsqltype="cf_sql_varchar">
        </cftransaction>
        </cfquery>
        <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Delete Maps Address",true)>
        <cfoutput>
            <script>
                alert("#SFLANG#");
                popClose();
                refreshPage();
            </script>
        </cfoutput>
    <cfelse>
        <cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSMaps Not Defined Address",true)>
        <cfoutput>
            <script>
                alert("#SFLANG#");
            </script>
        </cfoutput>
        </cfif>
   </cffunction>
   
   <!--- Request Approval Function --->
   <cffunction name="GetFormRequest" access="public" returntype="struct">
        <cfargument name="iAction" type="numeric" required="yes">
        <cfset var strckFormData = FORM />
           <!--- Get Region Mapping, adjust with the column name in the Table TEODEmpAddress--->
        <cfif isdefined("hdn_subdistrict_id")>
            <cfset strckFormData['subdistrict'] = strckFormData.hdn_subdistrict_id/>
        </cfif>
        <cfif isdefined("hdn_district_id")>
              <cfset strckFormData['district'] = strckFormData.hdn_district_id/>
        </cfif>
        <cfif isdefined("hdn_city_id")>
            <cfset strckFormData['city_id'] = strckFormData.hdn_city_id/>
        </cfif>
        <cfif isdefined("hdn_state_id")>
            <cfset strckFormData['state_id'] = strckFormData.hdn_state_id/>
        </cfif>
        <cfset strckFormData['modified_date'] = Now()/>
        <cfset strckFormData['modified_by'] = REQUEST.SCookie.User.uname />
        <!---RH 14012022|TCK2201-0704345 add for replace special char because can cause error in SPT --->
        <!---<cfif REQUEST.SCOOKIE.COTAXCO eq 'ID'>
        <cfset strckFormData['address'] = rereplaceNocase(strckFormData.address,"[^A-Za-z0-9-+$. _]","","All")/>
        <cfelse>
        <cfset strckFormData['address'] = rereplaceNocase(strckFormData.address,"[^A-Za-z0-9-+$. _/]","","All")/>
        </cfif>--->
        <cfset strckFormData['address'] = rereplaceNocase(strckFormData.address,"[-+$_'~""]","","All")/>
        <cfreturn strckFormData />
    </cffunction>

   <cffunction name="InitFormRequest" access="private" returntype="struct">
        <cfargument name="iAction" type="numeric" required="yes">
        <cfargument name="strckFormData" type="struct" required="yes">
        <!---<cfset Arguments.strckFormData=GetRegion(Arguments.strckFormData)/>--->
        <!--- Get Region Mapping, adjust with the column name in the ObjectTable--->
        <cfif isdefined("hdn_subdistrict_id")>
            <cfset strckFormData['subdistrict'] = strckFormData.hdn_subdistrict_id/>
        </cfif>
        <cfif isdefined("hdn_district_id")>
            <cfset strckFormData['district'] = strckFormData.hdn_district_id/>
        </cfif>
        <cfif isdefined("hdn_city_id")>
            <cfset strckFormData['city_id'] = strckFormData.hdn_city_id/>
        </cfif>
        <cfif isdefined("hdn_state_id")>
            <cfset strckFormData['state_id'] = strckFormData.hdn_state_id/>
        </cfif>
        <cfif isdefined("hdn_country_id")>
            <cfset strckFormData['country_id'] = strckFormData.hdn_country_id/>
        </cfif>
        <cfreturn strckFormData />
    </cffunction>
   
   	<cffunction name="GetPreviousFormRequestData" access="public" returntype="query" hint="used on request edit data and request inbox">
		<cfargument name="scParam" type="struct" required="yes">
            <cfquery name="LOCAL.qData" datasource="#REQUEST.SDSN#" maxrows="1">
                SELECT TEODEmpAddress.addresstype_code,TEODEmpAddress.address
                <cfif REQUEST.SCOOKIE.COTAXCO eq 'ID'>
                ,TEODEmpAddress.rt,TEODEmpAddress.rw
                </cfif>
                ,TEODEmpAddress.zipcode
                ,TEODEmpAddress.phone,TEODEmpAddress.living_status,TEODEmpAddress.owner_status
                ,TEODEmpAddress.address_distance,TEODEmpAddress.lat_lng
                ,TEODEmpAddress.city_id
                ,TEODEmpAddress.state_id
                ,TEODEmpAddress.country_id
                ,TEODEmpAddress.district
                ,TEODEmpAddress.subdistrict
                <cfif REQUEST.SCOOKIE.COTAXCO eq 'TH' OR REQUEST.SCOOKIE.COTAXCO eq 'VN'>
                ,TEODEmpAddress.local_address
                </cfif>
                ,TEOMEmpPersonal.full_name AS emp_name, EC.emp_no
                ,TEOMEmpPersonal.emp_id
                ,TGEMCOUNTRY.country_code
                FROM TEODEmpAddress 
                INNER JOIN TEODEmpCompany EC ON TEODEmpAddress.emp_id = EC.emp_id AND EC.company_id = #val(REQUEST.SCookie.COID)# AND is_main=1
                LEFT JOIN TEOMEmpPersonal ON TEOMEmpPersonal.emp_id = TEODEmpAddress.emp_id
                LEFT JOIN TGEMCOUNTRY ON TGEMCOUNTRY.country_id = TEODEmpAddress.country_id
                LEFT JOIN TGEMSTATE ON TGEMSTATE.state_id = TEODEmpAddress.state_id AND TGEMSTATE.country_id = TEODEmpAddress.country_id
                LEFT JOIN TGEMCITY ON TGEMCITY.city_id = TEODEmpAddress.city_id AND TGEMCITY.state_id = TEODEmpAddress.state_id
                LEFT JOIN TGEMDISTRICT ON TGEMDISTRICT.district_id = TEODEmpAddress.district AND TGEMDISTRICT.city_id = TEODEmpAddress.city_id
                LEFT JOIN TGEMSUBDISTRICT ON TGEMSUBDISTRICT.subdistrict_id = TEODEmpAddress.subdistrict
                AND TGEMSUBDISTRICT.district_id = TEODEmpAddress.district
                WHERE TEODEmpAddress.emp_id = <cfqueryparam value = "#scParam.emp_id#" cfsqltype="CF_SQL_VARCHAR">
                AND TEODEmpAddress.addresstype_code =  <cfqueryparam value = "#scParam.addresstype_code#" cfsqltype="CF_SQL_VARCHAR">
         </cfquery>
        <cfset REQUEST.KeyFields="addresstype_code=#qData.addresstype_code#|emp_id=#qData.emp_id#">
       
		<!---cfset LOCAL.retVar = THIS.MObject.GetRecord(scParam) />
		<cfreturn retVar /--->
		<cfreturn qData />
	</cffunction>
	
   <cffunction name="Inbox">
        <cfargument name="RequestData" type="Struct" required="Yes">
        <cfargument name="ProcData" type="Array" required="Yes">
        <cfargument name="RowNumber" type="Numeric" required="Yes">
        <cfargument name="RequestMode" type="String" required="Yes">
        <cfargument name="RequestStatus" type="Numeric" required="Yes">
        
        <cfset LOCAL.keydata="emp_id"> 
        <cfset LOCAL.lsExcField="created_date,created_by,modified_date,modified_by,sessionid,seq_id,emp_id">
        <cfset LOCAL.LULANG=Application.SFParser.TransMLang("OPLive Alone|OPLive With Family|OPLive With Parents|OPLease|OPOwn Property|OPCurrent Address|OPID Card Address|OPOther City Address")>
        <!--- Remark by AS : edit data from table master 
        <cfset REQUEST.lsLU_living_status="LA=#LULANG['OPLiveAlone']#|LWF=#LULANG['OPLiveWithFamily']#|LWP=#LULANG['OPLiveWithParents']#">
        <cfset REQUEST.lsLU_owner_status="L=#LULANG['OPLease']#|OP=#LULANG['OPOwnProperty']#">
        <cfset REQUEST.lsLU_addresstype_code="A=#LULANG['OPCurrentAddress']#|B=#LULANG['OPIDCardAddress']#|C=#LULANG['OPOtherCityAddress']#" --->
        <cfset LOCAL.LUStay=CreateTimeSpan(1,0,0,0)>
         <!--- LookUp Lifespan --->
        <cfif not StructKeyExists(REQUEST,"qLU_living_status")>
    		<cfinvoke component="SFLookUp" method="refLivingStatus" timespan="#LUStay#" returnVariable="REQUEST.qLU_living_status">
        </cfif> 
        <cfif not StructKeyExists(REQUEST,"qLU_owner_status")>
    		<cfinvoke component="SFLookUp" method="refStatusOwner" timespan="#LUStay#" returnVariable="REQUEST.qLU_owner_status">
        </cfif> 
        <cfif not StructKeyExists(REQUEST,"qLU_addresstype_code")>
    		<cfinvoke component="SFLookUp" method="refAddressType" timespan="#LUStay#" returnVariable="REQUEST.qLU_addresstype_code">
        </cfif> 
        <!--- end edit by AS --->
        <cfif not StructKeyExists(REQUEST,"qLU_subdistrict")>
    		<cfinvoke component="SFSubDistrict" method="REFERENCE" timespan="#LUStay#" returnVariable="REQUEST.qLU_subdistrict">
        </cfif>
        <cfif not StructKeyExists(REQUEST,"qLU_district")>
    		<cfinvoke component="SFDistrict" method="REFERENCE" timespan="#LUStay#" returnVariable="REQUEST.qLU_district">
        </cfif>
        <cfif not StructKeyExists(REQUEST,"qLU_city_id")>
    		<cfinvoke component="SFCity" method="REFERENCE" timespan="#LUStay#" returnVariable="REQUEST.qLU_city_id">
        </cfif>
        <cfif not StructKeyExists(REQUEST,"qLU_state_id")>
    	    <cfinvoke component="SFState" method="REFERENCE" timespan="#LUStay#" returnVariable="REQUEST.qLU_state_id">
        </cfif>
    	<cfif not StructKeyExists(REQUEST,"qLU_country_id")>
    	    <cfinvoke component="SFCountry" method="REFERENCE" timespan="#LUStay#" returnVariable="REQUEST.qLU_country_id">
        </cfif>
        <!---Use SFBP.Inbox to create this request inbox--->
		<cfset LOCAL.reqDataDisplay="addresstype_code|addresstype_code,address|address,local_address|local_address,rt|rt,rw|rw,subdistrict|subdistrict,district|district,city_id|city_id,state|state,country_code|country_code,state_id|state_id,country_id|country_id,zipcode|zipcode,phone|phone,owner_status|owner_status,address_distance|address_distance,living_status|living_status">
        <cfset scProc=SUPER.Inbox(RequestData,ProcData,RowNumber,RequestMode,RequestStatus,"",keydata,reqDataDisplay)>
        <cfreturn scProc>
        
        <!--- cfset LOCAL.scData=structNew()>
         <cfset LOCAL.scReq=Arguments.RequestData>
         <cfset LOCAL.scProc=Arguments.ProcData>
         <cfset LOCAL.irow=Arguments.RowNumber>
         <cfloop index="LOCAL.ikey" list="#keydata#">
         <cfif StructKeyExists(scReq,ikey)>
         <cfset scData[ikey]=scReq[ikey]>
         <cfset scProc[irow][ikey]=scReq[ikey]>
         <cfelse>
         <cfreturn false>
         </cfif>
         </cfloop>
         <cfset scProc[irow]["req_mode"]=Arguments.RequestMode>
         <cfif Arguments.RequestMode eq "1">
         -- Update -- 
         <cfset LOCAL.qData=THIS.MObject.GetRecord(scData)>
            <cfif qData.recordcount and Arguments.RequestStatus neq "3">
            <cfset LOCAL.SFLANG=Application.SFParser.TransMLang(listAppend("Current|Proposed","FD" & Replace(Replace(qData.columnlist,",","|FD","ALL"),"_","","ALL"),"|"))>
            <cfoutput>
            <table cellspacing="0">
                <tr>
                    <td style="padding-right:10px;border-bottom:1px solid gray;">&nbsp;</td>
                    <td bgcolor="##E9E9E9" style="padding-left:10px;padding-right:10px;border-bottom:1px solid gray;"><b>#SFLANG['Current']#</b></td>
                    <td style="padding-left:10px;padding-right:10px;border-bottom:1px solid gray;"><b>#SFLANG['Proposed']#</b></td>
               </tr>
               <cfset scProc[irow]["scChanges"]=structNew()>
               <cfloop index="ifld" list="#qData.columnlist#">
                <cfif StructKeyExists(scReq,ifld) and not listfindnocase(lsExcField,ifld)>
                    <cfif scReq[ifld] neq qData[ifld][1] or listFindNoCase(keydata,ifld)>
                        <cfset LOCAL.oldData=qData[ifld][1]>
                        <cfset LOCAL.newData=scReq[ifld]>
                        <cfset scProc[irow][ifld]=newData>
                    <cfif IsDefined("lsLU_#ifld#")>
                        <cfset LOCAL.lstLU=evaluate("lsLU_#ifld#")>
                        <cfif len(oldData)>
                            <cfset LOCAL.ndx=listContainsNoCase(lstLU,oldData & "=","|")>
                            <cfif ndx>
                                <cfset oldData=listRest(listGetAt(lstLU,ndx,"|"),"=")>
                            </cfif>
                        </cfif>
                    <cfif len(newData)>
                        <cfset LOCAL.ndx=listContainsNoCase(lstLU,newData & "=","|")>
                        <cfif ndx>
                            <cfset newData=listRest(listGetAt(lstLU,ndx,"|"),"=")>
                        </cfif>
                    </cfif>
                    <cfelseif StructKeyExists(REQUEST,"qLU_#ifld#")>
                    <cfif len(oldData)>
                        <cfquery name="LOCAL.qLUData" dbtype="query">
                            SELECT * FROM REQUEST.qLU_#ifld#
                            WHERE optvalue=#val(oldData)#
                        </cfquery>
                        <cfif qLUData.recordcount>
                            <cfset oldData=qLUData.opttext>
                        </cfif>
                    </cfif>
                    <cfif len(newData)>
                        <cfquery name="LOCAL.qLUData" dbtype="query">
                            SELECT * FROM REQUEST.qLU_#ifld#
                            WHERE optvalue=#val(newData)#
                        </cfquery>
                    <cfif qLUData.recordcount>
                        <cfset newData=qLUData.opttext>
                    </cfif>
                    </cfif>
                </cfif>
        
                <cfset scProc[irow]["scChanges"][ifld]["old"]=oldData>
                <cfset scProc[irow]["scChanges"][ifld]["new"]=newData>
                <tr>
                    <td class="inpnote" bgcolor="##E9E9E9" style="padding-left:5px;padding-right:5px;border-bottom:1px solid gray;">#SFLANG['FD#Replace(lcase(ifld),"_","","ALL")#']#</td>
                    <td class="inpnote" style="border-bottom:1px solid gray;padding-right:5px;"><cfif IsDate(oldData)>#DateFormat(oldData,"mm/dd/yyyy")#<cfelse>#Application.SFUtil.NoBlank(oldData)#</cfif></td>
                    <td class="inpnote" bgcolor="##E9E9E9" style="border-bottom:1px solid gray;padding-right:5px;"><cfif IsDate(newData)>#DateFormat(newData,"mm/dd/yyyy")#<cfelse>#Application.SFUtil.NoBlank(newData)#</cfif></td>
                </tr>
            </cfif>
            </cfif>
            </cfloop>
            </table>
            </cfoutput>
        </cfif>
      
        <cfelseif Arguments.RequestMode eq "0">
      <!--- Insert --->
      <cfset LOCAL.qData=THIS.MObject.GetRecord(scData)>
      <cfif qData.recordcount eq "0">
         <cfset LOCAL.SFLANG=Application.SFParser.TransMLang(listAppend("New Data","FD" & Replace(Replace(qData.columnlist,",","|FD","ALL"),"_","","ALL"),"|"))>
         <cfoutput>
            <table cellspacing="0">
               <tr>
                  <td style="padding-right:10px;border-bottom:1px solid gray;">&nbsp;</td>
                  <td bgcolor="##E9E9E9" style="padding-left:10px;padding-right:10px;border-bottom:1px solid gray;"><b>#SFLANG['NewData']#</b></td>
               </tr>
               <cfset scProc[irow]["scChanges"]=structNew()>
               <cfloop index="ifld" list="#qData.columnlist#">
                  <cfif StructKeyExists(scReq,ifld) and not listfindnocase(lsExcField,ifld)>
                  <cfset LOCAL.newData=scReq[ifld]>
                  <cfset scProc[irow][ifld]=newData>
                  <cfif IsDefined("lsLU_#ifld#")>
                  <cfset LOCAL.lstLU=evaluate("lsLU_#ifld#")>
                  <cfif len(newData)>
                     <cfset LOCAL.ndx=listContainsNoCase(lstLU,newData & "=","|")>
                     <cfif ndx>
                        <cfset newData=listRest(listGetAt(lstLU,ndx,"|"),"=")>
                     </cfif>
                  </cfif>
                  <cfelseif StructKeyExists(REQUEST,"qLU_#ifld#")>
                  <cfif len(newData)>
                     <cfquery name="LOCAL.qLUData" dbtype="query">
                        SELECT * FROM REQUEST.qLU_#ifld#
                        WHERE optvalue=#val(newData)#
                     </cfquery>
                     <cfif qLUData.recordcount>
                        <cfset newData=qLUData.opttext>
                     </cfif>
                  </cfif>
        </cfif>
        <cfset scProc[irow]["scChanges"][ifld]["new"]=newData>
        <tr><td class="inpnote" bgcolor="##E9E9E9" style="padding-left:5px;padding-right:5px;border-bottom:1px solid gray;">#SFLANG['FD#Replace(lcase(ifld),"_","","ALL")#']#</td>
        <td class="inpnote" style="border-bottom:1px solid gray;padding-right:5px;"><cfif IsDate(newData)>#DateFormat(newData,"mm/dd/yyyy")#<cfelse>#Application.SFUtil.NoBlank(newData)#</cfif></td>
        </tr>
        </cfif>
        </cfloop>
        </table>
        </cfoutput>
        </cfif>
        </cfif>
        <cfreturn scProc--->
   </cffunction>
   
    <cffunction name="getAddressMigrate">
        <cfparam name="emp_no" default="">
        <cfparam name="EMP_NAME" default="">
        <cfparam name="ADDRESS_TYPE" default="">
        <cfparam name="address" default="">
        <cfparam name="rt" default="">
        <cfparam name="rw" default="">
        <cfparam name="subdistrict_name" default="">
        <cfparam name="district_name" default="">
        <cfparam name="city_name" default="">
        <cfparam name="state_name" default="">
        <cfparam name="country_name" default="">
        <cfparam name="ZIPCODE" default="">
        <cfparam name="phone" default="">
        <cfparam name="LIVING_STATUS" default="">
        <cfparam name="OWNER_STATUS" default="">
        <cfparam name="address_distance" default="">
        <cfinclude template="#Application.PATH.CFINC#/include/_initdata.cfm">
        <cfset LOCAL.arrValue = ArrayNew(1) />
        <cfset LOCAL.arrParam = ArrayNew(1) />
        <cfsavecontent variable="sqlQuery">
         <cfoutput>
            SELECT emp_no,
            <!---first_name #REQUEST.dbstrconcat# ' ' #REQUEST.dbstrconcat# middle_name #REQUEST.dbstrconcat# ' ' #REQUEST.dbstrconcat# last_name AS EMP_NAME,--->
            full_name AS EMP_NAME,
            pos_name_#REQUEST.SCookie.LANG# AS pos_name,
            TEOMADDRESSTYPE.name_#REQUEST.SCookie.LANG# AS ADDRESS_TYPE,
            address,
            rt,
            rw,
            subdistrict_name,
            district_name,
            city_name,
            state_name,
            country_name,
            TEODEMPADDRESS.zipcode AS ZIPCODE,
            phone,
            TEOMSTAYSTATUS.name_#REQUEST.SCookie.LANG# AS LIVING_STATUS,
            TEOMOWNERSTATUS.name_#REQUEST.SCookie.LANG# AS OWNER_STATUS,
            address_distance
            FROM TEODEMPADDRESS 
            LEFT JOIN TEODEMPCOMPANY ON TEODEMPADDRESS.emp_id = TEODEMPCOMPANY.emp_id 
            LEFT JOIN TEOMEMPPERSONAL ON TEODEMPADDRESS.emp_id = TEOMEMPPERSONAL.emp_id 
            LEFT JOIN TEOMADDRESSTYPE ON TEODEMPADDRESS.addresstype_code = TEOMADDRESSTYPE.code 
            LEFT JOIN TGEMSUBDISTRICT ON TEODEMPADDRESS.subdistrict = TGEMSUBDISTRICT.subdistrict_id 
            LEFT JOIN TGEMDISTRICT ON TEODEMPADDRESS.district = TGEMDISTRICT.district_id 
            LEFT JOIN TGEMCITY ON TEODEMPADDRESS.city_id = TGEMCITY.city_id 
            LEFT JOIN TGEMSTATE ON TEODEMPADDRESS.state_id = TGEMSTATE.state_id 
            LEFT JOIN TGEMCOUNTRY ON TEODEMPADDRESS.country_id = TGEMCOUNTRY.country_id 
            LEFT JOIN TEOMSTAYSTATUS ON TEODEMPADDRESS.living_status = TEOMSTAYSTATUS.code 
            LEFT JOIN TEOMOWNERSTATUS ON TEODEMPADDRESS.owner_status = TEOMOWNERSTATUS.code
            LEFT JOIN TEOMPOSITION ON TEODEMPCOMPANY.position_id=TEOMPOSITION.position_id
            WHERE	TEODEMPCOMPANY.company_id = #REQUEST.SCookie.COID#
            <cfif len(emp_no)>#vopr# emp_no LIKE '%#emp_no#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#emp_no#%"></cfif>
            <cfif len(EMP_NAME)>#vopr# full_name LIKE '%#EMP_NAME#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#EMP_NAME#%"></cfif>
            <cfif len(ADDRESS_TYPE)>#vopr# TEOMADDRESSTYPE.name_#REQUEST.SCookie.LANG# LIKE '%#ADDRESS_TYPE#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#ADDRESS_TYPE#%"></cfif>
            <cfif len(address)>#vopr# address LIKE '%#address#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#address#%"></cfif>
            <cfif len(rt)>#vopr# rt LIKE '%#rt#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#rt#%"></cfif>
            <cfif len(rw)>#vopr# rt LIKE '%#rw#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#rw#%"></cfif>
            <cfif len(subdistrict_name)>#vopr# subdistrict_name LIKE '%#subdistrict_name#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#subdistrict_name#%"></cfif>
            <cfif len(district_name)>#vopr# subdistrict_name LIKE '%#district_name#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#district_name#%"></cfif>
            <cfif len(city_name)>#vopr# city_name LIKE '%#city_name#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#city_name#%"></cfif>
            <cfif len(state_name)>#vopr# state_name LIKE '%#state_name#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#state_name#%"></cfif>
            <cfif len(country_name)>#vopr# country_name LIKE '%#country_name#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#country_name#%"></cfif>
            <cfif len(ZIPCODE)>#vopr# TEODEMPADDRESS.zipcode LIKE '%#ZIPCODE#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#ZIPCODE#%"></cfif>
            <cfif len(phone)>#vopr# phone LIKE '%#phone#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#phone#%"></cfif>
            <cfif len(LIVING_STATUS)>#vopr# TEOMSTAYSTATUS.name_#REQUEST.SCookie.LANG# LIKE '%#LIVING_STATUS#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#LIVING_STATUS#%"></cfif>
            <cfif len(OWNER_STATUS)>#vopr# TEOMOWNERSTATUS.name_#REQUEST.SCookie.LANG# LIKE '%#OWNER_STATUS#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#OWNER_STATUS#%"></cfif>
            <cfif len(address_distance)>#vopr# address_distance LIKE '%#address_distance#%' <cfset arrParam[ArrayLen(arrParam)+1]="%#address_distance#%"></cfif>
            ORDER BY 
            <cfif len(fsort)>
               #fsort#
               <cfelse>
               EMP_NAME
            </cfif>
         </cfoutput>
      </cfsavecontent>
      <cfset LOCAL.objModel = CreateObject("component", "SMAddress") />
      <cfset LOCAL.bResult = objModel.RunQuery(sqlQuery, arrValue, rps * cpage) />
      <cfif bResult.QueryResult>
         <cfset LOCAL.qData = objModel.mRecordlist />
         <cfset LOCAL.vSQL = objModel.mStruct />
      </cfif>
      <cfset LOCAL.pid="emp_no">
      <cfset LOCAL.pDSN=REQUEST.SDSN>
      <cfset datatype = {}>
      <cfset dataarray = "arrData">
      <cfinclude template="#Application.PATH.CFINC#/include/_closedata.cfm">
   </cffunction>
   <cffunction name="refAddType">
      <cfparam name="emp_id" default="">
      <cfparam name="addresstype_code" default="">
      <cfquery name="qLookup" datasource="#Request.SDSN#">
         SELECT c.code optvalue,c.name_#REQUEST.SCOOKIE.LANG# opttext 
         FROM TEOMADDRESSTYPE c
         WHERE 1=1
         <cfif Len(addresstype_code)>
            <!---Action Edit--->
            AND c.code = 
            <cfqueryparam value="#addresstype_code#" cfsqltype="cf_sql_varchar">
            <cfelse>
            <!---Action Add--->
            AND c.code NOT IN (SELECT DISTINCT(b.addresstype_code)
            FROM TEOMADDRESSTYPE a
            LEFT JOIN TEODEMPADDRESS b ON b.addresstype_code = a.code
            WHERE b.emp_id = 
            <cfqueryparam value="#URL.emp_id#" cfsqltype="cf_sql_varchar">
            )
         </cfif>
         ORDER BY c.order_no
      </cfquery>
      <cfreturn qLookup>
   </cffunction>
   <cffunction name="viewEmp">
      <cfparam name="URL.emp_id" default="">
      <cfquery name="qView" datasource="#Request.SDSN#">
         select full_name,ec.emp_id,ec.emp_no from TEOMEmpPersonal emp
         inner join TEODEMPCompany ec on ec.emp_id=emp.emp_id
         WHERE ec.emp_id = 
         <cfqueryparam value="#URL.emp_id#" cfsqltype="cf_sql_varchar">
      </cfquery>
      <!---<cf_sfwritelog dump="qView" ext="html" prefix="datasourcenamexx_">--->
      <cfreturn qView>
   </cffunction>
</cfcomponent>















