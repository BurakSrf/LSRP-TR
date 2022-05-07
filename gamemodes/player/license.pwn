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
	if(PlayerData[playerid][pDrivingTest]) return SendErrorMessage(playerid, "Ehliyet s�nav�n�n ortas�ndas�n.");
	if(PlayerData[playerid][pTaxiDrivingTest]) return SendErrorMessage(playerid, "Taksi s�nav�n�n ortas�ndas�n."); 
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Herhangi bir ara�ta de�ilsin.");

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

	    SendClientMessage(playerid, COLOR_ADM, "_________Ana S�r�� Kurallar�_________");
	    SendClientMessage(playerid, COLOR_ADM, "1) Her zaman yolun sa� taraf�ndan s�r.");
	    SendClientMessage(playerid, COLOR_ADM, "2) Ara� ile ana yollarda h�z yapma.");
	    SendClientMessage(playerid, COLOR_ADM, "3) Yoldaki di�er s�r�c�lere kar�� ho�g�r�l� ol.");
	    SendClientMessage(playerid, COLOR_WHITE, "Kontrol noktas�na giri� yaparak s�nav�na ba�layabilirsin.");
	    SendClientMessage(playerid, COLOR_WHITE, "E�er �ok fazla h�z yaparsan, ba��n belaya girebilir.");

		//cmd_ame(playerid, sprintf("%s model arac�n motorunu �al��t�r�r.", ReturnVehicleName(vehicleid)));
		SendClientMessage(playerid, COLOR_GREY, "S�r�� E�itmeni: Kontrol noktalar�na dikkat ederek ve kurallara uyarak s�r��e ba�layabilirsin.");
		SetPlayerCheckpoint(playerid, g_arrDrivingCheckpoints[PlayerData[playerid][pTestStage]][0], g_arrDrivingCheckpoints[PlayerData[playerid][pTestStage]][1], g_arrDrivingCheckpoints[PlayerData[playerid][pTestStage]][2], 3.0);
	} 
	else if(IsPlayerInTDVMVehicle(playerid))
	{
		if(!PlayerData[playerid][pDriversLicense]) return SendErrorMessage(playerid, "Ehliyet almadan, taksi ehliyeti alamazs�n.");
		if(PlayerData[playerid][pSideJob] == TAXI_JOB && PlayerData[playerid][pJob] == TAXI_JOB) return SendErrorMessage(playerid, "Taksi ehliyetin bulunuyor.");

		new
			vehicleid = GetPlayerVehicleID(playerid);

		PlayerData[playerid][pTestStage] = 0; 
		//PlayerData[playerid][pTestTime] = 180;
		PlayerData[playerid][pTestCar] = vehicleid;
		PlayerData[playerid][pTaxiDrivingTest] = true; 
		
		ToggleVehicleEngine(vehicleid, true);
		CarEngine[vehicleid] = true;

	    SendClientMessage(playerid, COLOR_ADM, "_________Ana S�r�� Kurallar�[Taksi]_________");
	    SendClientMessage(playerid, COLOR_ADM, "1) Her zaman yolun sa� taraf�ndan s�r.");
	    SendClientMessage(playerid, COLOR_ADM, "2) Ara� ile ana yollarda h�z yapma.");
	    SendClientMessage(playerid, COLOR_ADM, "3) Yoldaki di�er s�r�c�lere kar�� ho�g�r�l� ol.");
	    SendClientMessage(playerid, COLOR_WHITE, "Kontrol noktas�na giri� yaparak s�nav�na ba�layabilirsin.");
	    SendClientMessage(playerid, COLOR_WHITE, "E�er �ok fazla h�z yaparsan, ba��n belaya girebilir.");

	    SetPlayerCheckpoint(playerid, g_arrTaxiDrivingCheckpoints[PlayerData[playerid][pTestStage]][0], g_arrTaxiDrivingCheckpoints[PlayerData[playerid][pTestStage]][1], g_arrTaxiDrivingCheckpoints[PlayerData[playerid][pTestStage]][2], 3.0);
	} 
	else SendErrorMessage(playerid, "Ehliyet s�nav arac� i�erisinde de�ilsin."); 
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