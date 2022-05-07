CMD:clearguns(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/clearguns [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	adminWarn(1, sprintf("%s isimli yönetici %s isimli oyuncunun tüm silahlarýný sýfýrladý.", ReturnName(playerid), ReturnName(id)));
	SendServerMessage(playerid, "%s isimli oyuncunun tüm silahlarýný sýfýrladýn.", ReturnName(id));
	SendServerMessage(id, "%s isimli yönetici tüm silahlarýný sýfýrladý.", ReturnName(playerid));
	TakePlayerGuns(id);
	return 1;
}

CMD:checkdrugs(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/checkdrugs [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	SendClientMessageEx(playerid, COLOR_ADM, "%s Uyuþturucularý:", ReturnName(id, 0));
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
		SendClientMessage(playerid, COLOR_ADM, "Uyarý: Can kýsmýný boþ býrakýrsanýz kiþinin maksimum caný olarak ayarlanýr.");
		return 1;
	}

	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	LogAdminAction(playerid, sprintf("%s isimli kiþinin canýný %.1f yaptý.", ReturnName(id, 1), health));
	SetPlayerHealth(id, health);
	return 1;
}

CMD:revive(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);

	static id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/revive [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!PlayerData[id][pBrutallyWounded]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi yaralanmamýþ/ölmemiþ.");
	
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
	SetPlayerChatBubble(id, "Canlandýrýldý", COLOR_WHITE, 20.0, 2000);
	SetPlayerHealth(id, PlayerData[id][pMaxHealth]);
	TogglePlayerControllable(id, true);
	SetPlayerTeam(id, STATE_ALIVE);
	Damages_Clear(id);

	LogAdminAction(playerid, sprintf("%s isimli kiþinin canlandýrdý.", ReturnName(id, 1)));
	return 1;
}
