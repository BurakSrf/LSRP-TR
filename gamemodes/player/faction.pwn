CMD:fac(playerid, params[]) return cmd_f(playerid, params);
CMD:f(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(!PlayerData[playerid][pFactionStatus]) return SendErrorMessage(playerid, "Birlik kanalýný kapatmýþsýn, /tog birlik yazarak açabilirsin.");

	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionChatrank])
	    return SendErrorMessage(playerid, "Birlik kanalýndan konuþabilmek için rütben yetersiz.");

	if(isnull(params)) return SendUsageMessage(playerid, "/f [mesaj]");

	if(FactionData[PlayerData[playerid][pFaction]][FactionChatStatus])
    {
        if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank] && !PlayerData[playerid][pAdminDuty])
        {
            SendErrorMessage(playerid, "Birlik kanalý birlik yöneticileri tarafýndan kapatýlmýþ.");
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
        return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ:{FFFFFF} Rozet numaralarýný ayarlamak için rütben yetersiz.");

    new id, badge;
    if(sscanf(params, "ui", id, badge)) return SendUsageMessage(playerid, "/frozet [oyuncu ID/isim] [rozet numarasý]");
	if(!IsPlayerConnected(id)) return SendServerMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendServerMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s isimli oyuncunun rozet numarasýný #%d olarak güncelledin.", ReturnName(id), badge);
    SendClientMessageEx(id, COLOR_YELLOW, "SERVER: Rozet numaran #%d olarak güncellendi.", badge);
    SaveSQLInt(PlayerData[id][pSQLID], "players", "Badge", badge);
    PlayerData[id][pBadge] = badge;
    return 1;
}

CMD:frutbeayarla(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik rütbelerini ayarlamak için rütben yetersiz.");

	new rank[60], rankn, faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "ds[60]", rankn, rank))
	{
		SendUsageMessage(playerid, "/frutbeayarla [rütbe ID] [rütbe adý]");
		return 1;
	}

	if(rankn > 20 || rankn < 1)
		return SendErrorMessage(playerid, "Hatalý rütbe ID girdin.");

	if(strlen(rank) > 60)
		return SendErrorMessage(playerid, "Rütbe adý 60 karakterden fazla olamaz.");

	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}#%i numaralý rütbenin adýný %s olarak deðiþtirdin!", rankn, rank);
	FactionRanks[faction][rankn] = rank;
	Faction_SaveRanks(faction);
	return 1;
}

CMD:fkapat(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik kanalýný ayarlamak için rütben yetersiz.");

	new faction = PlayerData[playerid][pFaction];
	if(!FactionData[faction][FactionChatStatus])
	{
		SendFactionMessageEx(playerid, COLOR_ADM, sprintf("[!] {FFFFFF}%s birlik kanalýný kullanýma kapattý.", ReturnName(playerid, 1)));
		FactionData[faction][FactionChatStatus] = true;
	}
	else
	{
		SendFactionMessageEx(playerid, COLOR_ADM, sprintf("[!] {FFFFFF}%s birlik kanalýný kullanýma açtý.", ReturnName(playerid, 1)));
		FactionData[faction][FactionChatStatus] = false;
	}
	return 1;
}

CMD:frenk(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik kanalý rengini ayarlamak için rütben yetersiz.");

	new color, faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "x", color)) return SendUsageMessage(playerid, "/frenk [hex code (örnek: 0x(6 haneli kod buraya)FF)]");

	SendClientMessageEx(playerid, COLOR_ADM, sprintf("[!] {FFFFFF}Birlik kanal rengi %x olarak ayarlandý.", color));
	FactionData[PlayerData[playerid][pFaction]][FactionChatColor] = color;
	SaveSQLInt(faction, "factions", "ChatColor", FactionData[faction][FactionChatColor]);
	return true;
}

CMD:fisim(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] != 1) return SendErrorMessage(playerid, "Bu komutu sadece en yüksek rütbe kullanabilir.");

	new name[128], faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "s[128]", name)) return SendUsageMessage(playerid, "/fisim [birlik adý]");
	SendClientMessageEx(playerid, COLOR_ADM, "[!] {FFFFFF}Birlik isminiz %s olarak deðiþtirildi.", name);
	format(FactionData[faction][FactionName], 128, "%s", name);
	Faction_Save(faction);
	return 1;
}

CMD:fkisaltma(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] != 1) return SendErrorMessage(playerid, "Bu komutu sadece en yüksek rütbe kullanabilir.");

	new name[128], faction = PlayerData[playerid][pFaction];
	if(sscanf(params, "s[128]", name)) return SendUsageMessage(playerid, "/fkisaltma [kýsaltma]");
	SendClientMessageEx(playerid, COLOR_ADM, "[!] {FFFFFF}Birlik kýsaltmanýz %s olarak deðiþtirildi.", name);
	format(FactionData[faction][FactionAbbrev], 128, "%s", name);
	Faction_Save(faction);
	return 1;
}

CMD:fkabul(playerid, params[])
{
	if(PlayerData[playerid][pFactionOffer] == -1) return SendErrorMessage(playerid, "Herhangi bir birliðe davet edilmemiþsin.");

	PlayerData[playerid][pFaction] = PlayerData[playerid][pFactionOffer];
	SaveSQLInt(PlayerData[playerid][pSQLID], "players", "Faction", PlayerData[playerid][pFaction]);

	PlayerData[playerid][pFactionRank] = FactionData[PlayerData[playerid][pFactionOffer]][FactionMaxRanks];
	SaveSQLInt(PlayerData[playerid][pSQLID], "players", "FactionRank", PlayerData[playerid][pFactionRank]);
	PlayerData[playerid][pSpawnPoint] = 3;

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Artýk %s birliðinin bir üyesisin!", FactionData[PlayerData[playerid][pFaction]][FactionName]);
	PlayerData[playerid][pFactionOffer] = -1;
	return 1;
}

CMD:fdavet(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");

	new playerb;
	if(sscanf(params, "u", playerb)) return SendUsageMessage(playerid, "/fdavet [oyuncu ID/isim]");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik davet komutunu kullanmak için rütben yetersiz.");
	
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi aktif deðil.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(PlayerData[playerb][pFaction] != -1) return SendErrorMessage(playerid, "Belirttiðiniz kiþi zaten herhangi bir birlikte bulunuyor.");

	SendClientMessageEx(playerb, COLOR_YELLOW, "SERVER: %s seni %s birliðine davet etti, kabul etmek için /fkabul yazabilirsin.", ReturnName(playerid, 0), FactionData[PlayerData[playerid][pFaction]][FactionName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s isimli kiþiyi %s birliðine davet ettin, kabul etmesi için /fkabul yazmalý.", ReturnName(playerb, 0), FactionData[PlayerData[playerid][pFaction]][FactionName]);
	PlayerData[playerb][pFactionOffer] = PlayerData[playerid][pFaction];
	return 1;
}

/*CMD:ofkov(playerid, params[])
{
	if(!PlayerData[playerid][pFaction])
		return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][factionEditrank])
		return SendErrorMessage(playerid, "Birlikten atma komutunu kullanmak için rütben yetersiz.");
	if(isnull(params))
		return SendUsageMessage(playerid, "/ofkov [Ýsim_Soyisim]");
	if(!IsValidRoleplayName(params))
		return SendErrorMessage(playerid, "Hatalý isim_soyisim girdin. Ýsim kelimesi kelimesine ayný olmalý.");
	if(!ReturnSQLFromName(params))
		return SendErrorMessage(playerid, "Belirttiðin kiþi veritabanýnda yok.");

	foreach(new i : Player)
	{
		if(!strcmp(ReturnName(i), params, true))
		{
			SendErrorMessage(playerid, "Belirttiðin kiþi þu anda oyunda gözüküyor.");
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
		SendErrorMessage(playerid, "Belirttiðin kiþi senin birliðinde deðil.");
		cache_delete(cache);
		return 1;
	}

	if(rank_id < PlayerData[playerid][pFactionRank])
	{
		SendErrorMessage(playerid, "Belirttiðin kiþi senden daha rütbeli.");
		cache_delete(cache);
		return 1;
	}

	format(query, sizeof query, "%s adlý kiþiyi birlikten atmak istiyor musun?", params);
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
	Message(playerid, COLOR_ADM, "-> %s adlý kiþiyi baþarýyla birlikten çýkardýn.", ReturnSQLName(dbid));
	return 1;
}*/

CMD:fkov(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlikten atma komutunu kullanmak için rütben yetersiz.");

	new id;
	if(sscanf(params, "u", id)) return SendUsageMessage(playerid, "/fkov [oyuncu ID/isim]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(PlayerData[id][pFaction] == -1) return SendErrorMessage(playerid, "Belirttiðiniz kiþi hiç bir birlikte bulunmuyor.");
	if(PlayerData[playerid][pFaction] != PlayerData[id][pFaction]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi bu birlikte bulunmuyor.");
	if(PlayerData[playerid][pFactionRank] > PlayerData[id][pFactionRank]) return SendErrorMessage(playerid, "Senden yüksek rütbeli birini kovamazsýn.");

	SendClientMessageEx(id, COLOR_YELLOW, "SERVER: %s seni %s birliðinden kovdu.", ReturnName(playerid, 0), FactionData[PlayerData[playerid][pFaction]][FactionName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %s isimli kiþiyi birlikten kovdun.", ReturnName(id, 0));

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
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte deðilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik rütbe komutunu kullanmak için rütben yetersiz.");

	new playerb,
		newrank,
		faction = PlayerData[playerid][pFaction];

	if(sscanf(params, "ud", playerb, newrank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
		{
			if(!strcmp(FactionRanks[faction][i], "Yok"))
				continue;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Rütbe %i: %s", i, FactionRanks[faction][i]);
		}

		SendUsageMessage(playerid, "/frutbe [oyuncu ID/isim] [rütbe ID]");
		return 1;
	}

	if(newrank < 1 || newrank > 20) return SendErrorMessage(playerid, "Hatalý rütbe ID girdin.");
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(PlayerData[playerb][pFaction] != faction) return SendErrorMessage(playerid, "Belirttiðiniz kiþi bu birlikte bulunmuyor.");
	if(PlayerData[playerb][pFactionRank] < PlayerData[playerid][pFactionRank]) return SendErrorMessage(playerid, "Belirttiðin kiþiyi senden yüksek rütbeli yapamazsýn.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "%s isimli kiþinin rütbesini %s(eskisi: %s) olarak güncelledin!", ReturnName(playerb, 1), FactionRanks[faction][newrank], FactionRanks[faction][PlayerData[playerb][pFactionRank]]);
	SendClientMessageEx(playerb, COLOR_YELLOW, "Birlik rütbeniz %s tarafýndan %s(eskisi: %s) olarak güncellendi!", ReturnName(playerid, 1), FactionRanks[faction][newrank], FactionRanks[faction][PlayerData[playerb][pFactionRank]]);
	PlayerData[playerb][pFactionRank] = newrank;
	return 1;
}