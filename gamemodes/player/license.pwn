IsPlayerInDMVVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof dmv_vehicles; i++)
	{
		if(vehicleid == dmv_vehicles[i])
			return 1;
	}
		
	return 0;
}

IsPlayerInTDVMVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof taxi_vehicles; i++)
	{
		if(vehicleid == taxi_vehicles[i])
			return 1;
	}
		
	return 0;
}

CMD:ehliyet(playerid, params[])
{
	if(PlayerData[playerid][pDrivingTest]) return SendErrorMessage(playerid, "Ehliyet sýnavýnýn ortasýndasýn.");
	if(PlayerData[playerid][pTaxiDrivingTest]) return SendErrorMessage(playerid, "Taksi sýnavýnýn ortasýndasýn."); 
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Herhangi bir araçta deðilsin.");

	if(IsPlayerInDMVVehicle(playerid))
	{
		if(PlayerData[playerid][pDriversLicense]) return SendErrorMessage(playerid, "Ehliyetin bulunuyor.");

		new
			vehicleid = GetPlayerVehicleID(playerid);

		PlayerData[playerid][pTestStage] = 0; 
		PlayerData[playerid][pTestTime] = 180;
		PlayerData[playerid][pTestCar] = vehicleid;
		PlayerData[playerid][pDrivingTest] = true; 
		
		ToggleVehicleEngine(vehicleid, true);
		CarEngine[vehicleid] = true;

	    SendClientMessage(playerid, COLOR_ADM, "_________Ana Sürüþ Kurallarý_________");
	    SendClientMessage(playerid, COLOR_ADM, "1) Her zaman yolun sað tarafýndan sür.");
	    SendClientMessage(playerid, COLOR_ADM, "2) Araç ile ana yollarda hýz yapma.");
	    SendClientMessage(playerid, COLOR_ADM, "3) Yoldaki diðer sürücülere karþý hoþgörülü ol.");
	    SendClientMessage(playerid, COLOR_WHITE, "Kontrol noktasýna giriþ yaparak sýnavýna baþlayabilirsin.");
	    SendClientMessage(playerid, COLOR_WHITE, "Eðer çok fazla hýz yaparsan, baþýn belaya girebilir.");

		//cmd_ame(playerid, sprintf("%s model aracýn motorunu çalýþtýrýr.", ReturnVehicleName(vehicleid)));
		SendClientMessage(playerid, COLOR_GREY, "Sürüþ Eðitmeni: Kontrol noktalarýna dikkat ederek ve kurallara uyarak sürüþe baþlayabilirsin.");
		SetPlayerCheckpoint(playerid, g_arrDrivingCheckpoints[PlayerData[playerid][pTestStage]][0], g_arrDrivingCheckpoints[PlayerData[playerid][pTestStage]][1], g_arrDrivingCheckpoints[PlayerData[playerid][pTestStage]][2], 3.0);
	} 
	else if(IsPlayerInTDVMVehicle(playerid))
	{
		if(!PlayerData[playerid][pDriversLicense]) return SendErrorMessage(playerid, "Ehliyet almadan, taksi ehliyeti alamazsýn.");
		if(PlayerData[playerid][pSideJob] == TAXI_JOB && PlayerData[playerid][pJob] == TAXI_JOB) return SendErrorMessage(playerid, "Taksi ehliyetin bulunuyor.");

		new
			vehicleid = GetPlayerVehicleID(playerid);

		PlayerData[playerid][pTestStage] = 0; 
		//PlayerData[playerid][pTestTime] = 180;
		PlayerData[playerid][pTestCar] = vehicleid;
		PlayerData[playerid][pTaxiDrivingTest] = true; 
		
		ToggleVehicleEngine(vehicleid, true);
		CarEngine[vehicleid] = true;

	    SendClientMessage(playerid, COLOR_ADM, "_________Ana Sürüþ Kurallarý[Taksi]_________");
	    SendClientMessage(playerid, COLOR_ADM, "1) Her zaman yolun sað tarafýndan sür.");
	    SendClientMessage(playerid, COLOR_ADM, "2) Araç ile ana yollarda hýz yapma.");
	    SendClientMessage(playerid, COLOR_ADM, "3) Yoldaki diðer sürücülere karþý hoþgörülü ol.");
	    SendClientMessage(playerid, COLOR_WHITE, "Kontrol noktasýna giriþ yaparak sýnavýna baþlayabilirsin.");
	    SendClientMessage(playerid, COLOR_WHITE, "Eðer çok fazla hýz yaparsan, baþýn belaya girebilir.");

	    SetPlayerCheckpoint(playerid, g_arrTaxiDrivingCheckpoints[PlayerData[playerid][pTestStage]][0], g_arrTaxiDrivingCheckpoints[PlayerData[playerid][pTestStage]][1], g_arrTaxiDrivingCheckpoints[PlayerData[playerid][pTestStage]][2], 3.0);
	} 
	else SendErrorMessage(playerid, "Ehliyet sýnav aracý içerisinde deðilsin."); 
	return 1;
}

CancelDrivingTest(playerid)
{
	SetVehicleToRespawn(PlayerData[playerid][pTestCar]);
	ToggleVehicleEngine(PlayerData[playerid][pTestCar], false);
	CarEngine[PlayerData[playerid][pTestCar]] = false;

	PlayerData[playerid][pTestTime] = 0;
	PlayerData[playerid][pTestCar] = INVALID_VEHICLE_ID;
	PlayerData[playerid][pTestStage] = 0; 

	DisablePlayerCheckpoint(playerid);
	PlayerData[playerid][pDrivingTest] = false; 
	return 1;
}

CancelTaxiDrivingTest(playerid)
{
	SetVehicleToRespawn(PlayerData[playerid][pTestCar]);
	ToggleVehicleEngine(PlayerData[playerid][pTestCar], false);
	CarEngine[PlayerData[playerid][pTestCar]] = false;

	PlayerData[playerid][pTestTime] = 0;
	PlayerData[playerid][pTestCar] = INVALID_VEHICLE_ID;
	PlayerData[playerid][pTestStage] = 0; 

	DisablePlayerCheckpoint(playerid);
	PlayerData[playerid][pTaxiDrivingTest] = false; 
	return 1;
}