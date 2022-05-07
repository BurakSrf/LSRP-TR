CMD:fac(playerid, params[]) return cmd_f(playerid, params);
CMD:f(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(!PlayerData[playerid][pFactionStatus]) return SendErrorMessage(playerid, "Birlik kanal�n� kapatm��s�n, /tog birlik yazarak a�abilirsin.");

	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionChatrank])
	    return SendErrorMessage(playerid, "Birlik kanal�ndan konu�abilmek i�in r�tben yetersiz.");

	if(isnull(params)) return SendUsageMessage(playerid, "/f [mesaj]");

	if(FactionData[PlayerData[playerid][pFaction]][FactionChatStatus])
    {
        if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank] && !PlayerData[playerid][pAdminDuty])
        {
            SendErrorMessage(playerid, "Birlik kanal� birlik y�neticileri taraf�ndan kapat�lm��.");
		}
		else
		{
			SendFactionMessage(playerid, sprintf("**(( %s %s: %s ))**", Player_GetFactionRank(playerid), ReturnName(playerid, 1), params));
		}
	}
	else
	{
		SendFactionMessage(playerid, sprintf("**(( %s %s: %s ))**", Player_GetFactionRank(playerid), ReturnName(playerid, 1), params));
	}
	return true;
}

CMD:frozet(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
    if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
        return SendClientMessage(playerid, COLOR_ADM, "ER���M REDDED�LD�:{FFFFFF} Rozet numaralar�n� ayarlamak i�in r�tben yetersiz.");

    new id, badge;
    if(sscanf(params, "ui", id, badge)) return SendUsageMessage(playerid, "/frozet [oyuncu ID/isim] [rozet numaras�]");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s isimli oyuncunun rozet numaras�n� #%d olarak g�ncelledin.", ReturnName(id), badge);
    SendClientMessageEx(id, COLOR_YELLOW, "SERVER: Rozet numaran #%d olarak g�ncellendi.", badge);
    SaveSQLInt(PlayerData[id][pSQLID], "players", "Badge", badge);
    PlayerData[id][pBadge] = badge;
    return 1;
}

CMD:frutbeayarla(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik r�tbelerini ayarlamak i�in r�tben yetersiz.");

	new rank[60], rankn, faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "ds[60]", rankn, rank))
	{
		SendUsageMessage(playerid, "/frutbeayarla [r�tbe ID] [r�tbe ad�]");
		return 1;
	}

	if(rankn > 20 || rankn < 1)
		return SendErrorMessage(playerid, "Hatal� r�tbe ID girdin.");

	if(strlen(rank) > 60)
		return SendErrorMessage(playerid, "R�tbe ad� 60 karakterden fazla olamaz.");

	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}#%i numaral� r�tbenin ad�n� %s olarak de�i�tirdin!", rankn, rank);
	FactionRanks[faction][rankn] = rank;
	Faction_SaveRanks(faction);
	return 1;
}

CMD:fkapat(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik kanal�n� ayarlamak i�in r�tben yetersiz.");

	new faction = PlayerData[playerid][pFaction];
	if(!FactionData[faction][FactionChatStatus])
	{
		SendFactionMessageEx(playerid, COLOR_ADM, sprintf("[!] {FFFFFF}%s birlik kanal�n� kullan�ma kapatt�.", ReturnName(playerid, 1)));
		FactionData[faction][FactionChatStatus] = true;
	}
	else
	{
		SendFactionMessageEx(playerid, COLOR_ADM, sprintf("[!] {FFFFFF}%s birlik kanal�n� kullan�ma a�t�.", ReturnName(playerid, 1)));
		FactionData[faction][FactionChatStatus] = false;
	}
	return 1;
}

CMD:frenk(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik kanal� rengini ayarlamak i�in r�tben yetersiz.");

	new color, faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "x", color)) return SendUsageMessage(playerid, "/frenk [hex code (�rnek: 0x(6 haneli kod buraya)FF)]");

	SendClientMessageEx(playerid, COLOR_ADM, sprintf("[!] {FFFFFF}Birlik kanal rengi %x olarak ayarland�.", color));
	FactionData[PlayerData[playerid][pFaction]][FactionChatColor] = color;
	SaveSQLInt(faction, "factions", "ChatColor", FactionData[faction][FactionChatColor]);
	return true;
}

CMD:fisim(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] != 1) return SendErrorMessage(playerid, "Bu komutu sadece en y�ksek r�tbe kullanabilir.");

	new name[128], faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "s[128]", name)) return SendUsageMessage(playerid, "/fisim [birlik ad�]");
	SendClientMessageEx(playerid, COLOR_ADM, "[!] {FFFFFF}Birlik isminiz %s olarak de�i�tirildi.", name);
	format(FactionData[faction][FactionName], 128, "%s", name);
	Faction_Save(faction);
	return 1;
}

CMD:fkisaltma(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] != 1) return SendErrorMessage(playerid, "Bu komutu sadece en y�ksek r�tbe kullanabilir.");

	new name[128], faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "s[128]", name)) return SendUsageMessage(playerid, "/fkisaltma [k�saltma]");
	SendClientMessageEx(playerid, COLOR_ADM, "[!] {FFFFFF}Birlik k�saltman�z %s olarak de�i�tirildi.", name);
	format(FactionData[faction][FactionAbbrev], 128, "%s", name);
	Faction_Save(faction);
	return 1;
}

CMD:fkabul(playerid, params[])
{
	if(PlayerData[playerid][pFactionOffer] == -1) return SendErrorMessage(playerid, "Herhangi bir birli�e davet edilmemi�sin.");

	PlayerData[playerid][pFaction] = PlayerData[playerid][pFactionOffer];
	SaveSQLInt(PlayerData[playerid][pSQLID], "players", "Faction", PlayerData[playerid][pFaction]);

	PlayerData[playerid][pFactionRank] = FactionData[PlayerData[playerid][pFactionOffer]][FactionMaxRanks];
	SaveSQLInt(PlayerData[playerid][pSQLID], "players", "FactionRank", PlayerData[playerid][pFactionRank]);
	PlayerData[playerid][pSpawnPoint] = 3;

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Art�k %s birli�inin bir �yesisin!", FactionData[PlayerData[playerid][pFaction]][FactionName]);
	PlayerData[playerid][pFactionOffer] = -1;
	return 1;
}

CMD:fdavet(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");

	new playerb;
	if(sscanf(params, "u", playerb)) return SendUsageMessage(playerid, "/fdavet [oyuncu ID/isim]");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik davet komutunu kullanmak i�in r�tben yetersiz.");
	
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i aktif de�il.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(PlayerData[playerb][pFaction] != -1) return SendErrorMessage(playerid, "Belirtti�iniz ki�i zaten herhangi bir birlikte bulunuyor.");

	SendClientMessageEx(playerb, COLOR_YELLOW, "SERVER: %s seni %s birli�ine davet etti, kabul etmek i�in /fkabul yazabilirsin.", ReturnName(playerid, 0), FactionData[PlayerData[playerid][pFaction]][FactionName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s isimli ki�iyi %s birli�ine davet ettin, kabul etmesi i�in /fkabul yazmal�.", ReturnName(playerb, 0), FactionData[PlayerData[playerid][pFaction]][FactionName]);
	PlayerData[playerb][pFactionOffer] = PlayerData[playerid][pFaction];
	return 1;
}

/*CMD:ofkov(playerid, params[])
{
	if(!PlayerData[playerid][pFaction])
		return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][factionEditrank])
		return SendErrorMessage(playerid, "Birlikten atma komutunu kullanmak i�in r�tben yetersiz.");
	if(isnull(params))
		return SendUsageMessage(playerid, "/ofkov [�sim_Soyisim]");
	if(!IsValidRoleplayName(params))
		return SendErrorMessage(playerid, "Hatal� isim_soyisim girdin. �sim kelimesi kelimesine ayn� olmal�.");
	if(!ReturnSQLFromName(params))
		return SendErrorMessage(playerid, "Belirtti�in ki�i veritaban�nda yok.");

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), params, true))
		{
			SendErrorMessage(playerid, "Belirtti�in ki�i �u anda oyunda g�z�k�yor.");
			return 1;
		}
	}

	new query[230];
	new faction_id, rank_id;

	mysql_format(m_Handle, query, sizeof query, "SELECT Faction, FactionRank FROM players WHERE id = %i", ReturnSQLFromName(params));
	new Cache:cache = mysql_query(m_Handle, query);

	cache_get_value_name_int(0, "Faction", faction_id);
	cache_get_value_name_int(0, "FactionRank", rank_id);

	if(faction_id != PlayerData[playerid][pFaction])
	{
		SendErrorMessage(playerid, "Belirtti�in ki�i senin birli�inde de�il.");
		cache_delete(cache);
		return 1;
	}

	if(rank_id < PlayerData[playerid][pFactionRank])
	{
		SendErrorMessage(playerid, "Belirtti�in ki�i senden daha r�tbeli.");
		cache_delete(cache);
		return 1;
	}

	format(query, sizeof query, "%s adl� ki�iyi birlikten atmak istiyor musun?", params);
	ConfirmDialog(playerid, "Onay", query, "OnOfflineUninvite", ReturnSQLFromName(params));
	cache_delete(cache);
	return true;
}

Server:OnOfflineUninvite(playerid, response, dbid)
{
	if(response)
	{
		new removeQuery[200];

		mysql_format(m_Handle, removeQuery, sizeof removeQuery, "UPDATE players SET Faction = 0, FactionRank = 0 WHERE id = %i", dbid);
		mysql_tquery(m_Handle, removeQuery, "OnOfflineRemove", "ii", playerid, dbid);
	}
	return 1;
}

Server:OnOfflineRemove(playerid, dbid)
{
	Message(playerid, COLOR_ADM, "-> %s adl� ki�iyi ba�ar�yla birlikten ��kard�n.", ReturnSQLName(dbid));
	return 1;
}*/

CMD:fkov(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlikten atma komutunu kullanmak i�in r�tben yetersiz.");

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/fkov [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(PlayerData[id][pFaction] == -1) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hi� bir birlikte bulunmuyor.");
	if(PlayerData[playerid][pFaction] != PlayerData[id][pFaction]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i bu birlikte bulunmuyor.");
	if(PlayerData[playerid][pFactionRank] > PlayerData[id][pFactionRank]) return SendErrorMessage(playerid, "Senden y�ksek r�tbeli birini kovamazs�n.");

	SendClientMessageEx(id, COLOR_YELLOW, "SERVER: %s seni %s birli�inden kovdu.", ReturnName(playerid, 0), FactionData[PlayerData[playerid][pFaction]][FactionName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s isimli ki�iyi birlikten kovdun.", ReturnName(id, 0));

	if(FactionData[PlayerData[id][pFaction]][FactionCopPerms])
	{
		SetPlayerArmour(id, 0);
		SetPlayerColor(id, COLOR_WHITE);
		PlayerData[id][pLAWduty] = false;
		PlayerData[id][pSWATduty] = false;
		TakePlayerGuns(playerid);
	}

	if(GetPlayerSkin(playerid) != PlayerData[playerid][pSkin]) 
		SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);	

	PlayerData[id][pFactionRank] = 0;
	PlayerData[id][pFaction] = -1;
	return 1;
}

CMD:frutbe(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik r�tbe komutunu kullanmak i�in r�tben yetersiz.");

	new playerb,
		newrank,
		faction = PlayerData[playerid][pFaction];

	if(sscanf(params, "ud", playerb, newrank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
		{
			if(!strcmp(FactionRanks[faction][i], "Yok"))
				continue;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> R�tbe %i: %s", i, FactionRanks[faction][i]);
		}

		SendUsageMessage(playerid, "/frutbe [oyuncu ID/isim] [r�tbe ID]");
		return 1;
	}

	if(newrank < 1 || newrank > 20) return SendErrorMessage(playerid, "Hatal� r�tbe ID girdin.");
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
	if(PlayerData[playerb][pFaction] != faction) return SendErrorMessage(playerid, "Belirtti�iniz ki�i bu birlikte bulunmuyor.");
	if(PlayerData[playerb][pFactionRank] < PlayerData[playerid][pFactionRank]) return SendErrorMessage(playerid, "Belirtti�in ki�iyi senden y�ksek r�tbeli yapamazs�n.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "%s isimli ki�inin r�tbesini %s(eskisi: %s) olarak g�ncelledin!", ReturnName(playerb, 1), FactionRanks[faction][newrank], FactionRanks[faction][PlayerData[playerb][pFactionRank]]);
	SendClientMessageEx(playerb, COLOR_YELLOW, "Birlik r�tbeniz %s taraf�ndan %s(eskisi: %s) olarak g�ncellendi!", ReturnName(playerid, 1), FactionRanks[faction][newrank], FactionRanks[faction][PlayerData[playerb][pFactionRank]]);
	PlayerData[playerb][pFactionRank] = newrank;
	return 1;
}