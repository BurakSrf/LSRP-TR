CMD:araciboya(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != MECHANIC_JOB && PlayerData[playerid][pJob] != MECHANIC_JOB) return SendErrorMessage(playerid, "Mekanik de�ilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�ekicinin �of�r koltu�unda olman gerekiyor.");
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 525) return SendErrorMessage(playerid, "�ekici i�erisinde olman gerekiyor.");
   	if(PlayerData[playerid][pComponents] < 7) return SendErrorMessage(playerid, "��lem yapabilmek i�in en az 7 tamir par�an olmas� gerekiyor.");

   	new id, color1, color2;
	if(sscanf(params, "uii", id, color1, color2)) return SendUsageMessage(playerid, "/araciboya [oyuncu ID/isim] [renk1] [renk2]");
	if(id == playerid) return SendErrorMessage(playerid, "Bu komutu kendi �zerinde kullanamazs�n.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!GetDistanceBetweenPlayers(playerid, id, 8.0)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
	if(GetPlayerState(id) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Belirtti�in ki�i �of�r koltu�unda de�il.");
	new elsevehicle = GetPlayerVehicleID(id);
	if(!IsValidPlayerCar(elsevehicle)) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac�na i�lem yap�lamaz.");
	if(color1 < 0 || color1 > 255) return SendErrorMessage(playerid, "1. renk kodu 0 ile 255 aras�nda olmal�.");
	if(color2 < 0 || color2 > 255) return SendErrorMessage(playerid, "2. renk kodu 0 ile 255 aras�nda olmal�.");
	SetPVarInt(playerid, "Mechanic_Color1", color1);
	SetPVarInt(playerid, "Mechanic_Color2", color2);
	SendOffer(playerid, id, 0);
	return 1;
}

CMD:aracidoldur(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != MECHANIC_JOB && PlayerData[playerid][pJob] != MECHANIC_JOB) return SendErrorMessage(playerid, "Mekanik de�ilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�ekicinin �of�r koltu�unda olman gerekiyor.");
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 525) return SendErrorMessage(playerid, "�ekici i�erisinde olman gerekiyor.");
   	if(PlayerData[playerid][pComponents] < 12) return SendErrorMessage(playerid, "��lem yapabilmek i�in en az 12 tamir par�an olmas� gerekiyor.");

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/aracidoldur [oyuncu ID/isim]");
	if(id == playerid) return SendErrorMessage(playerid, "Bu komutu kendi �zerinde kullanamazs�n.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!GetDistanceBetweenPlayers(playerid, id, 8.0)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
	if(GetPlayerState(id) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Belirtti�in ki�i �of�r koltu�unda de�il.");
	new elsevehicle = GetPlayerVehicleID(id);
	if(!IsValidPlayerCar(elsevehicle)) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac�na i�lem yap�lamaz.");
	SendOffer(playerid, id, 5);
	return 1;
}

CMD:aracicek(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != MECHANIC_JOB && PlayerData[playerid][pJob] != MECHANIC_JOB) return SendErrorMessage(playerid, "Mekanik de�ilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�ekicinin �of�r koltu�unda olman gerekiyor.");
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 525) return SendErrorMessage(playerid, "�ekici i�erisinde olman gerekiyor.");

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/aracicek [oyuncu ID/isim]");
	if(id == playerid) return SendErrorMessage(playerid, "Bu komutu kendi �zerinde kullanamazs�n.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!GetDistanceBetweenPlayers(playerid, id, 8.0)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
	if(GetPlayerState(id) == PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Belirtti�in ki�i �of�r koltu�unda oturuyor, yan koltu�a ge�meli.");
	
	new elsevehicle = GetPlayerVehicleID(id);
	if(elsevehicle == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac� yak�n�nda yok.");
	if(!IsValidPlayerCar(elsevehicle)) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac�na i�lem yap�lamaz.");
	if(IsTrailerAttachedToVehicle(elsevehicle)) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac� ba�kas� taraf�nda �ekiliyor.");
	if(IsHelicopter(elsevehicle) || NoEngineCar(elsevehicle)) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac� �ekilemeyecek t�rden g�z�k�yor.");
	SendOffer(playerid, id, 6);
	return 1;
}

CMD:aracitamiret(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != MECHANIC_JOB && PlayerData[playerid][pJob] != MECHANIC_JOB) return SendErrorMessage(playerid, "Mekanik de�ilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�ekicinin �of�r koltu�unda olman gerekiyor.");
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 525) return SendErrorMessage(playerid, "�ekici i�erisinde olman gerekiyor.");
   	if(PlayerData[playerid][pComponents] < 20) return SendErrorMessage(playerid, "��lem yapabilmek i�in en az 20 tamir par�an olmas� gerekiyor.");

	new id, type;
	if(sscanf(params, "ui", id, type))
	{
		SendUsageMessage(playerid, "/aracitamiret [oyuncu ID/isim] [tip]");
		SendClientMessage(playerid, -1, "{C0C0C0}Tip 1: {FFFFFF}Kaporta Tamiri");
		SendClientMessage(playerid, -1, "{C0C0C0}Tip 2: {FFFFFF}Ara� Tamiri");
		SendClientMessage(playerid, -1, "{C0C0C0}Tip 3: {FFFFFF}Motor Tamiri");
		SendClientMessage(playerid, -1, "{C0C0C0}Tip 4: {FFFFFF}Batarya Tamiri");
		return 1;
	}

	if(id == playerid) return SendErrorMessage(playerid, "Bu komutu kendi �zerinde kullanamazs�n.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!GetDistanceBetweenPlayers(playerid, id, 8.0)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
	if(GetPlayerState(id) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Belirtti�in ki�i �of�r koltu�unda de�il.");
	
	new elsevehicle = GetPlayerVehicleID(id);
	if(!IsValidPlayerCar(elsevehicle)) return SendErrorMessage(playerid, "Belirtti�in ki�inin arac�na i�lem yap�lamaz.");
	if(type < 1 || type > 4) return SendErrorMessage(playerid, "Tamir tipi 1 ile 4 aras�nda olmal�.");
	SendOffer(playerid, id, type);
	return 1;
}

CMD:parcadurum(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != MECHANIC_JOB && PlayerData[playerid][pJob] != MECHANIC_JOB) return SendErrorMessage(playerid, "Mekanik de�ilsin.");
    SendInfoMessage(playerid, "%i tane tamir par�an var.", PlayerData[playerid][pComponents]);
    return 1;
}

CMD:parcaal(playerid, params[])
{
	if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet s�nav�ndayken bu komutu kullanamazs�n.");
	if(PlayerData[playerid][pSideJob] != MECHANIC_JOB && PlayerData[playerid][pJob] != MECHANIC_JOB) return SendErrorMessage(playerid, "Mekanik de�ilsin.");

    if(!IsPlayerInRangeOfPoint(playerid, MECHANIC_COMP_POS_RANGE, MECHANIC_COMP_POS_X, MECHANIC_COMP_POS_Y, MECHANIC_COMP_POS_Z))
    {
 		SetPlayerCheckpoint(playerid, MECHANIC_COMP_POS_X, MECHANIC_COMP_POS_Y, MECHANIC_COMP_POS_Z, MECHANIC_COMP_POS_RANGE);
 	   	return SendErrorMessage(playerid, "Par�a sat�n alma noktas� i�aretlendi.");
	}

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�ekicinin �of�r koltu�unda olman gerekiyor.");
	
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 525) return SendErrorMessage(playerid, "�ekici i�erisinde olman gerekiyor.");
   	if(PlayerData[playerid][pComponents] >= 2000) return SendErrorMessage(playerid, "En fazla 2000 tane tamir par�as�na sahip olabilirsin.");

	new amount;
	if (sscanf(params, "i", amount)) return SendUsageMessage(playerid, "/parcaal [miktar(1 par�a = $30)]");
	if(amount < 0 || amount > 50) return SendErrorMessage(playerid, "Girilen par�a miktar� 1 ile 50 aras�nda olabilir.");
	if(amount+PlayerData[playerid][pComponents] > 2000) return SendErrorMessage(playerid, "2000 par�a limitini ge�iyorsun.");
	if(PlayerData[playerid][pMoney] < (MECHANIC_COMP_PRICE * amount)) return SendErrorMessage(playerid, "Girilen par�a miktar�n� alacak kadar paran�z bulunmuyor.");

    InfoTD_MSG(playerid, 2, 5000, sprintf("~w~%i~r~_ADET_TAMIR_PARCASI_SATIN_ALDIN.", amount));
    GiveMoney(playerid, -(MECHANIC_COMP_PRICE * amount));
    PlayerData[playerid][pComponents] += amount;
    return 1;
}

SendOffer(playerid, toplayer, type)
{
	switch(type)
	{
		case 0:
		{
			InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_BOYAMA_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
		}
	    case 1:
	    {
			InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_KAPORTA_TAMIRI_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
	    }
	    case 2:
	    {
			InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_ARAC_TAMIRI_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
	    }
	    case 3:
	    {
	    	InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_MOTOR_TAMIRI_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
	    }
	    case 4:
	    {
	    	InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_BATARYA_TAMIRI_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
	    }
	    case 5:
	    {
	    	InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_BENZIN_DOLDURMA_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
	    }
	    case 6:
	    {
	    	InfoTD_MSG(toplayer, 2, 5000, sprintf("~p~%s_SANA_CEKICI_ISTEGI_YOLLADI~n~~g~Y_~y~TUSUNA_BASARAK_KABUL_EDEBILIR, ~r~N_~y~TUSUNA_BASARAK_REDDEDEBILIRSIN.", ReturnName(playerid)));
	        InfoTD_MSG(playerid, 2, 5000, sprintf("~b~%s~p~_ISIMLI_KISIYE_TEKLIF_GONDERILDI,_LUTFEN_CEVABINI_BEKLEYIN.", ReturnName(toplayer)));
	    }
	}

	SetPVarInt(toplayer, "Mechanic_ID", playerid);
	SetPVarInt(toplayer, "Mechanic_Type", type);
	return 1;
}

Server:Mechanic_Count(playerid)
{
	if(GetPVarInt(playerid, "Mechanic_Started") == 0) 
	{
		KillTimer(PaintJobTimer[playerid]);
		PaintJobTimer[playerid] = -1;
		return 1;
	}	

    new vehicleid = GetPVarInt(playerid, "Mechanic_CarID");

	new Float: x, Float: y, Float: z; GetVehiclePos(vehicleid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Spraylad���n arac�n yak�n�nda de�ilsin, i�lem iptal edildi.");
		SetPVarInt(playerid, "Mechanic_Started", 0);
		SetPVarInt(playerid, "Mechanic_CarID", INVALID_VEHICLE_ID);
		SetPVarInt(playerid, "Mechanic_Type", -1);
		KillTimer(PaintJobTimer[playerid]);
		PaintJobTimer[playerid] = -1;
		return 1;
	}

	SetPVarInt(playerid, "Mechanic_Time", GetPVarInt(playerid, "Mechanic_Time") - 1);
	GameTextForPlayer(playerid, sprintf("~r~Islem Yapiliyor~n~~w~%d]", GetPVarInt(playerid, "Mechanic_Time")), 3000, 3);

	if(GetPVarInt(playerid, "Mechanic_Time") <= 0)
	{
		new type = GetPVarInt(playerid, "Mechanic_Type");
    	
		SetPVarInt(playerid, "Mechanic_Started", 0);
		SetPVarInt(playerid, "Mechanic_CarID", INVALID_VEHICLE_ID);
		SetPVarInt(playerid, "Mechanic_Type", -1);
		KillTimer(PaintJobTimer[playerid]);
		PaintJobTimer[playerid] = -1;

		switch(type)
		{
			case 0:
			{
 				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ��ini bitirdin, 7 adet tamir par�as� harcad�n!");
				CarData[vehicleid][carColor1] = GetPVarInt(playerid, "Mechanic_Color1"), CarData[vehicleid][carColor2] = GetPVarInt(playerid, "Mechanic_Color2");
				ChangeVehicleColor(vehicleid, CarData[vehicleid][carColor1], CarData[vehicleid][carColor2]), PlayerData[playerid][pComponents] -= 7;
			}
			case 1:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ��ini bitirdin, 10 adet tamir par�as� harcad�n!");
				RepairVehicle(vehicleid), PlayerData[playerid][pComponents] -= 10;
			}
			case 2:
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ��ini bitirdin, 15 adet tamir par�as� harcad�n!");
    			RepairVehicle(vehicleid), SetVehicleHealth(vehicleid, 1000.0);
    			PlayerData[playerid][pComponents] -= 15;
			}
			case 3:
			{
   				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ��ini bitirdin, 20 adet tamir par�as� harcayarak motorun g�c�n� +15.00 artt�rd�n!");
    			CarData[vehicleid][carEngine] += 15.00;
    			PlayerData[playerid][pComponents] -= 20;
			}
			case 4:
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ��ini bitirdin, 20 adet tamir par�as� harcayarak batarya g�c�n� +15.00 artt�rd�n!");
    			CarData[vehicleid][carBattery] += 15.00;
    			PlayerData[playerid][pComponents] -= 20;
			}
			case 5:
			{
				if(IsValidPlayerCar(vehicleid))
				{
				    CarData[vehicleid][carFuel] += 10;
				}

				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ��ini bitirdin, 12 adet tamir par�as� harcayarak +10.00 benzin ekledin!");
				PlayerData[playerid][pComponents] -= 12;
			}
		}
	}
	return 1;
}

Server:InfoTD_MSG(playerid, type, ms_time, text[])
{
	if(GetPVarInt(playerid, "InfoTDshown") != -1)
	{
		switch(type)
		{
			case 1: PlayerTextDrawHide(playerid, PlayerOffer[playerid]);
			case 2: PlayerTextDrawHide(playerid, PlayerOffer2[playerid]);
		}
	    KillTimer(GetPVarInt(playerid, "InfoTDshown"));
	}
	
	switch(type)
	{
		case 1: 
		{
			PlayerTextDrawSetString(playerid, PlayerOffer[playerid], text);
    		PlayerTextDrawShow(playerid, PlayerOffer[playerid]);
		}
		case 2: 
		{
			PlayerTextDrawSetString(playerid, PlayerOffer2[playerid], text);
    		PlayerTextDrawShow(playerid, PlayerOffer2[playerid]);
		}
	}

	SetPVarInt(playerid, "InfoTDshown", SetTimerEx("InfoTD_Hide", ms_time, false, "ii", playerid, type));
}

Server:InfoTD_Hide(playerid, type)
{
	SetPVarInt(playerid, "InfoTDshown", -1);
	switch(type)
	{
		case 1: PlayerTextDrawHide(playerid, PlayerOffer[playerid]);
		case 2: PlayerTextDrawHide(playerid, PlayerOffer2[playerid]);
	}
}