<cfcomponent displayname="SFAttendanceLocation" hint="SunFish Attendance Location Business Process Object" extends="SFBP">	
    <cfset Init("TA","AttendanceLocation","TTAMATTLOCATION","attendance location","location_code,company_id","location_code","location_code,location_name")>

    <cffunction name="Listing">
		<!--- Passing Parameter --->
		<cfset LOCAL.scParam=paramRequest()>
		<!--- Query Field Definition --->
		<cfset LOCAL.lsField="location_code, location_name, lat_lng, company_id">
		<cfif request.dbdriver eq "ORACLE">
			<cfset lsField = lsField & " ,NVL2(lat_lng, '1', '0') maps">
		<cfelse>
			<cfset lsField = lsField & " ,(CASE WHEN lat_lng is null then '0' WHEN lat_lng is not null then '1' END) maps">
		</cfif>
		<!--- Table Join Definition --->
		<cfset LOCAL.lsTable="TTAMATTLOCATION">
		<!--- Query Filter Definition --->
		<cfset LOCAL.lsFilter="company_id=#val(REQUEST.SCookie.COID)#">
		<cfset ListingData(scParam,{fsort="location_name",lsField=lsField,lsFilter=lsFilter,lsTable=lsTable,pid="location_code"})>
	</cffunction>

    <cffunction name="Add">
		<cfparam name="location_code" default="">
		<cfparam name="company_id" default="">
		<cfparam name="location_name" default="">
		<cfset LOCAL.strckData = FORM/>
				
		<cfset strckData["company_id"] = REQUEST.scookie.COID/>
        <cfset strckData["city_id"] = hdn_city_id/>
		<cfset strckData["state_id"] = hdn_state_id/>
		<cfset strckData["country_id"] = hdn_country_id/>
		<cfset strckData["destination_code"] = hdn_destination_code/>
		
		
		<cfquery name="LOCAL.qCheckLocationCode" datasource="#REQUEST.SDSN#">
			select location_code from TTAMATTLOCATION
			WHERE company_id = <cfqueryparam value="#REQUEST.Scookie.COID#" cfsqltype="cf_sql_integer">
			AND location_code = <cfqueryparam value="#strckData['location_code']#" cfsqltype="cf_sql_varchar">
		</cfquery>
        
        <cfif qCheckLocationCode.recordcount eq 0>
			<cfquery name="LOCAL.qInsertAttLocation" datasource="#REQUEST.SDSN#">
    		    INSERT INTO TTAMATTLOCATION
                    (
                        location_code,
                        company_id,
                        location_name,
                        location_address,
                        country_id,
                        state_id,
                        city_id,
                        max_radius,
                        created_date,
                        created_by,
                        modified_date,
                        modified_by,
                        gmt_id,
                        destination_code
                    )VALUES(
                        <CFQUERYPARAM VALUE="#strckData['location_code']#" CFSQLTYPE="CF_SQL_VARCHAR">,
                        <CFQUERYPARAM VALUE="#REQUEST.Scookie.COID#" CFSQLTYPE="CF_SQL_INTEGER">,
                        <CFQUERYPARAM VALUE="#strckData['location_name']#" CFSQLTYPE="CF_SQL_VARCHAR">,
                        <CFQUERYPARAM VALUE="#strckData['location_address']#" CFSQLTYPE="CF_SQL_VARCHAR">,
                        <CFQUERYPARAM VALUE="#strckData['country_id']#" CFSQLTYPE="CF_SQL_BIGINT">,
                        <CFQUERYPARAM VALUE="#strckData['state_id']#" CFSQLTYPE="CF_SQL_INTEGER">,
                        <CFQUERYPARAM VALUE="#strckData['city_id']#" CFSQLTYPE="CF_SQL_INTEGER">,
                        <CFQUERYPARAM VALUE="#strckData['max_radius']#" CFSQLTYPE="CF_SQL_DECIMAL" SCALE="4">,
                        <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                        <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                        <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                        <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                        <CFQUERYPARAM VALUE="#strckData['gmt_id']#" CFSQLTYPE="CF_SQL_INTEGER">,
                        <CFQUERYPARAM VALUE="#strckData['destination_code']#" CFSQLTYPE="CF_SQL_VARCHAR">
                    )
    		</cfquery>
    		
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Add Location",true)>
			<cfoutput>
			<script>
				sfalert("#SFLANG#");
				//popClose();
				refreshPage();
			</script>
			</cfoutput>
		<cfelseif qCheckLocationCode.recordcount neq 0>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSLocation Code Already Exist! ",true)>
			<cfoutput>
			<script>
				alert("#SFLANG#");
				//frmAttLocation.inp_location_code.focus();
			</script>
			</cfoutput>
        <cfelse>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSFailed Add Location",true)>
			<cfoutput>
			<script>
				sfalert("#SFLANG#");
				//popClose();
				refreshPage();
			</script>
			</cfoutput>
        </cfif>
	</cffunction>
	
    <cffunction name="generate">
        <!--- Proccess generate data from personal information address to attendance location --->
        <!--- get data from personal information address --->
        <cfquery name="qGetPersonalAddress" datasource="#REQUEST.SDSN#">
            SELECT 
                EP.LASTREQNO AS LASTREQNO, EA.ADDRESS AS ADDRESS, EA.CITY_ID AS CITY_ID, EA.STATE_ID AS STATE_ID, EA.COUNTRY_ID AS COUNTRY_ID, EA.LAT_LNG AS LAT_LNG
            FROM 
                TEOMEMPPERSONAL EP INNER JOIN TEODEMPADDRESS EA ON EP.EMP_ID = EA.EMP_ID 
            WHERE
                EA.ADDRESSTYPE_CODE = 'A' AND EA.LAT_LNG != ''  
        </cfquery>

        <!--- Insert data --->
        <cfloop query="qGetPersonalAddress">
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
                    <CFQUERYPARAM VALUE="#qGetPersonalAddress.LAT_LNG#" CFSQLTYPE="CF_SQL_DECIMAL" SCALE="4">,
                    <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                    <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                    <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                    <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                    30,
                    null
                )
            </cfquery>
        </cfloop>
        <!--- End proccess --->
    </cffunction>

	<cffunction name="Save">
		<cfsetting showdebugoutput="no" enablecfoutputonly="Yes">
		<cfparam name="location_code" default="">
		<cfparam name="company_id" default="">
		<cfparam name="location_name" default="">
		<cfset LOCAL.strckData = FORM/>
        <cfset strckData["company_id"] = REQUEST.scookie.COID/>
       	<cfset strckData["city_id"] = hdn_city_id/>
		<cfset strckData["state_id"] = hdn_state_id/>
		<cfset strckData["country_id"] = hdn_country_id/>
		<cfset strckData["destination_code"] = hdn_destination_code/>
		<cfquery name="LOCAL.qUpdateAttLocation" datasource="#REQUEST.SDSN#">
		    UPDATE TTAMATTLOCATION
		    SET location_name = <CFQUERYPARAM VALUE="#strckData['location_name']#" CFSQLTYPE="CF_SQL_VARCHAR">,
                location_address = <CFQUERYPARAM VALUE="#strckData['location_address']#" CFSQLTYPE="CF_SQL_VARCHAR">,
                country_id = <CFQUERYPARAM VALUE="#strckData['country_id']#" CFSQLTYPE="CF_SQL_BIGINT">,
                state_id = <CFQUERYPARAM VALUE="#strckData['state_id']#" CFSQLTYPE="CF_SQL_INTEGER">,
                city_id = <CFQUERYPARAM VALUE="#strckData['city_id']#" CFSQLTYPE="CF_SQL_INTEGER">,
                max_radius = <CFQUERYPARAM VALUE="#strckData['max_radius']#" CFSQLTYPE="CF_SQL_DECIMAL" SCALE="4">,
                modified_date = <CFQUERYPARAM VALUE="#now()#" CFSQLTYPE="CF_SQL_TIMESTAMP">,
                modified_by = <CFQUERYPARAM VALUE="#Request.scookie.user.uname#" CFSQLTYPE="CF_SQL_VARCHAR">,
                gmt_id = <CFQUERYPARAM VALUE="#strckData['gmt_id']#" CFSQLTYPE="CF_SQL_INTEGER">,
                destination_code = <CFQUERYPARAM VALUE="#strckData['destination_code']#" CFSQLTYPE="CF_SQL_VARCHAR">
            WHERE location_code = <CFQUERYPARAM VALUE="#strckData['location_code']#" CFSQLTYPE="CF_SQL_VARCHAR">
            AND company_id = <CFQUERYPARAM VALUE="#REQUEST.Scookie.COID#" CFSQLTYPE="CF_SQL_INTEGER">
		</cfquery>
		
		<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Save Location",true)>
		<cfoutput>
			<script>
				sfalert("#SFLANG#");
				//popClose();
				refreshPage();
			</script>
		</cfoutput>
	</cffunction>
	
	<cffunction name="Delete">
		<cfparam name="location_code" default="">
		<cfparam name="company_id" default="">
		
		<cfset LOCAL.strckData = FORM />
		<cfquery name="LOCAL.qCekData" datasource="#REQUEST.SDSN#">
			SELECT TTAMATTLOCATION.location_code,TTAMATTLOCATION.location_name,TTAMATTLOCATION.company_id,TTADEMPLOCATION.emp_id
            FROM TTAMATTLOCATION
            LEFT JOIN 
                TTADEMPLOCATION ON TTADEMPLOCATION.location_code = TTAMATTLOCATION.location_code 
                AND TTADEMPLOCATION.company_id = TTAMATTLOCATION.company_id
            WHERE TTAMATTLOCATION.location_code = <cfqueryparam value="#location_code#" CFSQLType="cf_sql_varchar">
            AND TTAMATTLOCATION.company_id = <cfqueryparam value="#company_id#" CFSQLType="cf_sql_varchar">
            AND TTADEMPLOCATION.emp_id IS NOT NULL
		</cfquery>
		<cfif qCekData.recordcount eq 0>
			<cfquery name="LOCAL.qDeleteLocation" datasource="#REQUEST.SDSN#">
    			DELETE FROM TTAMATTLOCATION
    			WHERE location_code = <cfqueryparam value="#location_code#" CFSQLType="cf_sql_varchar">
    			AND company_id = <cfqueryparam value="#company_id#" CFSQLType="cf_sql_integer">
		    </cfquery>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Delete Attendance Location",true)>
			<cfoutput>
			<script>
				alert("#SFLANG#");
				popClose();
				refreshPage();
			</script>
			</cfoutput>
		<cfelse>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("Failed Delete Attendance Location. Attendance Location is in use",true)>
			<cfoutput>
				<script>
					alert("#SFLANG#");
					popClose();
					refreshPage();
				</script>
			</cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="DeleteMaps">
		<cfquery name="qryMapsDefined" datasource="#REQUEST.SDSN#">
			<cftransaction>
				SELECT TTAMATTLOCATION.lat_lng
				  FROM TTAMATTLOCATION
				 WHERE company_id 			= <cfqueryparam value="#REQUEST.SCookie.COID#" CFSQLType="cf_sql_integer">
				   AND location_code	= <cfqueryparam value="#location_code#" CFSQLType="cf_sql_varchar">
			</cftransaction>
		</cfquery>
		
		<cfif isdefined("qryMapsDefined.lat_lng") AND Len(Trim(qryMapsDefined.lat_lng))>
			<cfquery name="qryMaps" datasource="#REQUEST.SDSN#">
				<cftransaction>
					UPDATE TTAMATTLOCATION
					   SET TTAMATTLOCATION.lat_lng = NULL
						   ,created_date = TTAMATTLOCATION.created_date
						   ,created_by = TTAMATTLOCATION.created_by
						   ,modified_date = #CreateODBCDateTime(Now())#
					       ,modified_by   = '#REQUEST.Scookie.User.Uname#'
					 WHERE company_id 			= <cfqueryparam value="#REQUEST.SCookie.COID#" CFSQLType="cf_sql_integer">
					   AND location_code	= <cfqueryparam value="#location_code#" CFSQLType="cf_sql_varchar">
				</cftransaction>
			</cfquery>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Delete Maps Attendance Location",true)>
			<cfoutput>
				<script>
					alert("#SFLANG#");
					popClose();
					refreshPage();
				</script>
			</cfoutput>
		<cfelse>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSMaps Not Defined Attendance Location",true)>
			<cfoutput>
				<script>
					alert("#SFLANG#");
				</script>
			</cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="ViewMaps">
    	<cfparam name="location_code" default="">
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
    
    	<cfparam name="location_code" default="">
    
    	<cfquery name="qAddr" datasource="#REQUEST.SDSN#">
    		SELECT TTAMATTLOCATION.location_code,
    			   TTAMATTLOCATION.location_name,
    			   TTAMATTLOCATION.lat_lng,
    			   TEOMCOMPANY.company_name,	
    			   TTAMATTLOCATION.location_address address,
    			   TGEMCITY.city_name First_Name,
    			   TGEMSTATE.state_name Middle_Name,
    			   TGEMCOUNTRY.country_name Last_Name
    		  FROM TTAMATTLOCATION,
    			   TGEMCITY,
    			   TGEMSTATE,
    			   TGEMCOUNTRY,
    			   TEOMCOMPANY
    		 WHERE TGEMCITY.city_id  		= TTAMATTLOCATION.city_id	 
    		   AND TGEMCITY.state_id		= TGEMSTATE.state_id
    		   AND TGEMCITY.country_id		= TGEMCOUNTRY.country_id
    		   AND TGEMSTATE.state_id		= TTAMATTLOCATION.state_id
    		   AND TGEMSTATE.country_id 	= TGEMCOUNTRY.country_id 
    		   AND TGEMCOUNTRY.country_id 	= TTAMATTLOCATION.country_id
    		   AND TEOMCOMPANY.company_id	= TTAMATTLOCATION.company_id
    		   AND TTAMATTLOCATION.location_code = <cfqueryparam value="#location_code#" cfsqltype="cf_sql_varchar">
    		   AND TTAMATTLOCATION.company_id		  = <cfqueryparam value="#REQUEST.Scookie.COID#" cfsqltype="cf_sql_integer">
    	</cfquery>
    
    
    	<cfset nickName=''>
    	<cfset space=','>
    	<cfif isdefined("qAddr.First_Name") AND Len(Trim(qAddr.First_Name))><cfset nickName = qAddr.First_Name></cfif>
    	<cfif isdefined("qAddr.Middle_Name") AND Len(Trim(qAddr.Middle_Name))><cfset nickName = nickName & space &qAddr.Middle_Name></cfif>
    	<cfif isdefined("qAddr.Last_Name") AND Len(Trim(qAddr.Last_Name))><cfset nickName = nickName & space & qAddr.Last_Name></cfif>
    	<cfset inputLatLng=''>
    	<cfif isdefined("qAddr.lat_lng") AND Len(Trim(qAddr.lat_lng))><cfset inputLatLng=qAddr.lat_lng></cfif>
    
    	<cfset inputAddress=''>
    	<cfif isdefined("qAddr.address") AND Len(Trim(qAddr.address))><cfset inputAddress=qAddr.address></cfif>
    	<cfif isdefined("nickName") AND Len(Trim(nickName))>
    		<cfif isdefined("inputAddress") AND Len(Trim(inputAddress))>
    			<cfset inputAddress = inputAddress & space & nickName>
    		<cfelse>
    			<cfset inputAddress = nickName>
    		</cfif>	
    	</cfif>
    
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
    			<tr>
    			
    			</tr>
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
    
    
    
    	var qinick = "#HTMLEditFormat(JSStringFormat(qAddr.location_name))#";
    	var qiaddress = "#HTMLEditFormat(JSStringFormat(inputAddress))#";
    	var qilatlng = "#HTMLEditFormat(JSStringFormat(inputLatLng))#";
    
    	setWindowSize();
    	function loadGMAPI() {
    		var script = document.createElement("script");
    		script.type = "text/javascript";
    		script.src = "<cfif CGI.HTTPS eq 'on'>https<cfelse>https</cfif>://maps.googleapis.com/maps/api/js?key=AIzaSyDJVSYDwO5XHgH39bCnz265eoBd1fOBls0&sensor=false&callback=initialize";
    		document.body.appendChild(script);
    // 		console.log("masuk load");
    	}
    
    	function initialize() {
    	   // console.log("masuk initialize");
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
    		google.maps.event.addListener(map, 'click', function() {
    		  gInfoWindow.close();  
    		});
    		google.maps.event.addListener(marker, 'click', function() {
    		  gInfoWindow.open(map, marker);  
    		}); 
    		google.maps.event.addListener(marker, 'drag', function() {
    			<!---/*('Dragging...')*/--->
    			gInfoWindow.close();
    			//updateMarkerPosition(marker.getPosition());
    		});
    		google.maps.event.addListener(marker, 'dragend', function() {
    			<!---/*('Drag ended')*/--->
    			updateMarkerPosition(marker.getPosition());
    			geocodePosition(marker.getPosition());
    		});
    		google.maps.event.addListener(map, 'zoom_changed', function() {
    		  setTimeout(function(){
    			marker.setPosition(marker.getPosition());
    		  },10);
    		});
    		google.maps.event.addListener(map, 'dblclick', function() {
    		  setTimeout(function(){
    			marker.setPosition(marker.getPosition());
    		  },10);
    		});
    		
    		setTimeout(function(){
    		  if(qilatlng!==''){
    			  chklatlng.checked = true;
    			 // console.log("latlng exist ");
    			  codeLatLng(qilatlng);
    			  // geocodeLatLng(qilatlng,map,gInfoWindow);
    		  }
    		  else if(qiaddress!==''){
    			  codeAddress(qiaddress);
    			 // console.log("address exist");
    		  }
    		},100);
    	}
    
    	function loadDefaultMarker(){
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
			  
			// console.log("'" + args[0] + "', '" +  args[1] + "'");

			if(lat.test(args[0].trim()) == true && lon.test(args[1].trim()) == true){ 
			//	console.log("Prana1");
				return true;
			} else{
			//	console.log("PRN2");
				return false;
			}
		}
		
    	function codeAddress(qiaddress) {
    	    // console.log('test');
    		gInfoWindow.close();
    		if(qiaddress==='' || typeof(qiaddress)==='undefined'){	
    			var qiaddress = document.getElementById("txtaddress").value;
    		}
    		var arrqiaddress = qiaddress.split(",");
			if(isValidCoordinates(qiaddress)) {
			    // console.log('if');
				codeLatLng(qiaddress);
			} else {
			    //console.log('else');
			    geocoder.geocode( { 'address': qiaddress}, function(results, status) {
                  setTimeout(function(){
                	if(status == google.maps.GeocoderStatus.OK) {
                		map.setCenter(results[0].geometry.location);
                		map.setZoom(15);
                		setTimeout(function(){
                		  marker.setPosition(results[0].geometry.location);
                		  updateMarkerPosition(marker.getPosition());
                		},10);
                
                		gInfoWindow.setContent(formatHtml(results[0].formatted_address));
                	}
                	else {
                		<!---/*Geocode was not successful. No results found, try again*/--->
                		if(arrqiaddress.length > 1){
                			qiaddress='';
                			for(var q=1;q<arrqiaddress.length;q++)
                			{	
                				if(arrqiaddress[q] !== ''){
                				  if(q>1){ 
                					qiaddress+=',';
                				  }
                				  qiaddress += arrqiaddress[q];
                				}
                			}
                			codeAddress(qiaddress);
                		}
                		else {
                			alert("No results found");
                			loadDefaultMarker();
                		}
                	}
                  },200);
                });
			}
    	}
    	
    	function codeLatLng(setlatlang) {
    		var input = setlatlang;
    		var latlngStr = input.split(",",2);
    		var lat = parseFloat(latlngStr[0]);
    		var lng = parseFloat(latlngStr[1]);
    		var latlng = new google.maps.LatLng(lat, lng);
    		geocoder.geocode({'latLng': latlng}, function(results, status) {
    		  setTimeout(function(){
    			if (status == google.maps.GeocoderStatus.OK) {
    				if (results[1]) {
    					map.setCenter(latlng);
    					map.setZoom(15);
    					setTimeout(function(){
    					  marker.setPosition(latlng);
    					  updateMarkerPosition(marker.getPosition());
    					},10);
    					gInfoWindow.setContent(formatHtml(results[0].formatted_address));
    				}
    				else {
    					alert("No results found");
    				}
    			}
    			else {
    				alert("No results found");
    			}
    		  },100);
    		});
    	}
    
    	function geocodePosition(pos) {
    		geocoder.geocode({
    			latLng: pos
    		}, function(responses) {
    			if (responses && responses.length > 0) {
    				gInfoWindow.setContent(formatHtml(responses[0].formatted_address));
    			} 
    			else {
    				gInfoWindow.setContent('<div>Cannot determine address at this location.</div>');
    			}
    		});
    	}
    
    	function formatHtml(address_) {
    	  return '<div class="address">'+address_+'</div>\n<br/><span onclick="zoomIn(\'gmzoom1\');" style="color: ##0000FF; cursor: pointer; text-decoration: underline;">Zoom in</span>';
    	}
    
    	function zoomIn(request){
    	  switch(request){
    		case 'gmzoom1':
    		  {	gInfoWindow.close();
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
    		if(document.getElementById('txtlatlng')!==null){
    			document.getElementById('txtlatlng').value = [latLng.lat(),latLng.lng()].join(',');
    		}
    	}
    
    	function setWindowSize(){
    		if (typeof window.innerHeight != 'undefined')
    		{		//viewportwidth = window.innerWidth;
    			viewportheight = window.innerHeight;
    		}
    		<!---/*IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)*/--->
    		else if (typeof document.documentElement != 'undefined'
    				&& typeof document.documentElement.clientHeight != 'undefined' 
    				&& document.documentElement.clientHeight != 0)
    		{		//viewportwidth = document.documentElement.clientWidth;
    			viewportheight = document.documentElement.clientHeight;
    		}
    		<!---/*older versions of IE*/--->
    		else
    		{		//viewportwidth = document.getElementsByTagName('body')[0].clientWidth;
    			viewportheight = document.getElementsByTagName('body')[0].clientHeight;
    		}
    		document.getElementById("map_canvas").style.height=(viewportheight-73)+"px";
    	}
    	<!---/*Onload handler to fire off the app.*/--->
    	loadGMAPI();
    	</script>
    	</cfoutput>
	</cffunction>
	
	<cffunction name="SaveMaps">
		<cfparam name="txtlatlng" default="">
		<cfset LOCAL.strckData = FORM/>
		<cfset TTAMATTLOCATIONlocation_code = strckData["location_code"] >
		<cfset txtlatlng		 = strckData["txtlatlng"] >
		<cfif isdefined("txtlatlng") AND Len(Trim(txtlatlng))>
		
			<cfquery name="qryMaps" datasource="#REQUEST.SDSN#">
				<cftransaction>
					UPDATE TTAMATTLOCATION
					   SET TTAMATTLOCATION.lat_lng = <cfqueryparam value="#txtlatlng#" CFSQLType="cf_sql_varchar">
						   ,created_date  = TTAMATTLOCATION.created_date
						   ,created_by 	  = TTAMATTLOCATION.created_by   	
						   ,modified_date = #CreateODBCDateTime(Now())#
						   ,modified_by   = '#REQUEST.Scookie.User.Uname#'
					 WHERE company_id 			= <cfqueryparam value="#REQUEST.SCookie.COID#" CFSQLType="cf_sql_integer">
					   AND location_code	= <cfqueryparam value="#location_code#" CFSQLType="cf_sql_varchar">
				</cftransaction>
			</cfquery>

			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Save Maps Location",true)>
			<cfoutput>
				<script>
					alert("#SFLANG#");
					popClose();
					refreshPage();
				</script>
			</cfoutput>
		<cfelse>
			<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSMaps Not Defined Location",true)>
			<cfoutput>
				<script>
					alert("#SFLANG#");
				</script>
			</cfoutput>
		</cfif>
	</cffunction>
	
	<!---start: attendance location--->
	<cffunction name="getDestinationLocation">
		<!--- Passing Parameter --->
		<cfset LOCAL.scParam=paramRequest()>
		<!--- Query Field Definition --->
		<cfset LOCAL.lsField="code, name_#request.SCookie.LANG# destination_name, 1 as set_dest">
		<!--- Table Join Definition --->
		<cfset LOCAL.lsTable="ttamoddestination">
		<!--- Query Filter Definition --->
		<cfset LOCAL.lsFilter="">
		<cfset ListingData(scParam,{fsort="name_en",lsField=lsField,lsTable=lsTable,pid="code"})>
	</cffunction>
	
	<cffunction name="viewDestinationLocation">
		<cfparam name="destination_code" default="">
		<cfquery name="local.qView" datasource="#REQUEST.SDSN#">			
			SELECT code, name_#request.SCookie.LANG# destination_name
			FROM ttamoddestination
			WHERE code = <cfqueryparam value="#destination_code#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn qView>
	</cffunction>
	
	<cffunction name="referenceLocation">
		<cfquery name="LOCAL.qLookup" datasource="#REQUEST.SDSN#">
			SELECT location_code optvalue,location_name opttext FROM TTAMATTLOCATION
			WHERE company_id = <cfqueryparam value="#request.scookie.coid#" cfsqltype="cf_sql_integer">
			ORDER BY location_name
		</cfquery> 
		<cfreturn qLookup>
	</cffunction>
	
	<cffunction name="showEdit">
		<cfparam name="destination_code" default="">
		<cfquery name="qShowEdit" datasource="#REQUEST.SDSN#">			
			SELECT location_code, location_name 
			FROM TTAMATTLOCATION
			WHERE company_id = <cfqueryparam value="#request.scookie.coid#" cfsqltype="cf_sql_integer">
			AND destination_code = <cfqueryparam value="#destination_code#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn qShowEdit>
	</cffunction>
	
	<cffunction name="SaveAttDestination">
	    <cfparam name="code" default="">
	    <cfparam name="hdn_grc_AttendanceLocation" default="">
		<cfparam name="first_count" default="0">
		<cfif first_count neq 0>
			<cfset listSave = listDeleteAt(hdn_grc_AttendanceLocation,listFind(hdn_grc_AttendanceLocation,first_count,","),",")>
		<cfelse>
			<cfset listSave = hdn_grc_AttendanceLocation>
		</cfif>
		<cfset strckData = FORM/>
		<cfset strckData['code'] = code/>
		
		<!----cf_sfwritelog dump="strckData" folder="GD_LOCATION" prefix="getObj_"--->
		<cftransaction>
		    <cfquery name="qDelDestination" datasource="#REQUEST.SDSN#">			
    			UPDATE TTAMATTLOCATION
    			SET destination_code = null
    			WHERE company_id = <cfqueryparam value="#request.scookie.coid#" cfsqltype="cf_sql_integer">
    			AND destination_code = <cfqueryparam value="#code#" cfsqltype="cf_sql_varchar">
    		</cfquery>
    		
		    <cfloop list="#listSave#" index="idx">
		        <cfif isDefined("grow_#idx#_AttendanceLocation_location_code")>
		            <cfquery name="qUpdDestination" datasource="#REQUEST.SDSN#">			
            			UPDATE TTAMATTLOCATION
            			SET destination_code = <cfqueryparam value="#code#" cfsqltype="cf_sql_varchar">
            			WHERE company_id = <cfqueryparam value="#request.scookie.coid#" cfsqltype="cf_sql_integer">
            			AND location_code = <cfqueryparam value="#evaluate("grow_#idx#_AttendanceLocation_location_code")#" cfsqltype="cf_sql_varchar">
            		</cfquery>
		        </cfif>
		    </cfloop>
		</cftransaction>
		
		<cfset LOCAL.SFLANG=Application.SFParser.TransMLang("JSSuccessfully Set Attedance Location to Destination",true)>
		<cfoutput>
			<script>
				alert("#SFLANG#");
				popClose();
				refreshPage();
			</script>
		</cfoutput>
	</cffunction>
	
	<!--- end : attendance location--->
</cfcomponent>    
    
















