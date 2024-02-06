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
hmt.writevp16(0x0803EE, 0)
hmt.writevp16(0x0803F0, 0)

hmt.writevp16(0x089026,0)
-- hmt.writevp16(0x08900C,0)

hmt.writevp16(0x080412, 0)
-- ***** Calibration touch *****
hmt.writevp16(0x080410, 0)
hmt.writevp16(0x08040E, 0)

hmt.writevp16(0x08040C, 0) --Home DP faulty
hmt.writevp16(0x080400, 1) --Home Thm

--***** Making Ln2 usages disable *****
hmt.writevp16(0x08904E, 0)
hmt.writevp16(0x089032, 0)

--***** Making user admin name in popup 0 *****
--hmt.writevpstr(0x004980, 0)

hmt.writevpstr(0x004980, nil)
hmt.writevpstr(0x004A00, nil)
hmt.writevpstr(0x004200, nil)
hmt.writevpstr(0x004700, nil)
hmt.writevpstr(0x004300, nil)
hmt.writevpstr(0x004800, nil)
hmt.writevpstr(0x004380, nil)
hmt.writevpstr(0x004880, nil)
hmt.writevpstr(0x004400, nil)
hmt.writevpstr(0x004900, nil)

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

hmt.writevp16(0x080996, 0)

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
hmt.writevp16(0x0801A2, 0)
hmt.writevp16(0x0801A4, 0)
hmt.writevp16(0x0801A6, 0)

hmt.writevp16(0x089032, 0)
hmt.writevp16(0x08904E, 0)

hmt.writevp16(0x0801B4, 0)
hmt.writevp16(0x0801B6, 0)
hmt.writevp16(0x0801B8, 0)

--*****Making F/W update popups Disable *****
hmt.writevp16(0x0801CC, 0)
hmt.writevp16(0x0801E4, 0)
hmt.writevp16(0x0801E0, 0)
hmt.writevp16(0x0801E2, 0)

--*****Making Default for OFAF grouping *****
--hmt.writevp16(0x080324,0)
--hmt.writevp16(0x080824,0)
--hmt.writevp16(0x080326,1)
--hmt.writevp16(0x080826,1)
hmt.writevp16(0x0802E4, 0)
hmt.writevp16(0x0802E6, 0)
hmt.writevp16(0x0802E8, 0)
hmt.writevp16(0x0802EA, 0)
hmt.writevp16(0x0802EC, 0)
hmt.writevp16(0x0802EE, 0)
hmt.writevp16(0x0802F0, 0)
hmt.writevp16(0x0802F2, 0)
hmt.writevp16(0x0802F4, 0)
hmt.writevp16(0x0802F6, 0)
hmt.writevp16(0x0802F8, 0)
hmt.writevp16(0x0802FA, 0)
hmt.writevp16(0x0802FC, 0)
hmt.writevp16(0x0802FE, 0)
hmt.writevp16(0x080300, 0)
hmt.writevp16(0x080302, 0)
hmt.writevp16(0x080304, 0)
hmt.writevp16(0x080306, 0)
hmt.writevp16(0x080308, 0)
hmt.writevp16(0x08030A, 0)
hmt.writevp16(0x08030C, 0)
hmt.writevp16(0x08030E, 0)
hmt.writevp16(0x080310, 0)
hmt.writevp16(0x080312, 0)
hmt.writevp16(0x080314, 0)
hmt.writevp16(0x080316, 0)
hmt.writevp16(0x080318, 0)
hmt.writevp16(0x08031A, 0)
hmt.writevp16(0x08031C, 0)
hmt.writevp16(0x08031E, 0)
hmt.writevp16(0x080320, 0)
hmt.writevp16(0x080322, 0)
hmt.writevp16(0x080328, 1)
hmt.writevp16(0x08032A, 0)
hmt.writevp16(0x08032C, 0)
hmt.writevp16(0x08032E, 0)
hmt.writevp16(0x080560, 0)
hmt.writevp16(0x080060, 0)

--***** BIST Disable all vp*****
-- hmt.writevp16(0x080330,0)
-- hmt.writevp16(0x080332,0)
-- hmt.writevp16(0x080334,0)
-- hmt.writevp16(0x080336,0)
-- hmt.writevp16(0x080338,0)

-- Disable all BIST parameter name
hmt.writevp16(0x08033A, 0)
hmt.writevp16(0x08033C, 0)
hmt.writevp16(0x08033E, 0)
hmt.writevp16(0x080340, 0)
hmt.writevp16(0x080342, 0)
hmt.writevp16(0x080376, 0)
hmt.writevp16(0x080378, 0)
hmt.writevp16(0x08037A, 0)
hmt.writevp16(0x08037C, 0)
hmt.writevp16(0x08037E, 0)
hmt.writevp16(0x080380, 0)
hmt.writevp16(0x080382, 0)
hmt.writevp16(0x080384, 0)
hmt.writevp16(0x080386, 0)
hmt.writevp16(0x0803FA, 0)
-- Disable all BIST result
hmt.writevp16(0x080344, 0)
hmt.writevp16(0x080346, 0)
hmt.writevp16(0x080348, 0)
hmt.writevp16(0x08034A, 0)
hmt.writevp16(0x08034C, 0)
hmt.writevp16(0x080388, 0)
hmt.writevp16(0x08038A, 0)
hmt.writevp16(0x08038C, 0)
hmt.writevp16(0x08038E, 0)
hmt.writevp16(0x080390, 0)
hmt.writevp16(0x080392, 0)
hmt.writevp16(0x080394, 0)
hmt.writevp16(0x080396, 0)
hmt.writevp16(0x080398, 0)
hmt.writevp16(0x0803FC, 0)
-- Disable all notifications
hmt.writevp16(0x08034E,0)
hmt.writevp16(0x080350,0)
hmt.writevp16(0x080352,0)
hmt.writevp16(0x080354,0)
hmt.writevp16(0x080356,0)


-- BIST result
hmt.writevp16(0x0801E6,3)
hmt.writevp16(0x0801E8,3)
hmt.writevp16(0x0801EA,3)
hmt.writevp16(0x0801EC,3)
hmt.writevp16(0x0801EE,3)
hmt.writevp16(0x0801F0,3)
hmt.writevp16(0x0801F2,3)
hmt.writevp16(0x0801F4,3)
hmt.writevp16(0x0801F6,3)
hmt.writevp16(0x0801F8,3)
hmt.writevp16(0x0801FA,3)
hmt.writevp16(0x0801FC,3)
hmt.writevp16(0x0801FE,3)
hmt.writevp16(0x08039A,3)



-- hmt.writevp16(0x080402,0)
-- hmt.writevp16(0x080404,0)

-- *****GRAPH ******
hmt.writevp16(0x089064,0)
hmt.writevp16(0x089564,0)
hmt.writevp16(0x089050,0)
hmt.writevp16(0x089550,0)
hmt.writevp16(0x080358,0)
hmt.writevp16(0x08035A,0)
hmt.writevp16(0x089560,0)
hmt.writevp16(0x089060,0)

hmt.writevp16(0x080326,1)
hmt.writevp16(0x080404,0)

hmt.writevp16(0x0803E8,0)

--***** Sys Info *****
-- edit=hmt.readvp16(0x080402)
-- edit_en=hmt.readvp16(0x08900C)
-- if edit_en==1 then
-- 	if edit==1 then
-- 		hmt.writevp16(0x080406,1)
-- 	else
-- 		hmt.writevp16(0x080406,0)
-- 	end
-- end

bist_c = 0
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

	pgid = hmt.readpage()
	lid = hmt.readvp16(0x080014)
	AFill = hmt.readvp16(0x08101C)
	MFill = hmt.readvp16(0x08101E)
	ADFog = hmt.readvp16(0x081020)
	MDFog = hmt.readvp16(0x081022)
	QChil = hmt.readvp16(0x081024)
	Fact = hmt.readvp16(0x080992)
	start_stop=hmt.readvp16(0x080412)

--************ LN2 Usages ***********
	countLn2 = hmt.readvp16(0x089058)
	PreLn2usage = hmt.readvp16(0x08905A)
	Ln2Usage = hmt.readvp16(0x089030)

	t2_Dis = hmt.readvp16(0x08102C)--T2 disabled
	-- if t2_Dis == 1 then

	if AFill == 1 or MFill == 1 or ADFog == 1 or MDFog == 1 or QChil == 1 then
		hmt.writevp16(0x089032, 0)
		hmt.writevp16(0x08904E, 0)
		hmt.writevp16(0x080410, 0)
		hmt.writevp16(0x08040E, 1)
		hmt.writevp16(0x080418, 0)
		hmt.writevp16(0x08041A, 1)
	else
		hmt.writevp16(0x080410, 1)
		hmt.writevp16(0x08040E, 0)
		if Ln2Usage > (2*PreLn2usage) then
			hmt.writevp16(0x089032, 0)
			hmt.writevp16(0x08904E, 1)
		else
			hmt.writevp16(0x089032, 1)
			hmt.writevp16(0x08904E, 0)
		end
		if t2_Dis==1 then
			hmt.writevp16(0x080418, 0)
			hmt.writevp16(0x08041A, 1)
		else
			hmt.writevp16(0x080418, 1)
			hmt.writevp16(0x08041A, 0)
		end
	end

	--************* Check communication time out and page change to home *************
	File_Read=hmt.readvp16(0x0803E8)
	RTCSec = hmt.readvpreg(0xFFFF15)--RTC Seconds
	if RTCSec == PreRTCsec or pgid == 0x27 or pgid== 0x06 or File_Read==1 then
        --CommTimeoutErrorCheck=0
	else
		if CommTimeoutErrorCheck == 15 then

		else
			CommTimeoutErrorCheck=CommTimeoutErrorCheck+1
		end

		--******** page change start **********
		if pgid==0x00 or pgid==0x24 or pgid==0x4A or pgid==0x08 or pgid==0x11 or pgid==0x33 or pgid==0x34 or pgid==0x06 or pgid==0x3B then
			c=0
		elseif pgid==0x3B then
			c=0
		else
			c=c+1
			--hmt.writevp16(0x089024,c)
			if c==60 then
				hmt.changepage(0x00)	
			else
				--hmt.writevpreg(0xFFFF21,backlight) 
			end
		end
		--******** page change end **********
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
		hmt.writevpstr(0x004200,nil)
		hmt.writevpstr(0x004700,nil)
		hmt.writevpstr(0x004300,nil)
		hmt.writevpstr(0x004800,nil)
		hmt.writevpstr(0x004380,nil)
		hmt.writevpstr(0x004880,nil)
		hmt.writevpstr(0x004400,nil)
		hmt.writevpstr(0x004900,nil)
		hmt.writevp16(0x0801A2,0)
		hmt.writevp16(0x0801A4,0)
		hmt.writevp16(0x0801A6,0)		
	end

	Th=hmt.readvp16(0x080070)
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
	if CommTimeoutErrorCheck==15 then
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
		hmt.writevp16(0x080168, 0)
		hmt.writevp16(0x08902E, 1)
	else
		hmt.writevp16(0x080168, 1)
		hmt.writevp16(0x08902E, 0)
	end
	

	--************* Scheduled Fill Reminder *************
	am_pm = hmt.readvp16(0x0805D6)
	if(am_pm ==  0) then 
		hmt.writevpstr(0x000E80, "AM") 
	elseif(am_pm ==  1) then 
		hmt.writevpstr(0x000E80, "PM") 
	end

	--************* Check Level Reminder *************
	am_pm = hmt.readvp16(0x080616)
	if(am_pm ==  0) then 
		hmt.writevpstr(0x000F80, "AM") 
	elseif(am_pm ==  1) then 
		hmt.writevpstr(0x000F80, "PM") 
	end

	--************* LN2 Level Reminder ************* 
	am_pm = hmt.readvp16(0x080636)
	if(am_pm ==  0) then 
		hmt.writevpstr(0x001180, "AM") 
	elseif(am_pm ==  1) then 
		hmt.writevpstr(0x001180, "PM") 
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
			backlight = 4--9--84
		else
			local temp = val*63/100
			backlight = math.ceil(temp)--floor
		end
		--if backlight < 60 then
		hmt.writevpreg(0xFFFF21,backlight) 
	end

	--************* Making security button grey *************
	security=hmt.readvp16(0x08900C)
	if security == 0 then
		hmt.writevp16(0x089026,1)
	else
		hmt.writevp16(0x089026,0)
	end

	--************ Making Cancel button enable in factory reset ***********
	findex=hmt.readvp16(0x080994)
	if findex==3 then
		hmt.writevp16(0x08902C,1)
	else
		hmt.writevp16(0x08902C,0)
	end

	--************ Transition to home if alert come ***********
	errC = hmt.readvp16(0x080222)
	if pgid == 0x24 then
		if errC>preErrC or lid==1 or AFill==1 then
			hmt.changepage(0x00)
			--c=0
			preErrC=errC
		--[[
		elseif errC<=preErrC then
			preErrC=errC
		]]
		end
	else
		preErrC=errC
	end

	--************ Graph Colour ***********
	gsel = hmt.readvp16(0x089028)
	if gsel == 0 then
		hmt.writevp16(0x089034,0x07E0)
	elseif gsel == 1 then
		hmt.writevp16(0x089034,0xFFE0)
	elseif gsel == 2 then
		hmt.writevp16(0x089034,0x07FF)
	else
	end

	-- --************ LN2 Usages ***********
	-- countLn2 = hmt.readvp16(0x089058)
	-- PreLn2usage = hmt.readvp16(0x08905A)
	-- Ln2Usage = hmt.readvp16(0x089030)
	-- if AFill == 1 or MFill == 1 or ADFog == 1 or MDFog == 1 or QChil == 1 then
	-- 	hmt.writevp16(0x089032,0)
	-- 	hmt.writevp16(0x08904E, 0)
	-- else
	-- 		if Ln2Usage > (2*PreLn2usage) then
	-- 			hmt.writevp16(0x089032,0)
	-- 			hmt.writevp16(0x08904E,1)
	-- 		else
	-- 			hmt.writevp16(0x089032,1)
	-- 			hmt.writevp16(0x08904E,0)
	-- 		end
	-- end
	
	--************ OFAF Enable ***********
	-- nodeId = hmt.readvp16(0x080206)
	-- if nodeId == 0 then
	-- 	--hmt.writevp16(0x0801B4,1)
	-- 	hmt.writevp16(0x08020A,1)
	-- else
	-- 	--hmt.writevp16(0x0801B4,0)
	-- 	hmt.writevp16(0x08020A,0)
	-- end

	--***** BIST *****
	last = hmt.readvp16(0x08034C)
	
	if pgid == 0x06 then
		hmt.writevp16(0x08034E,1)
		plum = hmt.readvp16(0x08035E)
		--sram = hmt.readvp16(0x0801E6)
		flash = hmt.readvp16(0x0801E8)
		eeprom = hmt.readvp16(0x0801EA)
		rtd1 = hmt.readvp16(0x0801EC)
		rtd2 = hmt.readvp16(0x0801EE)
		dp = hmt.readvp16(0x0801F0)
		thm = hmt.readvp16(0x0801F2)
		battery = hmt.readvp16(0x0801F4)
		sd = hmt.readvp16(0x0801F6)
		gbp = hmt.readvp16(0x0801F8)
		mfv = hmt.readvp16(0x0801FA)
		--eth = hmt.readvp16(0x0801FC)
		--wifi = hmt.readvp16(0x0801FE)
		spi = hmt.readvp16(0x08039A)

		--1 SRAM
		-- hmt.writevp16(0x08033A,1)
		-- hmt.delayms(300)
		-- hmt.writevp16(0x080344,1)
		-- hmt.delayms(100)

		--2 Flash
		hmt.writevp16(0x08033C,1)
		hmt.delayms(300)
		hmt.writevp16(0x080346,1)
		hmt.delayms(100)

		--3 EEPROM
		hmt.writevp16(0x08033E,1)
		hmt.delayms(300)
		hmt.writevp16(0x080348,1)
		hmt.delayms(100)

		--9 SD CARD
		hmt.writevp16(0x08037C,1)
		hmt.delayms(300)
		hmt.writevp16(0x08038E,1)
		hmt.delayms(100)

		--14 SPI
		hmt.writevp16(0x080386,1)
		hmt.delayms(300)
		hmt.writevp16(0x080398,1)
		hmt.delayms(100)

		--4 RTD1
		hmt.writevp16(0x080340,1)
		hmt.delayms(300)
		hmt.writevp16(0x08034A,1)
		hmt.delayms(100)

		--5 RTD2
		if T2==1 then
			hmt.writevp16(0x080342,1)
			hmt.delayms(300)
			hmt.writevp16(0x08034C,1)
			hmt.delayms(100)
		else
			hmt.writevp16(0x080342,0)
			hmt.writevp16(0x08034C,0)
		end

		--10 GBP
		hmt.writevp16(0x08037E,1)
		hmt.delayms(300)
		hmt.writevp16(0x080390,1)
		hmt.delayms(100)

		--11 MFV
		hmt.writevp16(0x080380,1)
		hmt.delayms(300)
		hmt.writevp16(0x080392,1)
		hmt.delayms(100)

		--12 ETHERNET
		-- hmt.writevp16(0x080382,1)
		-- hmt.delayms(300)
		-- hmt.writevp16(0x080394,1)
		-- hmt.delayms(100)

		--13 WIFI
		-- hmt.writevp16(0x080384,1)
		-- hmt.delayms(300)
		-- hmt.writevp16(0x080396,1)
		-- hmt.delayms(100)

		--6 DP
		hmt.writevp16(0x080376,1)
		hmt.delayms(300)
		hmt.writevp16(0x080388,1)
		hmt.delayms(100)

		--7 Battery
		--8 Thermistor
		if plum==0 then  -- No battery
			hmt.writevp16(0x080378,0) --Disable Thm_Lower
			hmt.writevp16(0x08038A,0) --Disable Thm_Lower_Res
			hmt.writevp16(0x08037A,0) --Disable Battery
			hmt.writevp16(0x08038C,0) --Disable Battery_Res
			if Th==1 then
				hmt.writevp16(0x0803FA,1) --Enable Thm_Upper
				hmt.delayms(300)
				hmt.writevp16(0x0803FC,1) --Enable Thm_Upper_Res
				hmt.delayms(100)
			else
				hmt.writevp16(0x0803FA,0) --Disable Thm_Upper
				hmt.writevp16(0x0803FC,0) --Disable Thm_Upper_Res
			end
			
		else  -- With Battery
			hmt.writevp16(0x0803FA,0) --Disable Thm_Upper
			hmt.writevp16(0x0803FC,0) --Disable Thm_Upper_Res
			hmt.writevp16(0x08037A,1) --Enable Battery
			hmt.delayms(300)
			hmt.writevp16(0x08038C,1) --Disable Battery
			hmt.delayms(100)
			if Th==1 then
				hmt.writevp16(0x080378,1) --Enable Thm_Lower
				hmt.delayms(300)
				hmt.writevp16(0x08038A,1) --Enable Thm_Lower_Res
				hmt.delayms(100)
			else
				hmt.writevp16(0x080378,0) --Disable Thm_Lower
				hmt.writevp16(0x08038A,0) --Disable Thm_Lower_Res
			end
		end
			

		--8 BATTERY
		-- hmt.writevp16(0x08037A,1)
		-- hmt.delayms(300)
		-- hmt.writevp16(0x08038C,1)
		-- hmt.delayms(100)

		-- if Th==1 then
		-- 	--7 THERMISTOR
		-- 	hmt.writevp16(0x080378,1)
		-- 	hmt.delayms(300)
		-- 	hmt.writevp16(0x08038A,1)
		-- 	hmt.delayms(100)
		-- else
		-- 	hmt.writevp16(0x080378,0)
		-- 	hmt.writevp16(0x08038A,0)
		-- end


		hmt.writevp16(0x08034E,0)
		hmt.writevp16(0x080350,1)
		hmt.delayms(100)

		-- if rtd1==0 or dp==0 or gbp==0 or mfv==0 then --Restart the system
		-- 	hmt.writevp16(0x080352,0)
		-- 	hmt.writevp16(0x080354,0)
		-- 	hmt.writevp16(0x080356,1)
		-- elseif eeprom==0 or rtd2==0 or thm==0 or battery==0 or sd==0 then
		-- 	if sd==0 then  -- Warning message + User selection
		-- 		hmt.writevp16(0x080352,1)
		-- 		hmt.writevp16(0x080354,1)
		-- 		hmt.writevp16(0x080356,0)
		-- 	else     -- User Selection
		-- 		hmt.writevp16(0x080352,1)
		-- 		hmt.writevp16(0x080354,0)
		-- 		hmt.writevp16(0x080356,0)
		-- 	end
		-- else
		-- 	hmt.writevp16(0x080352,0)
		-- 	hmt.writevp16(0x080354,0)
		-- 	hmt.writevp16(0x080356,0)
		-- end

	else
		hmt.writevp16(0x08033A,0)
		hmt.writevp16(0x08033C,0)
		hmt.writevp16(0x08033E,0)
		hmt.writevp16(0x080340,0)
		hmt.writevp16(0x080342,0)
		hmt.writevp16(0x080376,0)
		hmt.writevp16(0x080378,0)
		hmt.writevp16(0x08037A,0)
		hmt.writevp16(0x08037C,0)
		hmt.writevp16(0x08037E,0)
		hmt.writevp16(0x080380,0)
		hmt.writevp16(0x080382,0)
		hmt.writevp16(0x080384,0)
		hmt.writevp16(0x080386,0)

		hmt.writevp16(0x080344,0)
		hmt.writevp16(0x080346,0)
		hmt.writevp16(0x080348,0)
		hmt.writevp16(0x08034A,0)
		hmt.writevp16(0x08034C,0)
		hmt.writevp16(0x080388,0)
		hmt.writevp16(0x08038A,0)
		hmt.writevp16(0x08038C,0)
		hmt.writevp16(0x08038E,0)
		hmt.writevp16(0x080390,0)
		hmt.writevp16(0x080392,0)
		hmt.writevp16(0x080394,0)
		hmt.writevp16(0x080396,0)
		hmt.writevp16(0x080398,0)

		hmt.writevp16(0x08034E,0)
		hmt.writevp16(0x080350,0)
		hmt.writevp16(0x080352,0)
		hmt.writevp16(0x080354,0)
		hmt.writevp16(0x080356,0)


	end

	-- if last==1 then
	-- 	hmt.writevp16(0x080350,1)
	-- 	hmt.writevp16(0x08034E,0)
	-- else
	-- 	hmt.writevp16(0x080350,0)
	-- 	hmt.writevp16(0x08034E,1)
	-- end

	-- if (Sram==0 or Flash==0 or Eeprom==0) or (rtd1==0 and rtd2==0) then
	-- 	hmt.writevp16(0x080352,1)
	-- 	hmt.writevp16(0x080350,1)
	-- else
	-- 	hmt.writevp16(0x080352,0)
	-- 	hmt.writevp16(0x080350,1)
	-- end

	


return 0
end
--**************************************** MAIN LOOP ENDS HERE ****************************************

tpkhook = function (page,id,state)
	c=0
	pgtime=0
	return 0
	-- body
end
