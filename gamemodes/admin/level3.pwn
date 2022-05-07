CMD:skin(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 3) return UnAuthMessage(playerid);

	static playerb, skinid;
	if(sscanf(params, "ui", playerb, skinid)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: {FFFFFF}/skin [oyuncuID/isim] [skin ID]");
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(skinid <= 0 || skinid == 74 || skinid > 30000) return SendErrorMessage(playerid, "Hatal� skin ID girdiniz.");

	PlayerData[playerb][pSkin] = skinid;
	SetPlayerSkin(playerb, PlayerData[playerb][pSkin]);
	SaveSQLInt(PlayerData[playerid][pSQLID], "players", "Skin", PlayerData[playerid][pSkin]);
	LogAdminAction(playerid, sprintf("%s isimli ki�inin k�yafetini %d yapt�.", ReturnName(playerb, 1), skinid));

	SendClientMessageEx(playerid, COLOR_GREY, "AdmCmd: %s isimli oyuncunun k�yafetini %i olarak ayarlad�n.", ReturnName(playerb, 0), skinid);
	SendClientMessageEx(playerb, COLOR_GREY, "AdmCmd: %s isimli y�netici k�yafetini %i olarak ayarlad�.", PlayerData[playerid][pAdminName], skinid);
	return 1;
}

CMD:gotopos(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3) return UnAuthMessage(playerid);

	static Float:x, Float:y, Float:z;
	if (sscanf(params, "fff", x, y, z)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: {FFFFFF}/gotopos [x] [y] [z]");
	SetPlayerPos(playerid, x, y, z);
	
	SendClientMessageEx(playerid, COLOR_GREY, "AdmCmd: %f %f %f koordinatlar�na ���nland�n.", x, y, z);
	return 1;
}
