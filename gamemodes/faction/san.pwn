IsNewsFaction(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
		return 0;

	new factionid = PlayerData[playerid][pFaction];

	if (FactionData[factionid][FactionSanPerms])
		return 1;

	return 0;
}

CMD:yayin(playerid, params[])
{
	if(!IsNewsFaction(playerid)) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/yayin [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}baslat, bitir, davet, cikar");
		return 1;
	}

	if(!strcmp(type, "baslat", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Zaten canlý yayýný baþlatmýþsýn.");
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Canlý yayýna baþladýnýz, söyleyeceklerinizi dinleyenleriniz duyacaktýr.");
		PlayerData[playerid][pLiveBroadcast] = playerid;
		return 1;
	}
	else if (!strcmp(type, "bitir", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Zaten canlý yayýný bitirmiþsin.");
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Canlý yayýný bitirdiniz, artýk söyleyeceklerinizi duymayacaklardýr.");
		PlayerData[playerid][pLiveBroadcast] = INVALID_PLAYER_ID;

		foreach(new i : Player) if(PlayerData[i][pLiveBroadcast] == playerid)
		{
			SendClientMessage(i, COLOR_YELLOW, "SERVER: Canlý yayýný sona erdi, artýk söyleyeceklerinizi duymayacaklardýr.");
			PlayerData[i][pLiveBroadcast] = INVALID_PLAYER_ID;
		}
		return 1;
 	}
 	else if (!strcmp(type, "davet", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Canlý yayýna baþlamadan bu komutu kullanamazsýn.");

		static id;
		if (sscanf(string, "u", id)) return SendUsageMessage(playerid, "/yayin davet [oyuncu ID/adý]");
		if(playerid == id) return SendErrorMessage(playerid, "Bu komutu kendi üstünde kullanamazsýn.");
		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
		if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
		if(PlayerData[id][pLiveBroadcast] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Belirttiðin kiþi zaten canlý yayýnda gözüküyor.");
		if(PlayerData[id][pLiveOffer] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Belirttiðin kiþiye baþka birisi davet göndermiþ.");
		if(PlayerData[id][pLiveOffer] == playerid) return SendErrorMessage(playerid, "Belirttiðin kiþinin davetini kabul etmesini bekle.");

		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s isimli kiþiyi canlý yayýna davet ettiniz.", ReturnName(id));
		SendClientMessageEx(id, COLOR_GREY, "SERVER: %s seni canlý yayýna davet etti. /kabul yayin %i yazarak yayýna katýlabilirsin.", ReturnName(playerid), playerid);
		PlayerData[id][pLiveOffer] = playerid;
		return 1;
 	}
 	else if (!strcmp(type, "cikar", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Canlý yayýna baþlamadan bu komutu kullanamazsýn.");
		if(PlayerData[playerid][pLiveBroadcast] != playerid) return SendErrorMessage(playerid, "Bu komutu sadece yayýný baþlatan kiþi kullanabilir.");

		static id;
		if (sscanf(string, "u", id)) return SendUsageMessage(playerid, "/yayin cikar [oyuncu ID/adý]");
		if(playerid == id) return SendErrorMessage(playerid, "Bu komutu kendi üstünde kullanamazsýn.");
		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
		if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
		if(PlayerData[id][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Belirttiðin kiþi zaten canlý yayýnda gözükmüyor.");

		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s isimli kiþiyi canlý yayýndan çýkardýnýz.", ReturnName(id));
		SendClientMessageEx(id, COLOR_YELLOW, "SERVER: %s tarafýndan canlý yayýndan çýkarýldýnýz, artýk söyleyeceklerinizi duymayacaklardýr.", ReturnName(playerid));
		PlayerData[id][pLiveBroadcast] = INVALID_PLAYER_ID;
		return 1;
 	}
 	return 1;
}