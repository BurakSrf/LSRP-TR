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
		SendClientMessage(playerid, COLOR_GREY, "�pucu: '/cop yardim' yazarak t�m listeyi g�rebilirsin.");
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
	if(!GetPVarType(playerid, "AtGarbage")) return SendClientMessage(playerid, COLOR_ADM, "HATA: Yak�n�nda ��p kutusu yok.");
	if(PlayerData[playerid][pCarryTrash]) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p ta��yorsun.");
	new g = GetPVarInt(playerid, "AtGarbage");
    if(GarbageData[g][GarbageTakenCapacity] <= 0) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p kalmam��.");

	PlayerData[playerid][pCarryTrash] = true;
	ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0);
	SetPlayerAttachedObject(playerid, 7, 1264, 6, 0.222, 0.024, 0.128, 1.90, -90.0, 0.0, 0.5,0.5, 0.5);
	//SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    GarbageData[g][GarbageTakenCapacity]-= 1;
    return 1;
}

TrashCMD_Put(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p� b�rakmak i�in ara�tan in.");
	if(!PlayerData[playerid][pCarryTrash]) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p ta��m�yorsun.");

	new vehicleID = GetNearestVehicle(playerid);
	if(vehicleID == INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_ADM, "HATA: Yak�n�nda ara� yok.");
	if(!IsValidPlayerCar(vehicleID)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sunucuya kay�tl� bir ara� de�il.");
    if(CarData[vehicleID][carModel] != 408) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu ��p��l�k yapabilece�in bir ara� de�il.");
	if(CarData[vehicleID][carTrashCount] > 50) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kamyona daha fazla ��p koyamazs�n.");

    PlayerData[playerid][pCarryTrash] = false;
	ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0);
	//SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 7);
	CarData[vehicleID][carTrashCount]+= 1;
    return 1;
}

TrashCMD_List(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p listesine bakmak i�in �of�r koltu�una bin.");

	new vehicleID = GetNearestVehicle(playerid);
	if(vehicleID == INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_ADM, "HATA: Yak�n�nda ara� yok.");
	if(!IsValidPlayerCar(vehicleID)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sunucuya kay�tl� bir ara� de�il.");
    if(CarData[vehicleID][carModel] != 408) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu ��p��l�k yapabilece�in bir ara� de�il.");
	if(CarData[vehicleID][carTrashCount] > 50) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kamyona daha fazla ��p koyamazs�n.");
	if(!CarData[vehicleID][carTrashCount]) return SendClientMessageEx(playerid, COLOR_ADM, "HATA: Bu ara�ta ��p bulunmuyor.");
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_LIST, "Kamyon ��p Durumu", sprintf("{C3C3C3}%i adet\t{FFFFFF}��p mevcut.", CarData[vehicleID][carTrashCount]), "Kapat", "");
    return 1;
}

TrashCMD_Destroy(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p� silmek i�in ara�tan in.");
	if(!PlayerData[playerid][pCarryTrash]) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p ta��m�yorsun.");

    PlayerData[playerid][pCarryTrash] = false;
	RemovePlayerAttachedObject(playerid, 7);
	return 1;
}

TrashCMD_Sell(const playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_ADM, "HATA: ��pleri satmak i�in �of�r koltu�una bin.");
	if(!IsPlayerInRangeOfPoint(playerid, TRASH_RANGE, TRASH_X, TRASH_Y, TRASH_Z))
    {
 		SetPlayerCheckpoint(playerid, TRASH_X, TRASH_Y, TRASH_Z, TRASH_RANGE);
 	   	return SendClientMessage(playerid, COLOR_ADM, "HATA: ��p satma noktas�nda de�ilsin.");
	}
	new vehicleID = GetPlayerVehicleID(playerid);
	if(!IsValidPlayerCar(vehicleID)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sunucuya kay�tl� bir ara� de�il.");
    if(CarData[vehicleID][carModel] != 408) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu ��p��l�k yapabilece�in bir ara� de�il.");
    if(!CarData[vehicleID][carTrashCount]) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kamyonda ��p yok.");

    PlayerData[playerid][pCarryTrash] = false;
	RemovePlayerAttachedObject(playerid, 7);

	//CarData[vehicleID][carTrashCount] * 7
	return 1;
}
