CMD:clearguns(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/clearguns [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	adminWarn(1, sprintf("%s isimli y�netici %s isimli oyuncunun t�m silahlar�n� s�f�rlad�.", ReturnName(playerid), ReturnName(id)));
	SendServerMessage(playerid, "%s isimli oyuncunun t�m silahlar�n� s�f�rlad�n.", ReturnName(id));
	SendServerMessage(id, "%s isimli y�netici t�m silahlar�n� s�f�rlad�.", ReturnName(playerid));
	TakePlayerGuns(id);
	return 1;
}

CMD:checkdrugs(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/checkdrugs [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	SendClientMessageEx(playerid, COLOR_ADM, "%s Uyu�turucular�:", ReturnName(id, 0));
	Player_ListDrugs(id, playerid);
	return 1;
}

CMD:health(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new id, Float: health;
	if(sscanf(params, "uf", id, health))
	{
		SendUsageMessage(playerid, "/health [oyuncu ID/isim] [can]");
		SendClientMessage(playerid, COLOR_ADM, "Uyar�: Can k�sm�n� bo� b�rak�rsan�z ki�inin maksimum can� olarak ayarlan�r.");
		return 1;
	}

	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	LogAdminAction(playerid, sprintf("%s isimli ki�inin can�n� %.1f yapt�.", ReturnName(id, 1), health));
	SetPlayerHealth(id, health);
	return 1;
}

CMD:revive(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	static id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/revive [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(!PlayerData[id][pBrutallyWounded]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i yaralanmam��/�lmemi�.");
	
	PlayerData[id][pLegShot] = 0;
	PlayerData[id][pLowSkill] = 0;
	PlayerData[id][pExecuteTime] = 0;
	PlayerData[id][pBrutallyWounded] = 0;
	SetPlayerSkillLevel(id, WEAPONSKILL_PISTOL, 899);
	SetPlayerSkillLevel(id, WEAPONSKILL_MICRO_UZI, 0);
	SetPlayerSkillLevel(id, WEAPONSKILL_SPAS12_SHOTGUN, 0);
	SetPlayerSkillLevel(id, WEAPONSKILL_AK47, 999);
    SetPlayerSkillLevel(id, WEAPONSKILL_DESERT_EAGLE, 999);
    SetPlayerSkillLevel(id, WEAPONSKILL_SHOTGUN, 999);
    SetPlayerSkillLevel(id, WEAPONSKILL_M4, 999);
    SetPlayerSkillLevel(id, WEAPONSKILL_MP5, 999);
	GameTextForPlayer(id, "~b~Canlandirildin", 3000, 4);
	SetPlayerChatBubble(id, "Canland�r�ld�", COLOR_WHITE, 20.0, 2000);
	SetPlayerHealth(id, PlayerData[id][pMaxHealth]);
	TogglePlayerControllable(id, true);
	SetPlayerTeam(id, STATE_ALIVE);
	Damages_Clear(id);

	LogAdminAction(playerid, sprintf("%s isimli ki�inin canland�rd�.", ReturnName(id, 1)));
	return 1;
}
