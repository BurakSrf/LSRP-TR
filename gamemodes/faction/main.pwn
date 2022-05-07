CMD:birlikler(playerid, params[])
{
	Faction_List(playerid);
	return 1;
}

Faction_List(playerid, page = 0)
{
	SetPVarInt(playerid, "Faction_idx", page);

    new query[82];
	mysql_format(m_Handle, query, sizeof(query), "SELECT id, Name FROM factions LIMIT %d, 25", page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_FactionList", "ii", playerid, page);
	return 1;
}

Server:SQL_FactionList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hi� birlik eklenmemi�.");
    }

	new 
		id, faction_name[128], primary_str[1024];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "id", id);
        cache_get_value_name(i, "Name", faction_name, 128);

		format(primary_str, sizeof(primary_str), "%s{ADC3E7}%i. %s\n", primary_str, id, faction_name); //  [%i / %i] CountOnlineMembers(id), CountFactionMembers(id)
	}

	if(page != 0) strcat(primary_str, "{FFFF00}�nceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, FACTION_LIST, DIALOG_STYLE_LIST, "Birlikler", primary_str, ">>>", "");
	return 1;
}

Dialog:FACTION_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "Faction_idx");
		if(!strcmp(inputtext, "�nceki Sayfa <<")) return Faction_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Faction_List(playerid, page+1);
		return 1;
	}
    return 1;
}

CMD:faktif(playerid, params[])
{
	new Factionid;
	if(sscanf(params, "I(-1)", Factionid)) return SendUsageMessage(playerid, "/faktif [birlik ID]");

	if(Factionid == -1)
	{
		if(PlayerData[playerid][pFaction] == -1) return SendServerMessage(playerid, "Herhangi bir birlikte de�ilsin.");

		SendClientMessageEx(playerid, COLOR_GREY, "SERVER: %s birli�inin aktif listesi:", FactionData[PlayerData[playerid][pFaction]][FactionName]);

		foreach(new i : Player)
		{
			if(PlayerData[i][pFaction] == PlayerData[playerid][pFaction])
			{
				if(PlayerData[i][pLAWduty]) SendClientMessageEx(playerid, COLOR_GREY, "(ID: %d) %s%s %s", i, PlayerData[i][pAdminDuty] ? ("{FF9900}") : ("{8D8DFF}"), Player_GetFactionRank(i), ReturnName(i, 1));
				else SendClientMessageEx(playerid, COLOR_GREY, "(ID: %d) %s%s %s", i, PlayerData[i][pAdminDuty] ? ("{FF9900}") : (""), Player_GetFactionRank(i), ReturnName(i, 1));
			}
		}
	}
	else
	{
		if(!Iter_Contains(Factions, Factionid)) return SendErrorMessage(playerid, "Hatal� birlik ID girdin.");
		SendClientMessageEx(playerid, COLOR_ADM, "[!] %s {FFFFFF}birli�inde {FF6347}%d{FFFFFF} kay�tl� ki�iden {FF6347}%d{FFFFFF} ki�i aktif g�r�n�yor.", FactionData[Factionid][FactionName], CountFactionMembers(Factionid), CountOnlineMembers(Factionid));
	}
	return 1;
}

CMD:fspawn(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendErrorMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "Birlik spawn noktas�n� ayarlamak i�in r�tben yetersiz.");

	new factionid = PlayerData[playerid][pFaction];
	SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Birli�inin spawn noktas�n� �uanki konumun olarak ayarlad�n.");
	GetPlayerPos(playerid, FactionData[factionid][FactionSpawn][0], FactionData[factionid][FactionSpawn][1], FactionData[factionid][FactionSpawn][2]);
	GetPlayerFacingAngle(playerid, FactionData[factionid][FactionSpawn][3]);
	FactionData[factionid][FactionSpawnInterior] = GetPlayerInterior(playerid);
	FactionData[factionid][FactionSpawnVW] = GetPlayerVirtualWorld(playerid);
	Faction_Save(factionid);
	return 1;
}

CMD:fpspawn(playerid, params[])
{
 	if(PlayerData[playerid][pFaction] == -1) return SendServerMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendClientMessage(playerid, COLOR_ADM, "HATA: R�tben d�zenleme i�in yetersiz.");

	new id, Factionid = PlayerData[playerid][pFaction];
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /fpspawn [1/2/3]");
	switch(id)
	{
		case 1:
		{
			SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Birli�inin birinci spawn noktas�n� ayarlad�n.");
			GetPlayerPos(playerid, FactionData[Factionid][FactionSpawnEx1][0], FactionData[Factionid][FactionSpawnEx1][1], FactionData[Factionid][FactionSpawnEx1][2]);
			FactionData[Factionid][FactionSpawnEx1Interior] = GetPlayerInterior(playerid);
			FactionData[Factionid][FactionSpawnEx1VW] = GetPlayerVirtualWorld(playerid);
			Faction_Save(Factionid);
		}
		case 2:
		{
			SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Birli�inin ikinci spawn noktas�n� ayarlad�n.");
			GetPlayerPos(playerid, FactionData[Factionid][FactionSpawnEx2][0], FactionData[Factionid][FactionSpawnEx2][1], FactionData[Factionid][FactionSpawnEx2][2]);
			FactionData[Factionid][FactionSpawnEx2Interior] = GetPlayerInterior(playerid);
			FactionData[Factionid][FactionSpawnEx2VW] = GetPlayerVirtualWorld(playerid);
			Faction_Save(Factionid);
		}
		case 3:
		{
			SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Birli�inin ���nc� spawn noktas�n� ayarlad�n.");
			GetPlayerPos(playerid, FactionData[Factionid][FactionSpawnEx3][0], FactionData[Factionid][FactionSpawnEx3][1], FactionData[Factionid][FactionSpawnEx3][2]);
			FactionData[Factionid][FactionSpawnEx3Interior] = GetPlayerInterior(playerid);
			FactionData[Factionid][FactionSpawnEx3VW] = GetPlayerVirtualWorld(playerid);
			Faction_Save(Factionid);
		}
		default: SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /setpspawn [1/2/3]");
	}
	return 1;
}

CMD:fpark(playerid, params[])
{
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionTowrank] && !PlayerData[playerid][pAdminDuty])
		return SendServerMessage(playerid, "R�tben bu komut i�in yetersiz.");

	new
		bool: vehicle_found = false,
		Factionid;

	if(PlayerData[playerid][pAdminDuty])
	{
		if(sscanf(params, "i", Factionid)) return SendUsageMessage(playerid, "/fpark [birlik ID]");
		if(!Iter_Contains(Factions, Factionid)) return SendErrorMessage(playerid, "Hatal� birlik ID girdin.");

		for(new f = 1, j = GetVehiclePoolSize(); f <= j; f++)
		{
			if(CarData[f][carFaction] == Factionid)
			{
				if(!IsVehicleOccupied(f))
				{
					vehicle_found = true;
					SetVehicleToRespawn(f);
				}
			}
		}

		if(vehicle_found)
		{
			SendFactionMessageEx(playerid, COLOR_ADM, sprintf("<< Y�netici %s b�t�n birlik ara�lar� eski pozisyonlar�na getirdi. >>", ReturnName(playerid, 1)));
		}
		else SendServerMessage(playerid, "Respawn edilebilecek birlik arac� bulunamad�.");
		return 1;
	}

	for(new i = 1, j = GetVehiclePoolSize(); i <= j; i++)
	{
		if(CarData[i][carFaction] == PlayerData[playerid][pFaction])
		{
			if(!IsVehicleOccupied(i))
			{
				vehicle_found = true;
				SetVehicleToRespawn(i);
			}
		}
	}

	if(vehicle_found)
	{
		SendFactionMessageEx(playerid, COLOR_ADM, sprintf("<< %s b�t�n birlik ara�lar� eski pozisyonlar�na getirdi. >>", ReturnName(playerid, 1)));
	}
	else SendServerMessage(playerid, "Respawn edilebilecek birlik arac� bulunamad�.");
	return 1;
}

CMD:fuyeler(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendServerMessage(playerid, "Herhangi bir birlikte de�ilsin.");
	Faction_Member_List(playerid);
	return 1;
}

Faction_Member_List(playerid, page = 0)
{
	SetPVarInt(playerid, "Faction_member_idx", page);

    new query[144];
	mysql_format(m_Handle, query, sizeof(query), "SELECT Name, LastTime, FactionRank FROM players WHERE Faction = %i ORDER BY FactionRank ASC LIMIT %i, 25", PlayerData[playerid][pFaction], page*MAX_CLOTHING_SHOW);
	mysql_tquery(m_Handle, query, "SQL_FactionMemberList", "ii", playerid, page);
	return 1;
}

Server:SQL_FactionMemberList(playerid, page)
{
	if(!IsPlayerConnected(playerid)) {
        return 0;
    }

    new rows = cache_num_rows();   
    if(!rows) {
        return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hi� birlik �yesi bulunamad�.");
    }

	new 
		bool: is_online = false, last_conn, Faction_rank, Faction_name[128], primary_str[1024];

	for(new i; i < rows; ++i)
	{
		cache_get_value_name_int(i, "LastTime", last_conn);
		cache_get_value_name_int(i, "FactionRank", Faction_rank);
		cache_get_value_name(i, "Name", Faction_name, sizeof(Faction_name));
		foreach(new g : Player) if(strcmp(ReturnName(g), Faction_name, true)) is_online = false;
		format(primary_str, sizeof(primary_str), "%s%s%s\t%s\t%s\n", primary_str, (is_online != true) ? ("{F81414}") : ("{33AA33}"), Faction_name, FactionRanks[PlayerData[playerid][pFaction]][Faction_rank], GetFullTime(last_conn));
	}

	if(page != 0) strcat(primary_str, "{FFFF00}�nceki Sayfa <<\n");
	if(rows >= MAX_CLOTHING_SHOW) strcat(primary_str, "{FFFF00}Sonraki Sayfa >>");

	Dialog_Show(playerid, Faction_MEMBER_LIST, DIALOG_STYLE_LIST, "Birlik �yeleri", primary_str, ">>>", "");
	return 1;
}

Dialog:Faction_MEMBER_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new page = GetPVarInt(playerid, "Faction_member_idx");
		if(!strcmp(inputtext, "�nceki Sayfa <<")) return Faction_Member_List(playerid, page-1);
		if(!strcmp(inputtext, "Sonraki Sayfa >>")) return Faction_Member_List(playerid, page+1);
		return 1;
	}
    return 1;
}

CMD:fkasa(playerid, params[])
{
	if(!IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(PlayerData[playerid][pFactionRank] > FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
		return SendErrorMessage(playerid, "R�tben bu komut i�in yetersiz.");

	new specifier[60], method[30];

	if(sscanf(params, "s[60]S()[30]", specifier, method))
		return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /fkasa [parakoy/paracek/bakiye]");

	if(!strcmp(specifier, "parakoy"))
	{
		new
			quantity;

		if(sscanf(method, "i", quantity)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /fkasa parakoy [miktar]");
		if(quantity < 1 || quantity > PlayerData[playerid][pMoney]) return SendClientMessage(playerid, COLOR_ADM, "HATA: Bu kadar paran yok.");

		GiveMoney(playerid, -quantity);
		FactionData[PlayerData[playerid][pFaction]][FactionBank]+= quantity;

		SendClientMessageEx(playerid, COLOR_ACTION, "Birli�inin kasas�na $%s koydun! (%s)", MoneyFormat(quantity), Faction_GetName(PlayerData[playerid][pFaction]), GetFullTime(Time()));
	}
	else if(!strcmp(specifier, "paracek"))
	{
		new
			quantity;

		if(PlayerData[playerid][pFactionRank] != 1) return SendClientMessage(playerid, COLOR_ADM, "HATA: Sadece 1. r�tbe para �ekebilir.");

		if(sscanf(method, "i", quantity)) return SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /fkasa paracek [de�er]");
		if(quantity < 1 || quantity > FactionData[PlayerData[playerid][pFaction]][FactionBank]) 
			return SendClientMessage(playerid, COLOR_ADM, "HATA: Kasada bu kadar para yok.");

		GiveMoney(playerid, quantity);
		FactionData[PlayerData[playerid][pFaction]][FactionBank]-= quantity;

		SendClientMessageEx(playerid, COLOR_ACTION, "Birli�inin kasas�ndan $%s �ektin. Birlik: %s - (%s)", MoneyFormat(quantity), Faction_GetName(PlayerData[playerid][pFaction]), GetFullTime(Time()));
	}
	else if(!strcmp(specifier, "bakiye"))
		return SendClientMessageEx(playerid, COLOR_ACTION, "%s birli�inin kasas�: $%s (%s)", Faction_GetName(PlayerData[playerid][pFaction]), MoneyFormat(FactionData[PlayerData[playerid][pFaction]][FactionBank]), GetFullTime(Time()));

	else return SendClientMessage(playerid, COLOR_ADM, "SERVER: Hatal� parametre girdin.");
	return 1;
}

//Faction configure
CMD:birlikpanel(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendClientMessage(playerid, COLOR_ADM, "HATA: Birlikte de�ilsin.");
	if(PlayerData[playerid][pFactionRank] < FactionData[PlayerData[playerid][pFaction]][FactionEditrank]) return SendClientMessage(playerid, COLOR_ADM, "ER���M REDDED�LD�:{FFFFFF} R�tben bu komut i�in yetersiz.");

	ShowYourFactionMenu(playerid);
	return 1;
}

CMD:abirlikpanel(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendClientMessage(playerid, COLOR_ADM, "HATA: Birlikte de�ilsin.");
 	if(PlayerData[playerid][pAdmin] < 5) return 0;

	ShowYourFactionMenu(playerid);
	return 1;
}

stock ShowYourFactionMenu(playerid)
{
	new primary_str[600];
	new sub_str[200];

	format(sub_str, sizeof(sub_str), "Birlik Ad�: [{AFAFAF}%s{FFFFFF}]\n", Faction_GetName(PlayerData[playerid][pFaction]));
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "Birlik K�saltmas�: [{AFAFAF}%s{FFFFFF}]\n", FactionData[PlayerData[playerid][pFaction]][FactionAbbrev]);
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "D�zenleme R�tbesi: [{AFAFAF}%s{FFFFFF}]\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionEditrank]]);
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "TOW R�tbesi: [{AFAFAF}%s{FFFFFF}]\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionTowrank]]);
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "/f R�tbesi: [{AFAFAF}%s{FFFFFF}]\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionChatrank]]);
	strcat(primary_str, sub_str);

	format(sub_str, sizeof(sub_str), "Giri� R�tbesi: [{AFAFAF}%s{FFFFFF}]\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionMaxRanks]]);
	strcat(primary_str, sub_str);

	strcat(primary_str, "{ADC3E7}Birlik R�tbelerini D�zenle\n");
	strcat(primary_str, "{ADC3E7}Birlik Maa�lar�n� D�zenle");

	ShowPlayerDialog(playerid, DIALOG_FACTIONMENU, DIALOG_STYLE_LIST, "Birlik Y�netimi", primary_str, "Se�", "�ptal");
	return 1;
}

ShowYourFactionMenuAlt(playerid, listitem)
{
	new
		primary_str[1100], sub_str[200];

	switch(listitem)
	{
		case 0: // Name
		{
			if(PlayerData[playerid][pFactionRank] != 1)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Birlik ismini sadece en �st r�tbe de�i�tirebilir.");
				return ShowYourFactionMenu(playerid);
			}

			format(sub_str, sizeof sub_str, "{AFAFAF}Birlik ad�n� d�zenliyorsun: %s.\n\n", Faction_GetName(PlayerData[playerid][pFaction]));
			strcat(primary_str, sub_str);

			strcat(primary_str, "Birlik ad�n�z B�RL�K Y�NET�M� EK�B�NE ba�vurulup de�i�tirilmelidir.\n");
			strcat(primary_str, "�zinleri k�t�ye kullanan birlik liderlerinin birlikleri kald�r�l�r.\n\n");

			strcat(primary_str, "L�tfen 3 ile 60 karakter aras�nda bir birlik ad� girin:\n");

			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_NAME, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"�sim", primary_str, "De�i�tir", "<<");
		}
		case 1: // Abbreviation
		{
			format(sub_str, sizeof sub_str, "{AFAFAF}Birlik k�saltmas�n� d�zenliyorsun: %s.\n\n", FactionData[PlayerData[playerid][pFaction]][FactionAbbrev]);
			strcat(primary_str, sub_str);

			strcat(primary_str, "Birlik k�saltmas� genelde /departman komutunu kullanabilen birlikler i�indir.\n");
			strcat(primary_str, "E�er bu komutu kullanam�yorsan�z k�saltmay� eklemeyi/d�zenlemeyi pas ge�ebilirsiniz.\n\n");

			strcat(primary_str, "L�tfen birli�inizin k�saltmas�n� 7 karakterin alt�nda tutun. �rnek: \"LSPD\" yada \"LSFD\". ");

			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_ABBREV, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"K�saltma", primary_str, "De�i�tir", "<<");
		}
		case 2: //Alter Rank
		{
			if(PlayerData[playerid][pFactionRank] != 1)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Birlik r�tbe de�i�tirme yetkisini sadece en �st r�tbe de�i�tirebilir.");
				return ShowYourFactionMenu(playerid);
			}

			format(sub_str, sizeof sub_str, "{AFAFAF}Birli�i d�zenleme r�tbesini de�i�tiriyorsun: %s [%i].\n\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionEditrank]], FactionData[PlayerData[playerid][pFaction]][FactionEditrank]);
			strcat(primary_str, sub_str);

			strcat(primary_str, "D�zenleme r�tbesi a�a��daki komutlar� kullanabilir:\n\n");
			strcat(primary_str, "\t\t/frutbeayarla, /fdavet, /birlikpanel, /fkapat ve /gov.\n\n");

			strcat(primary_str, "Ak�ll�ca atay�n. L�tfen bu izinlere sahip olmas�n� istedi�iniz r�tbe numaras�n� girin.");

			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_ALTER, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"D�zenleme R�tbesi", primary_str, "D�zenle", "<<");
		}
		case 3: //Tow Rank
		{
			format(sub_str, sizeof sub_str, "{AFAFAF}Birli�in ara�lar�n� respawnlama r�tbesini de�i�tiriyorsun: %s [%i].\n\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionTowrank]], FactionData[PlayerData[playerid][pFaction]][FactionTowrank]);
			strcat(primary_str, sub_str);

			strcat(primary_str, "Bu r�tbeye sahip olacak ki�iler /fpark komutunu kulanabileceklerdir.\nL�tfen bu izinlere sahip olmas�n� istedi�iniz r�tbe numaras�n� girin.");
			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_TOW, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"TOW R�tbesi", primary_str, "D�zenle", "<<");
		}
		case 4: //Chat Rank
		{
			format(sub_str, sizeof sub_str, "{AFAFAF}Birli�in chat k�sm�n� kullanabilecek r�tbeyi d�zenliyorsun: %s [%i].\n\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionChatrank]], FactionData[PlayerData[playerid][pFaction]][FactionChatrank]);
			strcat(primary_str, sub_str);

			strcat(primary_str, "Bu r�tbeye sahip olacak ki�iler /f komutunu kulanabileceklerdir.\nL�tfen bu izinlere sahip olmas�n� istedi�iniz r�tbe numaras�n� girin.");
			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_CHAT, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"Chat R�tbesi", primary_str, "D�zenle", "<<");
		}
		case 5: //Join Rank
		{
			format(sub_str, sizeof sub_str, "{AFAFAF}Birli�in davet etme r�tbesini d�zenliyorsun: %s [%i].\n\n", FactionRanks[PlayerData[playerid][pFaction]][FactionData[PlayerData[playerid][pFaction]][FactionMaxRanks]], FactionData[PlayerData[playerid][pFaction]][FactionMaxRanks]);
			strcat(primary_str, sub_str);

			strcat(primary_str, "Bu r�tbeye sahip olacak ki�iler /fdavet komutunu kulanabileceklerdir.\nL�tfen bu izinlere sahip olmas�n� istedi�iniz r�tbe numaras�n� girin.");
			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_JOIN, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"Davet R�tbesi", primary_str, "D�zenle", "<<");
		}
		case 6: //Edit ranks
		{
			for(new i = 1; i < MAX_FACTION_RANKS; i++)
			{
				format(sub_str, sizeof sub_str, "%s [%i]\n", FactionRanks[PlayerData[playerid][pFaction]][i], i);
				strcat(primary_str, sub_str);
			}

			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_EDIT, DIALOG_STYLE_LIST, BIRLIK_BASLIK"R�tbe D�zenle", primary_str, "Se�", "<<");
		}
		case 7: // Edit ranks' salary
		{
			for(new i = 1; i < MAX_FACTION_RANKS; i++)
			{
				format(sub_str, sizeof sub_str, "%s [%i] {AFAFAF}$%s\n", FactionRanks[PlayerData[playerid][pFaction]][i], i, MoneyFormat(FactionRanksSalary[PlayerData[playerid][pFaction]][i]));
				strcat(primary_str, sub_str);
			}

			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_EDITSAL, DIALOG_STYLE_LIST, BIRLIK_BASLIK"Maa� D�zenle", primary_str, "Se�", "<<");
		}
		case 8: // Edit ranks alt
		{
			new rank_id;
			rank_id = GetPVarInt(playerid, "SelectedRank");

			if(rank_id == 1 && PlayerData[playerid][pFactionRank] != 1)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Birlik r�tbe d�zenleme yetkisini sadece en �st r�tbe de�i�tirebilir.");
				for(new i = 1; i < MAX_FACTION_RANKS; i++)
				{
					format(sub_str, sizeof sub_str, "%s [%i]\n", FactionRanks[PlayerData[playerid][pFaction]][i], i);
					strcat(primary_str, sub_str);
				}

				ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_EDIT, DIALOG_STYLE_LIST, BIRLIK_BASLIK"R�tbe D�zenle", primary_str, "D�zenle", "<<");
			    return 1;
			}

			format(sub_str, sizeof sub_str, "D�zenlenen R�tbe: %s [%i].\n", FactionRanks[PlayerData[playerid][pFaction]][rank_id], rank_id);
			strcat(primary_str, sub_str);

			strcat(primary_str, "Bu r�tbe i�in yeni ad�n� girin.");
			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_EDITALT, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"R�tbe D�zenle", primary_str, "D�zenle", "<<");
		}
		case 9: // Edit ranks' salary alt
		{
			new rank_id;
			rank_id = GetPVarInt(playerid, "SelectedRank");

			if(rank_id == 1 && PlayerData[playerid][pFactionRank] != 1)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Birlik maa� d�zenleme yetkisini sadece en �st r�tbe de�i�tirebilir.");
				for(new i = 1; i < MAX_FACTION_RANKS; i++)
				{
					format(sub_str, sizeof sub_str, "%s [%i] {AFAFAF}$%s\n", FactionRanks[PlayerData[playerid][pFaction]][i], i, MoneyFormat(FactionRanksSalary[PlayerData[playerid][pFaction]][i]));
					strcat(primary_str, sub_str);
				}

				ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_EDITSAL, DIALOG_STYLE_LIST, BIRLIK_BASLIK"Maa� D�zenle", primary_str, "Se�", "<<");
			    return 1;
			}

			format(sub_str, sizeof sub_str, "D�zenlenen R�tbe: %s [%i] ($%s).\n", FactionRanks[PlayerData[playerid][pFaction]][rank_id], rank_id, MoneyFormat(FactionRanksSalary[PlayerData[playerid][pFaction]][rank_id]));
			strcat(primary_str, sub_str);

			strcat(primary_str, "Bu r�tbe i�in yeni maa� miktar�n� girin.");
			ShowPlayerDialog(playerid, DIALOG_FACTIONMENU_EDITALTSAL, DIALOG_STYLE_INPUT, BIRLIK_BASLIK"Maa� D�zenle", primary_str, "D�zenle", "<<");
		}
	}
	return 1;
}