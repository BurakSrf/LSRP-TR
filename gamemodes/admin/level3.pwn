CMD:skin(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 3) return UnAuthMessage(playerid);

	static playerb, skinid;
	if(sscanf(params, "ui", playerb, skinid)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: {FFFFFF}/skin [oyuncuID/isim] [skin ID]");
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(skinid <= 0 || skinid == 74 || skinid > 30000) return SendErrorMessage(playerid, "Hatalý skin ID girdiniz.");

	PlayerData[playerb][pSkin] = skinid;
	SetPlayerSkin(playerb, PlayerData[playerb][pSkin]);
	SaveSQLInt(PlayerData[playerid][pSQLID], "players", "Skin", PlayerData[playerid][pSkin]);
	LogAdminAction(playerid, sprintf("%s isimli kiþinin kýyafetini %d yaptý.", ReturnName(playerb, 1), skinid));

	SendClientMessageEx(playerid, COLOR_GREY, "AdmCmd: %s isimli oyuncunun kýyafetini %i olarak ayarladýn.", ReturnName(playerb, 0), skinid);
	SendClientMessageEx(playerb, COLOR_GREY, "AdmCmd: %s isimli yönetici kýyafetini %i olarak ayarladý.", PlayerData[playerid][pAdminName], skinid);
	return 1;
}

CMD:gotopos(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3) return UnAuthMessage(playerid);

	static Float:x, Float:y, Float:z;
	if (sscanf(params, "fff", x, y, z)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: {FFFFFF}/gotopos [x] [y] [z]");
	SetPlayerPos(playerid, x, y, z);
	
	SendClientMessageEx(playerid, COLOR_GREY, "AdmCmd: %f %f %f koordinatlarýna ýþýnlandýn.", x, y, z);
	return 1;
}
