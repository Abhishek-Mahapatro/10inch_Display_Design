-- main loop start
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
hmt.writevpstr(0x004980,0)

--Making user admin name in popup 0
hmt.writevpstr(0x004980,NULL)
hmt.writevpstr(0x004A00,NULL)

--Making user admin status 0
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

hmt.writevp16(0x089000, 0)

--Making Page change keys in user access 0
hmt.writevp16(0x082024, 0)
hmt.writevp16(0x082026, 0)
hmt.writevp16(0x082028, 0)

--Making admin default
hmt.writevp16(0x0800C8, 0)

--Making fill/defog 0
hmt.writevp16(0x08012A, 0)

--Making stop 0
hmt.writevp16(0x0890996, 0)

--Making resume popup 0
hmt.writevp16(0x089004, 0)

--Making admin select default
hmt.writevp16(0x0800C6, 0)


--hmt.writevp16(0x08012A, 1)--Enable Fill key
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

luamain = function(void)

	RTCSec = hmt.readvpreg(0xFFFF15)--RTC Seconds
	if RTCSec == PreRTCsec then
	else
		if CommTimeoutErrorCheck == 4 then

		else
			CommTimeoutErrorCheck=CommTimeoutErrorCheck+1
		end 
		PreRTCsec=RTCSec
		if Toogle ==0 then
		--hmt.writevp16(0x080974,0)
		Toogle=1
		else
		--hmt.writevp16(0x080974,1)
		Toogle=0
		end 
	end

	T2_High = hmt.readvp16(0x080058) 
    T2_Low = hmt.readvp16(0x08005C)
    T2 = hmt.readvp16(0x080062)
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

	if CommTimeoutErrorCheck==4 then
		PreBuzz 	= hmt.readvp16(0x081000)
		PreFillDefog= hmt.readvp16(0x08012A)
		hmt.writevp16(0x080974,1) -- Communication Faild Icon Enable
		hmt.writevp16(0x080970,0)--Disable 
		hmt.writevp16(0x089002,0)--Disable 
		hmt.writevp16(0x081008,0)--Warning Key
		hmt.writevp16(0x081000,0)--Buzz Mute 
		hmt.writevp16(0x08012A,0)--Fill defog
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
		hmt.writevp16(0x089002,1)
		if rst==1 then
			hmt.writevp16(0x080970,1)
		else
			hmt.writevp16(0x080970,0)
		end	
		if PageChangeToHomeFlg==1 then
			hmt.writevp16(0x081000,Pre1Buzz)
			if rst==1 then
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
	else
		hmt.writevp16(0x080166, 1)
	end
	
  

	Th_dis = hmt.readvp16(0x080070)
	if Th_dis == 1 then
		hmt.writevp16(0x08016C, 0)
	else
		hmt.writevp16(0x08016C, 1)
	end	

	--Scheduled Fill Reminder 
	am_pm = hmt.readvp16(0x0805D6)
	if(am_pm ==  0) then hmt.writevpstr(0x000E80, "AM") 
	elseif(am_pm ==  1) then hmt.writevpstr(0x000E80, "PM") 
	end
	--Check Level Reminder 
	am_pm = hmt.readvp16(0x080616)
	if(am_pm ==  0) then hmt.writevpstr(0x000F80, "AM") 
	elseif(am_pm ==  1) then hmt.writevpstr(0x000F80, "PM") 
	end
	--LN2 Level Reminder 
	am_pm = hmt.readvp16(0x080636)
	if(am_pm ==  0) then hmt.writevpstr(0x001180, "AM") 
	elseif(am_pm ==  1) then hmt.writevpstr(0x001180, "PM") 
	end

	--12 or 24 conversion 
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

	local backlight-- = 9	
    local val = hmt.readvp16(0x080038)
	if prev_val == val then 
		
	else
		prev_val=val
		if val <= 14 then
			backlight = 9--9--84
		else
			local temp = val*63/100
			backlight = math.ceil(temp)--floor
		end
		--if backlight < 60 then
		hmt.writevpreg(0xFFFF21,backlight) 
	end
	

return 0
end
-- main loop end