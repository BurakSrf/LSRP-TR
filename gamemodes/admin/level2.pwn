CMD:set(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	new id, type[8];
	if(sscanf(params, "s[8]I(-1)", type, id)) return SendUsageMessage(playerid, "/set [hava/zaman] [deðer]");

	if(!strcmp(type, "hava"))
	{
		if(id == -1) return SendUsageMessage(playerid, "/set hava [hava ID]");
		if(id < 1 || id > 50) return SendErrorMessage(playerid, "Hatalý hava ID girdin.");
		adminWarn(1, sprintf("%s isimli yönetici havayý %i olarak ayarladý.", ReturnName(playerid, 1), id));
		weather = id; SetWeather(id);
		return 1;
	}
	else if(!strcmp(type, "zaman"))
	{
		if(id == -1) return SendUsageMessage(playerid, "/set zaman [saat]");
		if(id < 0 || id > 23) return SendErrorMessage(playerid, "Hatalý zaman aralýðý girdin.");
		adminWarn(1, sprintf("%s isimli yönetici zamaný %i olarak ayarladý.", ReturnName(playerid, 1), id));
		SetWorldTime(id);
		return 1;
	} 
	else SendUsageMessage(playerid, "/set [hava/zaman] [deðer]");
	return 1;
}

CMD:agit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	static id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/agit [araç ID]");
	if(!IsValidVehicle(id)) return SendErrorMessage(playerid, "Hatalý araç ID girdin.");

	new Float: x, Float: y, Float: z, Float: a;
	GetVehiclePos(id, x, y, z); GetVehicleZAngle(id, a);
	SendPlayer(playerid, x, y, z, a, GetVehicleInterior(id), GetVehicleVirtualWorld(id));
	SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %i numaralý aracýn yanýna ýþýnlandýn.", id);
	return 1;
}

CMD:agetir(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	static id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/agetir [araç ID]");
	if(!IsValidVehicle(id)) return SendErrorMessage(playerid, "Hatalý araç ID girdin.");

	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z); SetVehiclePos(id, x+1, y, z);
	SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %i numaralý aracý yanýna getirdin.", id);
	return 1;
}

CMD:abindir(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	new id, vehicleid, seat;
	if(sscanf(params, "uii", id, vehicleid, seat)) return SendUsageMessage(playerid, "/abindir [oyuncu ID/adý] [araç ID] [koltuk]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!IsValidVehicle(vehicleid)) return SendErrorMessage(playerid, "Hatalý araç ID girdiniz.");
	if(seat < 0 || seat > 4) return SendErrorMessage(playerid, "Hatalý koltuk numarasý girdiniz.");
	if(!IsSeatAvailable(vehicleid, seat)) return SendErrorMessage(playerid, "Bu koltuk dolu gözüküyor.");
	adminWarn(1, sprintf("%s isimli yönetici %s isimli oyuncuyu %i numaralý araca bindirdi.", ReturnName(playerid), ReturnName(id), seat));
	PutPlayerInVehicle(id, vehicleid, seat);
	return 1;
}

CMD:cleardrugs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/cleardrugs [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!Player_GetDrugCount(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþinin hiç uyuþturucusu yok.");

	adminWarn(2, sprintf("%s isimli yönetici %s isimli oyuncunun tüm uyuþturucularýný sýfýrladý.", ReturnName(playerid), ReturnName(id)));
	SendServerMessage(playerid, "%s isimli oyuncunun tüm uyuþturucularýný sýfýrladýn.", ReturnName(id));
	SendServerMessage(id, "%s isimli yönetici tüm uyuþturucularýný sýfýrladý.", ReturnName(playerid));
	for(new i = 1; i < MAX_PACK_SLOT; ++i) Drug_DefaultValues(playerid, i);
	return 1;
}