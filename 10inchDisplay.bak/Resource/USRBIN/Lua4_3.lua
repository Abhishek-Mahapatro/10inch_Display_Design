--**************************************** MAIN LOOP STARTS HERE ****************************************
hmt.writevp16(0x080188, 0)
hmt.writevp16(0x08018A, 0)
hmt.writevp16(0x08018C, 0)
hmt.writevp16(0x08018E, 0)
hmt.writevp16(0x080190, 0)
hmt.writevp16(0x080192, 0)
hmt.writevp16(0x08003A, 1)
hmt.writevp16(0x080038, 50)
hmt.writevp16(0x081006, 0)
hmt.writevp16(0x080980, 0)
hmt.writevp16(0x080982, 0)
hmt.writevp16(0x080984, 0)
hmt.writevp16(0x080986, 0)
hmt.writevp16(0x080988, 0)
hmt.writevp16(0x080992, 0)
hmt.writevp16(0x081014, 0)
hmt.writevp16(0x081016, 0)
hmt.writevp16(0x081018, 0)
hmt.writevp16(0x081012, 0)
hmt.writevp16(0x081010, 0)
hmt.writevp16(0x08100E, 0)
hmt.writevp16(0x080104, 0)
hmt.writevp16(0x080106, 0)
hmt.writevp16(0x080108, 0)
hmt.writevp16(0x08010A, 0)
hmt.writevp16(0x08010C, 0)
hmt.writevp16(0x0800C0, 0)
hmt.writevp16(0x080972, 0)
hmt.writevp16(0x08901E, 0)

--*****Making user admin name in popup 0*****
--hmt.writevpstr(0x004980,0)

hmt.writevpstr(0x004980,NULL)
hmt.writevpstr(0x004A00,NULL)

--***** Making user admin status 0 *****
hmt.writevp16(0x082000, 0)
hmt.writevp16(0x082002, 0)
hmt.writevp16(0x082004, 0)
hmt.writevp16(0x082006, 0)
hmt.writevp16(0x082008, 0)
hmt.writevp16(0x08200A, 0)
hmt.writevp16(0x08200C, 0)
hmt.writevp16(0x08200E, 0)
hmt.writevp16(0x082010, 0)
hmt.writevp16(0x082012, 0)
hmt.writevp16(0x082014, 0)
hmt.writevp16(0x082016, 0)
hmt.writevp16(0x082018, 0)
hmt.writevp16(0x08201A, 0)

--***** Read Stop Disable *****
--hmt.writevp16(0x089000, 0)

--***** Read Defog Disable *****
hmt.writevp16(0x089006, 1)

--***** Making Page change keys in user access 0 *****
hmt.writevp16(0x082024, 0)
hmt.writevp16(0x082026, 0)
hmt.writevp16(0x082028, 0)

--***** Making admin default *****
hmt.writevp16(0x0800C8, 0)

--***** Making fill/defog 0 *****
hmt.writevp16(0x08012A, 1)

--***** Making stop 0 *****
hmt.writevp16(0x0890996, 0)

--***** Making resume popup 0 *****
hmt.writevp16(0x089004, 0)

--***** Making admin select default *****
hmt.writevp16(0x0800C6, 0)

--***** Making enable registor for main and battery 0 *****
hmt.writevp16(0x0809A2, 0)
hmt.writevp16(0x0809A4, 0)

hmt.writevp16(0x080996,0)

--***** Making rd graph log enable 0 *****
hmt.writevp16(0x089008, 0)
hmt.writevp16(0x08900A, 0)

--***** Enable Fill key *****
hmt.writevp16(0x08012A, 1)

--***** Making ther. staus enable 0 *****
hmt.writevp16(0x080972, 0)
hmt.writevp16(0x08002C, 0)
hmt.writevp16(0x080070, 0)

--******Login page******
hmt.writevp16(0x0801A2,0)
hmt.writevp16(0x0801A4,0)
hmt.writevp16(0x0801A6,0)

loop_speed=150

twentySecTimer=0
UICommFailure=0	
CommTimeoutErrorCheck=0
PageChangeToHomeFlg=0

PreBuzz=0
PreFillDefog=0
PrePageID=0

local sendbuff = {0xAA,0x30,0x54,0x6F,0x70,0x77,0x61,0x79,0x20,0x48,0x4d,0x54,0x20,0x52,0x65,0x61,0x64,0x79,0x00,0xcc,0x33,0xc3,0x3c}
hmt.uartsendbytes(sendbuff, 23)
local prev_val

--**************************************** MAIN FUNCTION ****************************************
luamain = function(void)

--************ Screen saver Start ***************
	screenSaverT = hmt.readvp16(0x08003C)
	if screenSaverT == 0 then 
		sth = 600
	elseif screenSaverT == 1 then
		sth = 1200
	elseif screenSaverT == 2 then
		sth = 1800
	else
	end
--************ Screen saver End ***************
	pgid =hmt.readpage()

	--************* Check communication time out and page change to home *************
	RTCSec = hmt.readvpreg(0xFFFF15)--RTC Seconds
	if RTCSec == PreRTCsec then
	else
		if CommTimeoutErrorCheck == 4 then

		else
			CommTimeoutErrorCheck=CommTimeoutErrorCheck+1
		end
 		
 		--******** Screen Saver page start **********
		if pgid==0x08 or pgid==0x11 or screenSaverT==3 then --or pgid==0x08 or pgid==0x11
			c=0
		else
			c=c+1
			hmt.writevp16(0x089024,c)
			if c==sth then
				hmt.changepage(0x24)		   
			end
		end
		--******** Screen Saver page end **********
		PreRTCsec=RTCSec
		if Toogle ==0 then
		--hmt.writevp16(0x080974,0)
		Toogle=1
		else
		--hmt.writevp16(0x080974,1)
		Toogle=0
		end 
	end

	if pgid==0x00 then
		hmt.writevpstr(0x004200,null)
		hmt.writevpstr(0x004700,null)
		hmt.writevpstr(0x004300,null)
		hmt.writevpstr(0x004800,null)
		hmt.writevpstr(0x004380,null)
		hmt.writevpstr(0x004880,null)
		hmt.writevpstr(0x004400,null)
		hmt.writevpstr(0x004900,null)
		hmt.writevp16(0x0801A2,0)
		hmt.writevp16(0x0801A4,0)
		hmt.writevp16(0x0801A6,0)		
	end

	--**********Making all touch responses for T2 disable or enable**********
   	T2_High = hmt.readvp16(0x080058) 
    T2_Low = hmt.readvp16(0x08005C)
    T2 = hmt.readvp16(0x080062)
    T2grey = hmt.readvp16(0x08901C)
	if T2 ==1 then
		if T2_High == 1 then
			hmt.writevp16(0x0801B0, 1)
		else
			hmt.writevp16(0x0801B0, 0)
		end
	else
		hmt.writevp16(0x0801B0, 0)
	end
	if T2 ==1 then
		if T2_Low == 1 then
			hmt.writevp16(0x0801B2, 1)
		else
			hmt.writevp16(0x0801B2, 0)
		end
	else
		hmt.writevp16(0x0801B2, 0)
	end

	UIComm = hmt.readvp16(0x08100C)--RTC Blink 
	if UIComm == PreUIComm then
	else
		PreUIComm=UIComm
		CommTimeoutErrorCheck=0
	end

	--************* Checking Communication Failure *************
	--stRePop = hmt.readvp16(0x089004)
	if CommTimeoutErrorCheck==4 then
		PreBuzz 	= hmt.readvp16(0x081000)
		PreFillDefog= hmt.readvp16(0x08012A)
		hmt.writevp16(0x080974,1) -- Communication Faild Icon Enable
		hmt.writevp16(0x080970,0)--Disable 
		hmt.writevp16(0x081008,0)--Warning Key
		hmt.writevp16(0x081000,0)--Buzz Mute 
		hmt.writevp16(0x08012A,0)--Fill defog
		hmt.writevp16(0x089002,0)--Disable

		if PageChangeToHomeFlg==0 then
			PrePageID = hmt.readpage()
			if PrePageID == 74 then
			else
			hmt.changepage(0)
			end
		PageChangeToHomeFlg=1
		end
	else
		hmt.writevp16(0x080974,0)-- Communication Faild Icon Disable
		rst=hmt.readvp16(0x089000)
		rst2=hmt.readvp16(0x089006)
		rst3=hmt.readvp16(0x08900A)
		hmt.writevp16(0x089002,1)
		if rst==1 then
			hmt.writevp16(0x080970,1)
		else
			hmt.writevp16(0x080970,0)
		end
		if rst3==1 then
			hmt.writevp16(0x089008,1)
		else
			hmt.writevp16(0x089008,0)
		end
		if PageChangeToHomeFlg==1 then
			hmt.writevp16(0x081000,Pre1Buzz)
			if rst2==1 then
				hmt.writevp16(0x08012A,1)
			else
				hmt.writevp16(0x08012A,0)
			end
		end
		PageChangeToHomeFlg=0
	end
	hmt.writevp16(0x08008A,CommTimeoutErrorCheck)

	--hmt.writevp16(0x08008C,PreRTCsec)

    T1_only = hmt.readvp16(0x080062)
	if T1_only == 1 then
		hmt.writevp16(0x080166, 0)
		--hmt.writevp16(0x08901C, 0)
	else
		hmt.writevp16(0x080166, 1)
		--hmt.writevp16(0x08901C, 1)
	end
	
 	--************* Thermistor status display *************
	Th_dis = hmt.readvp16(0x080070)
	if Th_dis == 1 then
		hmt.writevp16(0x08016C, 0)
		--hmt.writevp16(0x08901C, 1)
	else
		hmt.writevp16(0x08016C, 1)
		--hmt.writevp16(0x08901C, 0)
	end	

	--************* Scheduled Fill Reminder *************
	am_pm = hmt.readvp16(0x0805D6)
	if(am_pm ==  0) then hmt.writevpstr(0x000E80, "AM") 
	elseif(am_pm ==  1) then hmt.writevpstr(0x000E80, "PM") 
	end

	--************* Check Level Reminder *************
	am_pm = hmt.readvp16(0x080616)
	if(am_pm ==  0) then hmt.writevpstr(0x000F80, "AM") 
	elseif(am_pm ==  1) then hmt.writevpstr(0x000F80, "PM") 
	end

	--************* LN2 Level Reminder ************* 
	am_pm = hmt.readvp16(0x080636)
	if(am_pm ==  0) then hmt.writevpstr(0x001180, "AM") 
	elseif(am_pm ==  1) then hmt.writevpstr(0x001180, "PM") 
	end

	--************* 12 or 24 conversion *************
	Hrs_v = hmt.readvpreg(0xFFFF13)
	hmt.writevp16(0x080162, Hrs_v)
	Hrs = hmt.readvp16(0x080154)
	if Hrs == 1 then
	hmt.writevp16(0x080162, Hrs_v)
	hmt.writevp16(0x08099C, 0)
	else
		hmt.writevp16(0x08099C, 1)
		if Hrs_v >= 12 then 
			--hmt.writevpstr(0x003300, "PM") 
			if Hrs_v > 12 then 
			hmt.writevp16(0x080162, (Hrs_v-12))
			end
		else
		hmt.writevp16(0x080162, Hrs_v)
		--hmt.writevpstr(0x003300, "AM") 
		end
	end

	AMPM_Format = hmt.readvp16(0x081026)
	if AMPM_Format==0 then
		hmt.writevpstr(0x003300, "AM") 
	else
		hmt.writevpstr(0x003300, "PM") 
	end

	Date = hmt.readvp16(0x080152)
	if Date == 1 then
		hmt.writevp16(0x08099A, 0)
	else
		hmt.writevp16(0x08099A, 1)
	end	

	Buzz = hmt.readvp16(0x08003A)
	hmt.writevpreg(0xFFFF20,Buzz*5)

	--***********Backlight control**************
	local backlight-- = 9	
    	local val = hmt.readvp16(0x080038)
	if prev_val == val then 
	else
		prev_val=val
		if val <= 5 then
			backlight = 9--9--84
		else
			local temp = val*63/100
			backlight = math.ceil(temp)--floor
		end
		--if backlight < 60 then
		hmt.writevpreg(0xFFFF21,backlight) 
	end

	--************* Making security button grey *************
	security=hmt.readvp16(0x08202A)
	if security == 0 then
		hmt.writevp16(0x089026,1)
	else
		hmt.writevp16(0x089026,0)
	end
	
return 0
end
--**************************************** MAIN LOOP ENDS HERE ****************************************

tpkhook = function (page,id,state)
	c=0
	pgtime=0
	return 0
	-- body
end
