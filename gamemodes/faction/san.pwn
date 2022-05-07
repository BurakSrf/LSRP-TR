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
		if(PlayerData[playerid][pLiveBroadcast] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Zaten canl� yay�n� ba�latm��s�n.");
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Canl� yay�na ba�lad�n�z, s�yleyeceklerinizi dinleyenleriniz duyacakt�r.");
		PlayerData[playerid][pLiveBroadcast] = playerid;
		return 1;
	}
	else if (!strcmp(type, "bitir", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Zaten canl� yay�n� bitirmi�sin.");
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Canl� yay�n� bitirdiniz, art�k s�yleyeceklerinizi duymayacaklard�r.");
		PlayerData[playerid][pLiveBroadcast] = INVALID_PLAYER_ID;

		foreach(new i : Player) if(PlayerData[i][pLiveBroadcast] == playerid)
		{
			SendClientMessage(i, COLOR_YELLOW, "SERVER: Canl� yay�n� sona erdi, art�k s�yleyeceklerinizi duymayacaklard�r.");
			PlayerData[i][pLiveBroadcast] = INVALID_PLAYER_ID;
		}
		return 1;
 	}
 	else if (!strcmp(type, "davet", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Canl� yay�na ba�lamadan bu komutu kullanamazs�n.");

		static id;
		if (sscanf(string, "u", id)) return SendUsageMessage(playerid, "/yayin davet [oyuncu ID/ad�]");
		if(playerid == id) return SendErrorMessage(playerid, "Bu komutu kendi �st�nde kullanamazs�n.");
		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
		if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
		if(PlayerData[id][pLiveBroadcast] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Belirtti�in ki�i zaten canl� yay�nda g�z�k�yor.");
		if(PlayerData[id][pLiveOffer] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Belirtti�in ki�iye ba�ka birisi davet g�ndermi�.");
		if(PlayerData[id][pLiveOffer] == playerid) return SendErrorMessage(playerid, "Belirtti�in ki�inin davetini kabul etmesini bekle.");

		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s isimli ki�iyi canl� yay�na davet ettiniz.", ReturnName(id));
		SendClientMessageEx(id, COLOR_GREY, "SERVER: %s seni canl� yay�na davet etti. /kabul yayin %i yazarak yay�na kat�labilirsin.", ReturnName(playerid), playerid);
		PlayerData[id][pLiveOffer] = playerid;
		return 1;
 	}
 	else if (!strcmp(type, "cikar", true))
	{
		if(PlayerData[playerid][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Canl� yay�na ba�lamadan bu komutu kullanamazs�n.");
		if(PlayerData[playerid][pLiveBroadcast] != playerid) return SendErrorMessage(playerid, "Bu komutu sadece yay�n� ba�latan ki�i kullanabilir.");

		static id;
		if (sscanf(string, "u", id)) return SendUsageMessage(playerid, "/yayin cikar [oyuncu ID/ad�]");
		if(playerid == id) return SendErrorMessage(playerid, "Bu komutu kendi �st�nde kullanamazs�n.");
		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
		if(!GetDistanceBetweenPlayers(playerid, id, 4.5)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
		if(PlayerData[id][pLiveBroadcast] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Belirtti�in ki�i zaten canl� yay�nda g�z�km�yor.");

		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s isimli ki�iyi canl� yay�ndan ��kard�n�z.", ReturnName(id));
		SendClientMessageEx(id, COLOR_YELLOW, "SERVER: %s taraf�ndan canl� yay�ndan ��kar�ld�n�z, art�k s�yleyeceklerinizi duymayacaklard�r.", ReturnName(playerid));
		PlayerData[id][pLiveBroadcast] = INVALID_PLAYER_ID;
		return 1;
 	}
 	return 1;
}