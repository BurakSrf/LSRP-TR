CMD:cop(playerid, params[])
{
    Trash_RouteCommands(playerid, params);
	return 1;
}

Trash_RouteCommands(playerid, cmdtext[])
{
    new command[6];
    sscanf(cmdtext, "s[6]", command);

	if(strlen(command) == 0) {
		SendClientMessage(playerid, COLOR_GREY, "KULLANIM: /cop [komut]");
		SendClientMessage(playerid, COLOR_GREY, "Ýpucu: '/cop yardim' yazarak tüm listeyi görebilirsin.");
		return 1;
	}

    if(strcmp("al", command) == 0) TrashCMD_Take(playerid);
    else if(strcmp("koy", command) == 0) TrashCMD_Put(playerid);
	else if(strcmp("liste", command) == 0) TrashCMD_List(playerid);
    else if(strcmp("sil", command) == 0) TrashCMD_Destroy(playerid);
    else if(strcmp("sat", command) == 0) TrashCMD_Sell(playerid);
	return 1;
}

TrashCMD_Take(const playerid)
{
	if(!GetPVarType(playerid, "AtGarbage")) return SendClientMessage(playerid, COLOR_ADM, "HATA: Yakýnýnda çöp kutusu yok.");
	if(PlayerData[playerid][pCarryTrash]) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöp taþýyorsun.");
	new g = GetPVarInt(playerid, "AtGarbage");
    if(GarbageData[g][GarbageTakenCapacity] <= 0) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöp kalmamýþ.");

	PlayerData[playerid][pCarryTrash] = true;
	ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0);
	SetPlayerAttachedObject(playerid, 7, 1264, 6, 0.222, 0.024, 0.128, 1.90, -90.0, 0.0, 0.5,0.5, 0.5);
	//SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    GarbageData[g][GarbageTakenCapacity]-= 1;
    return 1;
}

TrashCMD_Put(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöpü býrakmak için araçtan in.");
	if(!PlayerData[playerid][pCarryTrash]) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöp taþýmýyorsun.");

	new vehicleID = GetNearestVehicle(playerid);
	if(vehicleID == INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_ADM, "HATA: Yakýnýnda araç yok.");
	if(!IsValidPlayerCar(vehicleID)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sunucuya kayýtlý bir araç deðil.");
    if(CarData[vehicleID][carModel] != 408) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu çöpçülük yapabileceðin bir araç deðil.");
	if(CarData[vehicleID][carTrashCount] > 50) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kamyona daha fazla çöp koyamazsýn.");

    PlayerData[playerid][pCarryTrash] = false;
	ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0);
	//SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 7);
	CarData[vehicleID][carTrashCount]+= 1;
    return 1;
}

TrashCMD_List(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöp listesine bakmak için þoför koltuðuna bin.");

	new vehicleID = GetNearestVehicle(playerid);
	if(vehicleID == INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_ADM, "HATA: Yakýnýnda araç yok.");
	if(!IsValidPlayerCar(vehicleID)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sunucuya kayýtlý bir araç deðil.");
    if(CarData[vehicleID][carModel] != 408) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu çöpçülük yapabileceðin bir araç deðil.");
	if(CarData[vehicleID][carTrashCount] > 50) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kamyona daha fazla çöp koyamazsýn.");
	if(!CarData[vehicleID][carTrashCount]) return SendClientMessageEx(playerid, COLOR_ADM, "HATA: Bu araçta çöp bulunmuyor.");
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "Kamyon Çöp Durumu", sprintf("{C3C3C3}%i adet\t{FFFFFF}çöp mevcut.", CarData[vehicleID][carTrashCount]), "Kapat", "");
    return 1;
}

TrashCMD_Destroy(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöpü silmek için araçtan in.");
	if(!PlayerData[playerid][pCarryTrash]) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöp taþýmýyorsun.");

    PlayerData[playerid][pCarryTrash] = false;
	RemovePlayerAttachedObject(playerid, 7);
	return 1;
}

TrashCMD_Sell(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöpleri satmak için þoför koltuðuna bin.");
	if(!IsPlayerInRangeOfPoint(playerid, TRASH_RANGE, TRASH_X, TRASH_Y, TRASH_Z))
    {
 		SetPlayerCheckpoint(playerid, TRASH_X, TRASH_Y, TRASH_Z, TRASH_RANGE);
 	   	return SendClientMessage(playerid, COLOR_ADM, "HATA: Çöp satma noktasýnda deðilsin.");
	}
	new vehicleID = GetPlayerVehicleID(playerid);
	if(!IsValidPlayerCar(vehicleID)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sunucuya kayýtlý bir araç deðil.");
    if(CarData[vehicleID][carModel] != 408) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu çöpçülük yapabileceðin bir araç deðil.");
    if(!CarData[vehicleID][carTrashCount]) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kamyonda çöp yok.");

    PlayerData[playerid][pCarryTrash] = false;
	RemovePlayerAttachedObject(playerid, 7);

	//CarData[vehicleID][carTrashCount] * 7
	return 1;
}
