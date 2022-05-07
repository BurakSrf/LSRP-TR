CMD:set(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	new id, type[8];
	if(sscanf(params, "s[8]I(-1)", type, id)) return SendUsageMessage(playerid, "/set [hava/zaman] [de�er]");

	if(!strcmp(type, "hava"))
	{
		if(id == -1) return SendUsageMessage(playerid, "/set hava [hava ID]");
		if(id < 1 || id > 50) return SendErrorMessage(playerid, "Hatal� hava ID girdin.");
		adminWarn(1, sprintf("%s isimli y�netici havay� %i olarak ayarlad�.", ReturnName(playerid, 1), id));
		weather = id; SetWeather(id);
		return 1;
	}
	else if(!strcmp(type, "zaman"))
	{
		if(id == -1) return SendUsageMessage(playerid, "/set zaman [saat]");
		if(id < 0 || id > 23) return SendErrorMessage(playerid, "Hatal� zaman aral��� girdin.");
		adminWarn(1, sprintf("%s isimli y�netici zaman� %i olarak ayarlad�.", ReturnName(playerid, 1), id));
		SetWorldTime(id);
		return 1;
	} 
	else SendUsageMessage(playerid, "/set [hava/zaman] [de�er]");
	return 1;
}

CMD:agit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	static id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/agit [ara� ID]");
	if(!IsValidVehicle(id)) return SendErrorMessage(playerid, "Hatal� ara� ID girdin.");

	new Float: x, Float: y, Float: z, Float: a;
	GetVehiclePos(id, x, y, z); GetVehicleZAngle(id, a);
	SendPlayer(playerid, x, y, z, a, GetVehicleInterior(id), GetVehicleVirtualWorld(id));
	SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %i numaral� arac�n yan�na ���nland�n.", id);
	return 1;
}

CMD:agetir(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	static id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/agetir [ara� ID]");
	if(!IsValidVehicle(id)) return SendErrorMessage(playerid, "Hatal� ara� ID girdin.");

	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z); SetVehiclePos(id, x+1, y, z);
	SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %i numaral� arac� yan�na getirdin.", id);
	return 1;
}

CMD:abindir(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	new id, vehicleid, seat;
	if(sscanf(params, "uii", id, vehicleid, seat)) return SendUsageMessage(playerid, "/abindir [oyuncu ID/ad�] [ara� ID] [koltuk]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Hatal� ara� ID girdiniz.");
	if(seat < 0 || seat > 4) return SendErrorMessage(playerid, "Hatal� koltuk numaras� girdiniz.");
	if(!IsSeatAvailable(vehicleid, seat)) return SendErrorMessage(playerid, "Bu koltuk dolu g�z�k�yor.");
	adminWarn(1, sprintf("%s isimli y�netici %s isimli oyuncuyu %i numaral� araca bindirdi.", ReturnName(playerid), ReturnName(id), seat));
	PutPlayerInVehicle(id, vehicleid, seat);
	return 1;
}

CMD:cleardrugs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/cleardrugs [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!Player_GetDrugCount(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�inin hi� uyu�turucusu yok.");

	adminWarn(2, sprintf("%s isimli y�netici %s isimli oyuncunun t�m uyu�turucular�n� s�f�rlad�.", ReturnName(playerid), ReturnName(id)));
	SendServerMessage(playerid, "%s isimli oyuncunun t�m uyu�turucular�n� s�f�rlad�n.", ReturnName(id));
	SendServerMessage(id, "%s isimli y�netici t�m uyu�turucular�n� s�f�rlad�.", ReturnName(playerid));
	for(new i = 1; i < MAX_PACK_SLOT; ++i) Drug_DefaultValues(playerid, i);
	return 1;
}