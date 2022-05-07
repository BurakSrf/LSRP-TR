CMD:ev(playerid, params[])
{
	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/ev [parametre]");
		SendClientMessage(playerid, COLOR_ADM, "-> satinal, sat, bilgi, zula, paracek, parayatir, saat");
		SendClientMessage(playerid, COLOR_ADM, "-> item, gelistir, kiracilar, kira, kiradurum, kov");
		return 1;
	}

	if(!strcmp(type, "satinal", true))
	{
		new h = -1;
		if((h = IsPlayerNearProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "Herhangi bir evin kapýsýnda deðilsin.");
		if(Property_Count(playerid) == 3) return SendErrorMessage(playerid, "Maksimum sahip olabileceðin ev sayýsýna ulaþmýþsýn.");
		if(PropertyData[h][PropertyOwnerID]) return SendErrorMessage(playerid, "Sahibi olan bir evi satýn alamazsýn.");

		if(PlayerData[playerid][pMoney] < PropertyData[h][PropertyMarketPrice]) 
			return SendErrorMessage(playerid, "Bu evi satýn almak için yeterli paran yok. (%s)", MoneyFormat(PropertyData[h][PropertyMarketPrice]));
		
		if(PlayerData[playerid][pLevel] < PropertyData[h][PropertyLevel]) 
			return SendErrorMessage(playerid, "Bu evi satýn almak için seviyen yetersiz.");

		PropertyData[h][PropertyOwnerID] = PlayerData[playerid][pSQLID];
		SaveSQLInt(PropertyData[h][PropertyID], "properties", "OwnerSQL", PropertyData[h][PropertyOwnerID]);
		GameTextForPlayer(playerid, "Evine Hosgeldin!~n~Istedigin zaman bu checkpointte~n~/giris yazarak girebilirsin", 3000, 5);
		SendClientMessage(playerid, COLOR_DARKGREEN, "Tebrikler, artýk bu evin sahibisin!");
		GiveMoney(playerid, -PropertyData[h][PropertyMarketPrice]);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		Property_Refresh(h);

		//LogPlayerAction(playerid, sprintf("%i(DBID: %i) numaralý evi $%i miktara satýn aldý.", h, PropertyData[h][PropertyID], PropertyData[h][PropertyMarketPrice]));
		return 1;
	}	
	else if(!strcmp(type, "sat", true))
	{
		new h = -1;
		if((h = IsPlayerNearProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "Herhangi bir evin kapýsýnda deðilsin.");
		if(!Property_Count(playerid)) return SendErrorMessage(playerid, "Hiç evin yok.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");

		new onayla[5];
		if(sscanf(string, "s[5]", onayla)) return SendUsageMessage(playerid, "/ev sat {FFFF00}onay");
		
		if(!strcmp(onayla, "onay", true))
		{
			PropertyData[h][PropertyOwnerID] = 0;
			SaveSQLInt(PropertyData[h][PropertyID], "properties", "OwnerSQL", 0);
			PlayerData[playerid][pSpawnPoint] = SPAWN_POINT_AIRPORT;

			SendClientMessageEx(playerid, COLOR_ADM, "SERVER: {FFFFFF}Evini $%s olarak yarý fiyatýna sattýn.", MoneyFormat(PropertyData[h][PropertyMarketPrice] / 2));
			GiveMoney(playerid, PropertyData[h][PropertyMarketPrice] / 2);
			GameTextForPlayer(playerid, "EVINI SATTIN!", 3000, 5);
		} 
		else SendUsageMessage(playerid, "/ev sat {FFFF00}onay");
		return 1;
	}
	else if(!strcmp(type, "bilgi", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");
		/*	new garage_id;
		foreach(new i : Garages) if(GarageData[i][GaragePropertyID] == h)
		{
			garage_id = i;
		}

		SendClientMessageEx(playerid, COLOR_DARKGREEN, "|__________________Ev [%i]__________________|", PropertyData[h][HouseID]);
		SendClientMessageEx(playerid, COLOR_GREY, "Sahip:[%s] Level:[%i] Deðer:[$%s] Kasa:[%s] Durum:[%s]", ReturnName(playerid, 1), PropertyData[h][propertyLevel], MoneyFormat(PropertyData[h][propertyMarketPrice]), PropertyData[h][propertyLocked] ? ("Kilitli") : ("Kilitli Deðil"));
		SendClientMessageEx(playerid, COLOR_GREY, "Garaj ID:[%s] Level:[%i] Deðer:[$%s] Durum:[%s]", (garage_id != 0) ? (MoneyFormat(garage_id)) : ("Yok"), PropertyData[h][propertyLevel], MoneyFormat(PropertyData[h][propertyMarketPrice]), GarageData[garage_id][GarageLocked] ? ("Kilitli") : ("Kilitli Deðil"));
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "|__________________Ev [%i]__________________|", PropertyData[h][HouseID]);
		*/
		return 1;
	}
	else if(!strcmp(type, "zula", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");

		GetPlayerPos(playerid, PropertyData[h][PropertyCheck][0], PropertyData[h][PropertyCheck][1], PropertyData[playerid][PropertyCheck][2]);
		PropertyData[h][PropertyCheckInterior] = GetPlayerInterior(playerid);
		PropertyData[h][PropertyCheckWorld] = GetPlayerVirtualWorld(playerid);

		SendClientMessage(playerid, COLOR_WHITE, "SERVER: Evin zula noktasýný ayarladýn.");
		SendClientMessage(playerid, COLOR_WHITE, "SERVER: /silahkoy /ukoy /kontrol");
		Property_Save(h);
		return 1;
	}
	else if(!strcmp(type, "parayatir", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
	
		new data[e_furniture];
		for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i++)
		{
		    if(!IsValidDynamicObject(i)) continue;
		    if(!IsHouseSafe(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID))) continue;
		    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

		    Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
	    	if(IsPlayerInRangeOfPoint(playerid, 2.5, data[furnitureX], data[furnitureY], data[furnitureZ]))
			{
				new interval;
				if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/ev parayatir [miktar]");
				if(interval < 1 || interval > PlayerData[playerid][pMoney]) return SendErrorMessage(playerid, "Geçersiz deðer belirttin.");

				GiveMoney(playerid, -interval);
				PropertyData[h][PropertyMoney] += interval;
				SaveSQLInt(PropertyData[h][PropertyID], "properties", "Money", PropertyData[h][PropertyMoney]);
				SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: Evin kasasýna $%s koydun. (Biriken: $%s)", MoneyFormat(interval), MoneyFormat(PropertyData[h][PropertyMoney]));

			    //LogPlayerAction(playerid, sprintf("%i numaralý evin zulasýna $%s miktara para koydu. [Önceki Zula: $%i - Önceki Para: $%i - Þimdiki Para: $%i]", h, MoneyFormat(interval), PropertyData[houseid][propertyMoney], PlayerData[playerid][pMoney], (PlayerData[playerid][pMoney]-interval)));
				return 1;
			}
		}

		SendClientMessage(playerid, COLOR_ADM, "Yakýnýnda kasa yok.");
		return 1;
	}
	else if(!strcmp(type, "paracek", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
	
		new data[e_furniture];
		for(new i, j = Streamer_GetUpperBound(STREAMER_TYPE_OBJECT); i < j; i++)
		{
		    if(!IsValidDynamicObject(i)) continue;
		    if(!IsHouseSafe(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID))) continue;
		    if(!Streamer_IsInArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, 0)) continue;

		    Streamer_GetArrayData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID, data);
	    	if(IsPlayerInRangeOfPoint(playerid, 2.5, data[furnitureX], data[furnitureY], data[furnitureZ]))
			{
				new interval;
				if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/ev paracek [miktar]");
				if(interval < 1 || interval > PropertyData[h][PropertyMoney]) return SendErrorMessage(playerid, "Geçersiz deðer belirttin.");

				GiveMoney(playerid, interval);
				PropertyData[h][PropertyMoney] -= interval;
				SaveSQLInt(PropertyData[h][PropertyID], "properties", "Money", PropertyData[h][PropertyMoney]);
				SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: Evin kasasýndan $%s çektin. (Kalan: $%s)", MoneyFormat(interval), MoneyFormat(PropertyData[h][PropertyMoney]));
		        //LogPlayerAction(playerid, sprintf("%i numaralý evin zulasýndan $%s miktar para aldý. [Önceki Zula: $%i - Þimdiki Para: $%i]", houseid, MoneyFormat(interval), (PropertyData[houseid][propertyMoney]-interval), (PlayerData[playerid][pMoney]+interval)));
				return 1;
			}
		}

		SendClientMessage(playerid, COLOR_ADM, "Yakýnýnda kasa yok.");
	    return 1;
	}
	else if(!strcmp(type, "saat", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
		
		new interval;
		if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/ev saat [0-23]");
		if(interval < 0 || interval > 23) return SendErrorMessage(playerid, "Saat deðeri 0 - 23 aralýðýnda olmalýdýr.");

		PropertyData[h][PropertyTime] = interval;
		SaveSQLInt(PropertyData[h][PropertyID], "properties", "Time", PropertyData[h][PropertyTime]);
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: Evin saatini %i olarak ayarladýnýz.", interval);

		foreach(new i : Player) if(IsPlayerInProperty(i) == h)
		{
			SetPlayerTime(i, PropertyData[h][PropertyTime], 0);
		}
		return 1;
	}
	else if(!strcmp(type, "isik", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
		
		if(!PropertyData[h][PropertyLights])
		{
			PropertyData[h][PropertyLights] = true;
			cmd_ame(playerid, "komütatör anahtarýna basar ve ýþýðý kapatýr.");
			foreach (new i : Player) if(PlayerData[i][pInsideHouse] == h)
			{
				PlayerTextDrawShow(i, PropertyLightsTXD[i]);
			}
		} 
		else 
		{
			PropertyData[h][PropertyLights] = false;
			cmd_ame(playerid, "komütatör anahtarýna basar ve ýþýðý açar.");
			foreach (new i : Player) if(PlayerData[i][pInsideHouse] == h)
			{
				PlayerTextDrawHide(i, PropertyLightsTXD[i]);
			}
		}
		return 1;
	}
	else if(!strcmp(type, "item", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");

		new type_two[24], string_two[128];
		if(sscanf(string, "s[24]S()[128]", type_two, string_two))
		{
			SendUsageMessage(playerid, "/ev item [item]");
			SendClientMessage(playerid, COLOR_GREY, "|_________Ev Ýtemleri_________|");
			SendClientMessage(playerid, COLOR_GREY, "| 1. xmr (/istasyon)");
			return 1;
		}

		if (!strcmp(type_two, "xmr", true))
		{
			if(!PropertyData[h][PropertyHasXMR]) return SendErrorMessage(playerid, "Evinde XM Radyo yok.");

			new islem[8];
			if(sscanf(string_two, "s[8]", islem)) return SendUsageMessage(playerid, "/ev item xmr [duzenle/sil]");

			if (!strcmp(islem, "duzenle", true))
			{
				EditingID[playerid] = h;
				EditingObject[playerid] = 19;
				EditDynamicObject(playerid, PropertyData[h][PropertyXMRObject]);
			}
			else if (!strcmp(islem, "sil", true))
			{
				SendClientMessage(playerid, COLOR_ADM, "[!]{FFFFFF} Evindeki XM radyoyu sildin.");
				DestroyDynamicObject(PropertyData[h][PropertyXMRObject]);
				PropertyData[h][PropertyHasXMR] = false;
			} 
			else SendErrorMessage(playerid, "Geçersiz parametre girdiniz.");
		}
	}
	else if(!strcmp(type, "gelistir", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");

		new type_two[24], string_two[128];
		if(sscanf(string, "s[24]S()[128]", type_two, string_two))
		{
			SendUsageMessage(playerid, "/ev gelistir [item]");
			SendClientMessage(playerid, COLOR_GREY, "|_________Ev Ýtemleri_________|");
			SendClientMessage(playerid, COLOR_GREY, "| 1. xmr (/istasyon)");
			return 1;
		}

		if (!strcmp(type_two, "xmr", true))
		{
			if(PropertyData[h][PropertyHasXMR]) return SendErrorMessage(playerid, "Evinde XM Radyo var.");
			if(PlayerData[playerid][pMoney] < 5000) return SendErrorMessage(playerid, "Bu geliþtirme için yeterli paran yok. ($5,000)");
			
			GetPlayerPos(playerid, PropertyData[h][PropertyXMR][0], PropertyData[h][PropertyXMR][1], PropertyData[h][PropertyXMR][2]);
			GetXYInFrontOfPlayer(playerid, PropertyData[h][PropertyXMR][0], PropertyData[h][PropertyXMR][1], 3.0);
			PropertyData[h][PropertyXMRObject] = CreateDynamicObject(2103, PropertyData[h][PropertyXMR][0], PropertyData[h][PropertyXMR][1], PropertyData[h][PropertyXMR][2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			EditDynamicObject(playerid, PropertyData[h][PropertyXMRObject]);
			EditingObject[playerid] = 20;
			EditingID[playerid] = h;
		}
		else SendErrorMessage(playerid, "Geçersiz parametre girdiniz.");
	}
	else if(!strcmp(type, "kiracilar", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");

		new query[63];
		mysql_format(m_Handle, query, sizeof(query), "SELECT Name FROM players WHERE Renting = %i LIMIT 20", PropertyData[h][PropertyID]);
		new Cache:cache = mysql_query(m_Handle, query);
		if(cache_num_rows())
		{
			new str[480], tenant_name[24];
			SendClientMessage(playerid, COLOR_ADM, "Evindeki Kiracýlar:");

			for(new i = 0, j = cache_num_rows(); i < j; i++)
			{
				cache_get_value_name(i, "Name", tenant_name, sizeof(tenant_name));
				
				format(str, sizeof(str), "%s%s\n", str, tenant_name);
				Dialog_Show(playerid, DIALOG_USE, DIALOG_STYLE_LIST, "Kiracýlar", str, ">>>", "");
			}
		} 
		else SendClientMessage(playerid, COLOR_ADM, "SERVER: Evinde hiç kiracý bulunmuyor.");
		cache_delete(cache);
		return 1;
 	}
 	else if(!strcmp(type, "kira", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
			
		new interval;
		if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/ev kira [miktar]");
		if(interval < 10 || interval > 500) return SendErrorMessage(playerid, "Kira fiyatý minimum $10 maksimum $500 olmalýdýr.");
			
		PropertyData[h][PropertyRentPrice] = interval;
		SaveSQLInt(PropertyData[h][PropertyID], "properties", "RentPrice", PropertyData[h][PropertyRentPrice]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Evinizin kirasý $%s olarak ayarlandý.", MoneyFormat(interval));
		return 1;
	}
 	else if(!strcmp(type, "kiradurum", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
			
		if(!PropertyData[h][PropertyRentable])
		{
			PropertyData[h][PropertyRentable] = true;
			SaveSQLInt(PropertyData[h][PropertyID], "properties", "Rentable", PropertyData[h][PropertyRentable]);
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "Evin artýk kiralanabilir. [$%i]", PropertyData[h][PropertyRentPrice]);
			SendClientMessageEx(playerid, COLOR_WHITE, "Evin kirasýný $10'dan baþlamak þartýyla deðiþtirebilirsin. (/ev kira)");
		}
		else
		{
			PropertyData[h][PropertyRentable] = false;
			SaveSQLInt(PropertyData[h][PropertyID], "properties", "Rentable", PropertyData[h][PropertyRentable]);
			SendClientMessage(playerid, COLOR_DARKGREEN, "Evin artýk kiranabilir deðil.");
		}
		return 1;
 	}
 	else if(!strcmp(type, "kov", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "ERÝÞÝM REDDEDÝLDÝ: {FFFFFF}Bu komutu kullanabilmek için kendi evinizde olmalýsýnýz.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
		
		new query[63];
		mysql_format(m_Handle, query, sizeof(query), "SELECT id FROM players WHERE Renting = %i LIMIT 20", PropertyData[h][PropertyID]);
		new Cache:cache = mysql_query(m_Handle, query);
		if(cache_num_rows())
		{
			SendClientMessageEx(playerid, COLOR_ADM, "SERVER: Evinde bulunan %i kiracýyý kovdun.", cache_num_rows());
			for(new i = 0, j = cache_num_rows(); i < j; i++)
			{
				mysql_format(m_Handle, query, sizeof(query), "UPDATE players SET Renting = -1 WHERE Renting = %i LIMIT 20", PropertyData[h][PropertyID]);
				mysql_tquery(m_Handle, query);
			}
		}
		else SendClientMessage(playerid, COLOR_ADM, "SERVER: Evinde hiç kiracý bulunmuyor.");
		cache_delete(cache);
		return 1;
 	}
	else SendErrorMessage(playerid, "Hatalý parametre girdin.");
	return 1;
}	

CMD:odakirala(playerid, params[])
{
	if(PlayerData[playerid][pRenting] == -1)
	{
		new h = -1;
		if((h = IsPlayerNearProperty(playerid)) == -1) return SendClientMessage(playerid, COLOR_ADM, "Herhangi bir evin kapýsýnda deðilsin.");
		if(!PropertyData[h][PropertyRentable]) return SendServerMessage(playerid, "Bu yer kiralanabilir deðil.");
		if(PropertyData[h][PropertyOwnerID] == PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Sahip olduðun evi kendine kiralayamazsýn.");
		if(PlayerData[playerid][pMoney] < PropertyData[h][PropertyRentPrice]) return SendErrorMessage(playerid, "Yeterli paran yok. ($%s)", MoneyFormat(PropertyData[h][PropertyRentPrice]));
		
		GiveMoney(playerid, -PropertyData[h][PropertyRentPrice]);
		PlayerData[playerid][pSpawnPoint] = SPAWN_POINT_RENTING;

		PlayerData[playerid][pRenting] = h;
		SendClientMessageEx(playerid, COLOR_ADM, "[!] {FFFFFF}%s adresini kiraladýn. Ücret: $%s.", PropertyData[h][PropertyAddress], MoneyFormat(PropertyData[h][PropertyRentPrice]));
		SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Kiralamayý durdurana kadar burada oyuna baþlayacaksýn.");
		
        //LogPlayerAction(playerid, sprintf("%i numaralý evi kiraladý.", h));
	}
	else
	{
		PlayerData[playerid][pRenting] = -1;
		PlayerData[playerid][pSpawnPoint] = SPAWN_POINT_AIRPORT;
		SendServerMessage(playerid, "Artýk eski yerini kiralamýyorsun.");
	}
	return 1;
}

Property_ListDrugs(playerid, id, bool:readonly)
{
	new principal_str[756];

	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(property_drug_data[id][i][is_exist])
			format(principal_str, sizeof(principal_str), "%s%i. %s - %s (%s: %0.1fg/%i.0g) (Kalite: %i)\n", principal_str, i, property_drug_data[id][i][prop_drug_name], Drug_GetType(property_drug_data[id][i][prop_drug_size]), Drug_GetName(property_drug_data[id][i][prop_drug_id]), property_drug_data[id][i][prop_drug_amount], Drug_GetMaxAmount(property_drug_data[id][i][prop_drug_size]), property_drug_data[id][i][prop_drug_quality]);
		else
			format(principal_str, sizeof(principal_str), "%s%i. [Boþ]\n", principal_str, i);
	}
	
	if(readonly) Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Ev: Uyuþturucular", principal_str, "<<", "");
	else Dialog_Show(playerid, HOUSE_DRUGS, DIALOG_STYLE_LIST, "Ev: Uyuþturucular", principal_str, "Al", "<<");
	return 1;
}

Dialog:HOUSE_DRUGS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = -1;
		if((id = IsPlayerInProperty(playerid)) != -1)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[id][PropertyCheck][0], PropertyData[id][PropertyCheck][1], PropertyData[id][PropertyCheck][2]))
				return SendErrorMessage(playerid, "Zula noktasýna yakýn deðilsin.");

			if(!property_drug_data[id][listitem+1][is_exist])
				return SendErrorMessage(playerid, "Seçtiðiniz slot boþ gözüküyor.");

			new free_slot = Drug_GetPlayerNextSlot(playerid);
			if(free_slot == -1) return SendErrorMessage(playerid, "Üstünde daha fazla uyuþturucu bulunduramazsýn.");

			new drug_query[512];
			mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO player_drugs (player_dbid, drug_name, drug_type, drug_amount, drug_quality, drug_size) VALUES (%i, '%e', %i, %f, %i, %i)", PlayerData[playerid][pSQLID], property_drug_data[id][listitem+1][prop_drug_name], property_drug_data[id][listitem+1][prop_drug_id], property_drug_data[id][listitem+1][prop_drug_amount], property_drug_data[id][listitem+1][prop_drug_quality], property_drug_data[id][listitem+1][prop_drug_size]);
			new Cache: cache = mysql_query(m_Handle, drug_query);

			player_drug_data[playerid][free_slot][data_id] = cache_insert_id();
			player_drug_data[playerid][free_slot][drug_id] = property_drug_data[id][listitem+1][prop_drug_id];
			format(player_drug_data[playerid][free_slot][drug_name], 64, "%s", property_drug_data[id][listitem+1][prop_drug_name]);
			player_drug_data[playerid][free_slot][drug_amount] = property_drug_data[id][listitem+1][prop_drug_amount];
			player_drug_data[playerid][free_slot][drug_quality] = property_drug_data[id][listitem+1][prop_drug_quality];
			player_drug_data[playerid][free_slot][drug_size] = property_drug_data[id][listitem+1][prop_drug_size];
			player_drug_data[playerid][free_slot][is_exist] = true;
			
			cache_delete(cache);

			cmd_ame(playerid, sprintf("evin zulasýndan %s alýr.", Drug_GetName(property_drug_data[id][listitem+1][prop_drug_id])));
			Drug_PropertyDefaultValues(id, listitem+1);
			return 1;
		}	
	}
	return 1;
}	

GetPropertyDrugs(prop_id)
{
	new count = 0;
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(property_drug_data[prop_id][i][property_id] != -1)
		{
			count++;
		}
	}
	return count;
}

GetNextPropertyDrugSlot(prop_id)
{
	new i = 1;
	while(i != MAX_PACK_SLOT)
	{
		if(property_drug_data[prop_id][i][property_id] == -1)
		{
			return i;
		}
		i++;
	}
	return -1;
}

Server:AddWeaponToProperty(playerid, prop_id, slot, weapid, ammo)
{
	cmd_ame(playerid, sprintf("evin içerisine %s koyar.", ReturnWeaponName(weapid)));
	
	PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ] = 0;
	PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ] = 0;
	//RemovePlayerWeapon(playerid, weapid);

    property_weap_data[prop_id][slot][data_id] = cache_insert_id();
    property_weap_data[prop_id][slot][prop_wep] = weapid;
    property_weap_data[prop_id][slot][prop_ammo] = ammo;
    property_weap_data[prop_id][slot][is_exist] = true;
    property_weap_data[prop_id][slot][property_id] = prop_id;
	return 1;
}

ListPropertyWeaps(playerid, prop_id)
{
	new principal_str[354];
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(property_weap_data[prop_id][i][is_exist])
			format(principal_str, sizeof(principal_str), "%s%i. %s[Mermi: %i]\n", principal_str, i, ReturnWeaponName(property_weap_data[prop_id][i][prop_wep]), property_weap_data[prop_id][i][prop_ammo]);
		else
			format(principal_str, sizeof(principal_str), "%s%i. [Boþ]\n", principal_str, i);
	}
	Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Ev: Silahlar", principal_str, "<<", "");
	return 1;
}

RemoveWeaponFromProperty(playerid, prop_id, slot)
{
	GivePlayerWeapon(playerid, property_weap_data[prop_id][slot][prop_wep], property_weap_data[prop_id][slot][prop_ammo]);
	cmd_ame(playerid, sprintf("evin zulasýndan %s alýr.", ReturnWeaponName(property_weap_data[prop_id][slot][prop_wep])));

	new remove_query[64];
	mysql_format(m_Handle, remove_query, sizeof(remove_query), "DELETE FROM property_weapons WHERE id = %i", property_weap_data[prop_id][slot][data_id]);
	mysql_tquery(m_Handle, remove_query);

    property_weap_data[prop_id][slot][data_id] = EOS;
	property_weap_data[prop_id][slot][prop_wep] = 0;
    property_weap_data[prop_id][slot][prop_ammo] = 0;
    property_weap_data[prop_id][slot][is_exist] = false;
	return 1;
}

GetPropertyWeps(prop_id)
{
	new count = 0;
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(property_weap_data[prop_id][i][prop_wep])
		{
			count++;
		}
	}
	return count;
}

GetNextPropertyWeapSlot(prop_id)
{
	new i = 1;
	while(i != MAX_PACK_SLOT)
	{
		if(property_weap_data[prop_id][i][prop_wep] == 0)
		{
			return i;
		}
		i++;
	}
	return -1;
}

Property_Count(playerid)
{
	new sayi = 0;
	foreach(new i : Properties) if(PropertyData[i][PropertyOwnerID] == PlayerData[playerid][pSQLID]) sayi++;
	return sayi;
}

IsPlayerInProperty(playerid)
{
	new apt = PlayerData[playerid][pInsideApartment], house = PlayerData[playerid][pInsideHouse], complex = PlayerData[playerid][pInsideComplex];
	if(apt == -1 && complex == -1 && house > -1) return house;
	if(house == -1 && complex == -1 && apt > -1) return apt;
	if(apt == -1 && house == -1 && complex > -1) return complex;
	return -1;
}

IsPlayerNearProperty(playerid)
{
	if(GetPVarInt(playerid, "AtHouse") != -1)
	{
		new h = GetPVarInt(playerid, "AtHouse");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[h][PropertyEnter][0], PropertyData[h][PropertyEnter][1], PropertyData[h][PropertyEnter][2]))
		{
			return h;
		}	
	}			
	return -1;
}

CMD:aev(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return UnAuthMessage(playerid);

	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/aev [parametre]");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}ekle, duzenle, sat, git, incele");
		return 1;
	}

	if (!strcmp(type, "incele", true))
	{
		static type_two[24], string_two[128];
		if (sscanf(string, "s[24]S()[128]", type_two, string_two))
		{
			SendUsageMessage(playerid, "/aev incele [tip] [interior ID]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[bos][dolu]");
			return 1;
		}

		if (!strcmp(type_two, "bos", true))
		{
			new int;
			if(sscanf(string_two, "i", int)) return SendUsageMessage(playerid, "/aev incele bos [0-%i]", sizeof(g_PropertyInteriors) - 1);
			if(int < 0 || int > sizeof(g_PropertyInteriors) - 1) return SendErrorMessage(playerid, "Hatalý interior ID girdiniz. (0 - %i)", sizeof(g_PropertyInteriors) - 1);
			SendPlayer(playerid, g_PropertyInteriorsWOF[int][InteriorX], g_PropertyInteriorsWOF[int][InteriorY], g_PropertyInteriorsWOF[int][InteriorZ], g_PropertyInteriorsWOF[int][InteriorA], g_PropertyInteriorsWOF[int][InteriorID], 0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý boþ ev dekoruna ýþýnlandýn.", int);
			return 1;
		}	
		else if (!strcmp(type_two, "dolu", true))
		{
			new int;
			if(sscanf(string_two, "i", int)) return SendUsageMessage(playerid, "/aev incele dolu [0-%i]", sizeof(g_PropertyInteriors) - 1);
			if(int < 0 || int > sizeof(g_PropertyInteriors) - 1) return SendErrorMessage(playerid, "Hatalý interior ID girdiniz. (0 - %i)", sizeof(g_PropertyInteriors) - 1);
			SendPlayer(playerid, g_PropertyInteriors[int][InteriorX], g_PropertyInteriors[int][InteriorY], g_PropertyInteriors[int][InteriorZ], g_PropertyInteriors[int][InteriorA], g_PropertyInteriors[int][InteriorID], 0);
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý dolu ev dekoruna ýþýnlandýn.", int);
			return 1;
		}	
	}
	else if (!strcmp(type, "ekle", true))
	{
	    new prop_type;
	    if(sscanf(string, "i", prop_type)) 
	    {
	    	SendUsageMessage(playerid, "/aev ekle [tip]");
	    	SendClientMessage(playerid, COLOR_ADM, "--> 1:[Apartman] 2:[Apartman Dairesi] 3:[Ev]");
			return 1;
	    }	

	    if(prop_type < 1  || prop_type > 3) return SendErrorMessage(playerid, "Hatalý ev tipi girdiniz.");

		if(prop_type == 2)
		{
			//SendClientMessage(playerid, COLOR_ADM, " !! UYARI !! Apartman dairesi eklerken, /aev bilgi [apartman ID] to get the exterior WORLD.");
			//SendClientMessage(playerid, COLOR_ADM, " !! UYARI !! Set the apartments world to that exterior world using /editproperty OR IT WILL BUG.");
		}

		Property_Create(playerid, prop_type);
		return 1;
	}
	else if (!strcmp(type, "sat", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/aev sat [ev ID]");
		if(!Iter_Contains(Properties, id)) return SendErrorMessage(playerid, "Hatalý ev ID girdin.");
		if(!PropertyData[id][PropertyOwnerID]) return SendErrorMessage(playerid, "Sahibi olmayan evi satamazsýn.");
		if(IsPlayerNearProperty(playerid) != id) return SendErrorMessage(playerid, "Satmak istediðin evin giriþ kapýsýnda olmalýsýn.");

		foreach(new i : Player)
		{
			if(strfind(ReturnName(i, 1), ReturnSQLName(PropertyData[id][PropertyOwnerID]), true) != -1)
			{
				SendClientMessageEx(i, COLOR_ADM, "[!] %i numaralý evin bir %s isimli yönetici tarafýndan el konuldu.", id, ReturnName(playerid));
			}
		}

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i (sahibi: %s) numaralý eve el koydun.", id, ReturnSQLName(PropertyData[id][PropertyOwnerID]));
		adminWarn(4, sprintf("%s isimli yönetici %i (sahibi: %s) numaralý eve el koydu.", id, ReturnSQLName(PropertyData[id][PropertyOwnerID])));
		PropertyData[id][PropertyOwnerID] = 0;
		Property_Refresh(id);
		Property_Save(id);
		return 1;
	}
	else if (!strcmp(type, "duzenle", true))
	{
		static id, type_two[24], string_two[128];
		if (sscanf(string, "ds[24]S()[128]", id, type_two, string_two))
		{
			SendUsageMessage(playerid, "/aev duzenle [ev ID] [parametre]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[exterior][interior][extinterior][extworld][intworld][bareswitch]");
		    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}[complexlink][seviye][fiyat][seviye][kirafiyat][kilit][birlik]");
			return 1;
		}

		if(!Iter_Contains(Properties, id)) return SendErrorMessage(playerid, "Hatalý ev ID girdin.");

		if (!strcmp(type_two, "intworld", true))
		{
			new fid;
			if(sscanf(string_two, "i", fid)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] birlik [birlik ID]");
			if(!Iter_Contains(Factions, id)) return SendErrorMessage(playerid, "Hatalý birlik ID girdin.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin birlik deðerini %s(ID:%i) olarak güncelledin.", FactionData[fid][FactionName], fid);
			PropertyData[id][PropertyFaction] = fid;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "exterior", true))
		{
		    GetPlayerPos(playerid, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]);
		    GetPlayerFacingAngle(playerid, PropertyData[id][PropertyEnter][3]);
			PropertyData[id][PropertyEnterInterior] = GetPlayerInterior(playerid);
			PropertyData[id][PropertyEnterWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu evin dýþ pozisyonunu güncelledin.");
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "complexlink", true))
		{
			if(PropertyData[id][PropertyType] != 2) return SendErrorMessage(playerid, "Bu komutu sadece apartman daireleri için kullanabilirsin.");

			new apt;
			if(sscanf(string_two, "i", apt)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] complexlink [apartman ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu dairenin baðlý olduðu apartmaný %i olarak güncelledin.", apt);
			PropertyData[id][PropertyComplexLink] = apt;
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "extworld", true))
		{
			if(PropertyData[id][PropertyType] != 2) return SendErrorMessage(playerid, "Bu komutu sadece apartman daireleri için kullanabilirsin.");

			new extworld;
			if(sscanf(string_two, "i", extworld)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] extworld [world ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin dýþ pozisyon world deðerini %i olarak güncelledin.", extworld);
			PropertyData[id][PropertyEnterWorld] = extworld;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "extinterior", true))
		{
			if(PropertyData[id][PropertyType] != 2) return SendErrorMessage(playerid, "Bu komutu sadece apartman daireleri için kullanabilirsin.");

			new extint;
			if(sscanf(string_two, "i", extint)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] extinterior [interior ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin dýþ pozisyon interior deðerini %i olarak güncelledin.", extint);
			PropertyData[id][PropertyEnterInterior] = extint;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "interior", true))
		{
		    GetPlayerPos(playerid, PropertyData[id][PropertyExit][0], PropertyData[id][PropertyExit][1], PropertyData[id][PropertyExit][2]);
		    GetPlayerFacingAngle(playerid, PropertyData[id][PropertyExit][3]);
			PropertyData[id][PropertyExitInterior] = GetPlayerInterior(playerid);

			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Bu evin iç pozisyonunu güncelledin.");
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "intworld", true))
		{
			new intworld;
			if(sscanf(string_two, "i", intworld)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] intworld [world ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin iç pozisyon world deðerini %i olarak güncelledin.", intworld);
			PropertyData[id][PropertyExitWorld] = intworld;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "saat", true))
		{
			new intworld;
			if(sscanf(string_two, "i", intworld)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] saat [0-23]");
			if(intworld < 0 || intworld > 23) return SendErrorMessage(playerid, "Saat deðeri 0 - 23 aralýðýnda olmalýdýr.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin iç interior saatini %i olarak güncelledin.", intworld);
			PropertyData[id][PropertyTime] = intworld;
			
			foreach(new i : Player) if(IsPlayerInProperty(i) == id)
			{
				SetPlayerTime(i, PropertyData[id][PropertyTime], 0);
			}

			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "bareswitch", true))
		{
			if(PropertyData[id][PropertyType] != 3) return SendErrorMessage(playerid, "Bu komutu sadece evler için kullanabilirsin.");

			new extint;
			if(sscanf(string_two, "i", extint)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] bareswitch [interior ID]");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin bareswitch interior deðerini %i olarak güncelledin.", extint);
			
			PropertyData[id][PropertySwitchID] = extint;
			if(PropertyData[id][PropertySwitchID] != -1) PropertyData[id][PropertySwitch] = true;
			else PropertyData[id][PropertySwitch] = false;

			//Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "seviye", true))
		{
			new level;
			if(sscanf(string_two, "i", level)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] seviye [miktar]");
			if(level < 1 || level > 150) return SendErrorMessage(playerid, "Seviye miktarý en az 1 en fazla 150 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin seviyesini %i olarak güncelledin.", level);
			PropertyData[id][PropertyLevel] = level;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "fiyat", true))
		{
			new fiyat;
			if(sscanf(string_two, "i", fiyat)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] fiyat [miktar]");
			if(fiyat < 1 || fiyat > 5000000) return SendErrorMessage(playerid, "Fiyat en az $1 en fazla $5,000,000 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin fiyatýný $%s olarak güncelledin.", MoneyFormat(fiyat));
			PropertyData[id][PropertyMarketPrice] = fiyat;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "birlik", true))
		{
			new birlik;
			if(sscanf(string_two, "i", birlik)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] birlik [birlik ID](-1 sahipsiz)");
			if(!Iter_Contains(Factions, birlik)) return SendErrorMessage(playerid, "Hatalý birlik ID girdin.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin birliðini %s olarak güncelledin.", FactionData[birlik][FactionName]);
			PropertyData[id][PropertyFaction] = birlik;
			Property_Refresh(id);
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kirafiyat", true))
		{
			new fiyat;
			if(sscanf(string_two, "i", fiyat)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] kirafiyat [miktar]");
			if(fiyat < 1 || fiyat > 500) return SendErrorMessage(playerid, "Kira fiyatý en az $1 en fazla $500 olabilir.");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin kira fiyatýný $%s olarak güncelledin.", MoneyFormat(fiyat));
			PropertyData[id][PropertyRentPrice] = fiyat;
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kilit", true))
		{
			new locked;
			if(sscanf(string_two, "i", locked)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] kilit [0/1]");
			if(locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatalý kilit durumu girdin. (0/1)");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin kapýlarýný %s olarak güncelledin.", !locked ? ("kilitli deðil") : ("kilitli"));
			PropertyData[id][PropertyLocked] = bool:locked;
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "isik", true))
		{
			new locked;
			if(sscanf(string_two, "i", locked)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] isik [0/1]");
			if(locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatalý ýþýk durumu girdin. (0/1)");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin ýþýklarýný %s olarak güncelledin.", !locked ? ("açýk deðil") : ("açýk"));
			PropertyData[id][PropertyLights] = bool:locked;
			Property_Save(id);
			return 1;
		}
		else if (!strcmp(type_two, "kiradurum", true))
		{
			new locked;
			if(sscanf(string_two, "i", locked)) return SendUsageMessage(playerid, "/aev duzenle [ev ID] kiradurum [0/1]");
			if(locked < 0 || locked > 1) return SendErrorMessage(playerid, "Hatalý kira durumu girdin. (0/1)");
			SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu evin kira durumunu %s olarak güncelledin.", !locked ? ("kiralýk deðil") : ("kiralýk"));
			PropertyData[id][PropertyRentable] = bool:locked;
			Property_Save(id);
			return 1;
		}
	}
	else if (!strcmp(type, "bilgi", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/aev bilgi [ev ID]");
		if(!Iter_Contains(Properties, id)) return SendErrorMessage(playerid, "Hatalý ev ID girdin.");

		new garage_id;
		foreach(new i : Garages) if(GarageData[i][GaragePropertyID] == id) garage_id = i;
		SendClientMessage(playerid, COLOR_DARKGREEN, "____________________________________________");
		SendClientMessageEx(playerid, COLOR_WHITE, "Sahip:[%s] Level:[%d] MarketPrice:[%d] Tip:[%d] Kilit Durumu:[%d] ID:[%d]", PropertyData[id][PropertyOwnerID] ? ReturnSQLName(PropertyData[id][PropertyOwnerID]) : "Yok", PropertyData[id][PropertyLevel], PropertyData[id][PropertyMarketPrice], PropertyData[id][PropertyType], PropertyData[id][PropertyLocked], PropertyData[id][PropertyID]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Interior:[%d] InteriorWorld:[%d] (Apartment)Exterior:[%d] ExteriorWorld:[%d] ComplexLink:[%d]", PropertyData[id][PropertyEnterInterior], PropertyData[id][PropertyEnterWorld], PropertyData[id][PropertyExitInterior], PropertyData[id][PropertyExitWorld], PropertyData[id][PropertyComplexLink]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Cashbox:[%d], Faction:[%d], Linked Garage:[%d]", PropertyData[id][PropertyMoney], PropertyData[id][PropertyFaction], garage_id);
		SendClientMessage(playerid, COLOR_DARKGREEN, "____________________________________________");
		return 1;
 	}

	else if (!strcmp(type, "git", true))
	{
		static id;
		if(sscanf(string, "i", id)) return SendUsageMessage(playerid, "/aev git [ev ID]");
		if(!Iter_Contains(Properties, id)) return SendErrorMessage(playerid, "Hatalý ev ID girdin.");
		SendPlayer(playerid, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2], PropertyData[id][PropertyEnter][3], PropertyData[id][PropertyEnterInterior], PropertyData[id][PropertyEnterWorld]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý eve ýþýnlandýn.", id);
		return 1;
 	}
 	return 1;
}

Property_Create(playerid, type)
{
	new id = Iter_Free(Properties);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek ev sýnýrýna ulaþýlmýþ.");

	GetPlayerPos(playerid, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]);
	GetPlayerFacingAngle(playerid, PropertyData[id][PropertyEnter][3]);

	GetPlayerPos(playerid, PropertyData[id][PropertyExit][0], PropertyData[id][PropertyExit][1], PropertyData[id][PropertyExit][2]);
	GetPlayerFacingAngle(playerid, PropertyData[id][PropertyExit][3]);

	switch(type)
	{
		case 2:
		{
			PropertyData[id][PropertyEnterInterior] = GetPlayerInterior(playerid);
			PropertyData[playerid][PropertyEnterWorld] = 50000+random(9999);

			PropertyData[id][PropertyComplexLink] = PlayerData[playerid][pInsideComplex];
			PropertyData[id][PropertyExitInterior] = PropertyData[PropertyData[id][PropertyComplexLink]][PropertyExitInterior];
			PropertyData[id][PropertyExitWorld] = PropertyData[PropertyData[id][PropertyComplexLink]][PropertyExitWorld];
		}
		default: 
		{
			PropertyData[id][PropertyEnterInterior] = 0;
			PropertyData[id][PropertyEnterWorld] = 0;
			
			PropertyData[id][PropertyExitInterior] = GetPlayerInterior(playerid);
			PropertyData[id][PropertyExitWorld] = 50000+random(9999);
		}
	}
	
	PropertyData[id][PropertyOwnerID] = 0;
	PropertyData[id][PropertyType] = type;
	PropertyData[id][PropertyMarketPrice] = 50000;
	PropertyData[id][PropertyFaction] = -1;
	PropertyData[id][PropertyLevel] = 5;
	PropertyData[id][PropertyMoney] = 0;
	PropertyData[id][PropertyLocked] = true;
	PropertyData[id][PropertyRentable] = false;
	PropertyData[id][PropertyHasXMR] = false;
	PropertyData[id][PropertyRentPrice] = 20;
	PropertyData[id][PropertySwitchID] = -1;
	PropertyData[id][PropertySwitch] = false;
	PropertyData[id][PropertyTime] = 12;
	PropertyData[id][PropertyLights] = false;
	Iter_Add(Properties, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaralý %s ekledin.", id, Property_Type(id));
    mysql_tquery(m_Handle, "INSERT INTO properties (Money) VALUES(0)", "OnPropertyCreated", "d", id);
	Property_Refresh(id);
	return 1;
}

Server:OnPropertyCreated(id)
{
	PropertyData[id][PropertyID] = cache_insert_id();
	Property_Save(id);
	return 1;
}

Property_Save(id)
{
	new
	    query[545];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE properties SET OwnerSQL = %i, Type = %i, ComplexID = %i, Faction = %i, Level = %i, Money = %i WHERE id = %i",
	    PropertyData[id][PropertyOwnerID],
	    PropertyData[id][PropertyType],
	    PropertyData[id][PropertyComplexLink],
	    PropertyData[id][PropertyFaction],
	    PropertyData[id][PropertyLevel],
	    PropertyData[id][PropertyMoney],
	    PropertyData[id][PropertyID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE properties SET ExteriorX = %f, ExteriorY = %f, ExteriorZ = %f, ExteriorA = %f, ExteriorID = %i, ExteriorWorld = %i WHERE id = %i",
	    PropertyData[id][PropertyEnter][0],
	    PropertyData[id][PropertyEnter][1],
	    PropertyData[id][PropertyEnter][2],
	    PropertyData[id][PropertyEnter][3],
	    PropertyData[id][PropertyEnterInterior],
	    PropertyData[id][PropertyEnterWorld],
	    PropertyData[id][PropertyID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE properties SET InteriorX = %f, InteriorY = %f, InteriorZ = %f, InteriorA = %f, InteriorID = %i, InteriorWorld = %i WHERE id = %i",
	    PropertyData[id][PropertyExit][0],
	    PropertyData[id][PropertyExit][1],
	    PropertyData[id][PropertyExit][2],
	    PropertyData[id][PropertyExit][3],
	    PropertyData[id][PropertyExitInterior],
	    PropertyData[id][PropertyExitWorld],
	    PropertyData[id][PropertyID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE properties SET CheckPosX = %f, CheckPosY = %f, CheckPosZ = %f, CheckID = %i, CheckWorld = %i, Time = %i, Lights = %i WHERE id = %i",
	    PropertyData[id][PropertyCheck][0],
	    PropertyData[id][PropertyCheck][1],
	    PropertyData[id][PropertyCheck][2],
	    PropertyData[id][PropertyCheckInterior],
	    PropertyData[id][PropertyCheckWorld],
	    PropertyData[id][PropertyTime],
	    bool: PropertyData[id][PropertyLights],
	    PropertyData[id][PropertyID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE properties SET MarketPrice = %i, RentPrice = %i, Rentable = %i, Locked = %i, HasXMR = %i, BareSwitch = %i, BareType = %i, XMRPosX = %f, XMRPosY = %f, XMRPosZ = %f, XMRRotX = %f, XMRRotY = %f, XMRRotZ = %f WHERE id = %i",
	    PropertyData[id][PropertyMarketPrice],
	    PropertyData[id][PropertyRentPrice],
	    PropertyData[id][PropertyRentable],
	    PropertyData[id][PropertyLocked],
	    PropertyData[id][PropertyHasXMR],
	    PropertyData[id][PropertySwitchID],
	    PropertyData[id][PropertySwitch],
	   	PropertyData[id][PropertyXMR][0],
	    PropertyData[id][PropertyXMR][1],
	    PropertyData[id][PropertyXMR][2],
	   	PropertyData[id][PropertyXMR][3],
	    PropertyData[id][PropertyXMR][4],
	    PropertyData[id][PropertyXMR][5],
	    PropertyData[id][PropertyID]
	);
	mysql_tquery(m_Handle, query);

	for(new i = 1; i < MAX_PACK_SLOT; ++i)
	{
		if(!property_drug_data[id][i][is_exist]) continue;

		mysql_format(m_Handle, query, sizeof(query), "UPDATE property_drugs SET drug_name = '%e', drug_type = %i, drug_amount = %f, drug_quality = %i, drug_size = %i WHERE id = %i", 
			property_drug_data[id][i][prop_drug_name],
			property_drug_data[id][i][prop_drug_id],
			property_drug_data[id][i][prop_drug_amount],
			property_drug_data[id][i][prop_drug_quality],
			property_drug_data[id][i][prop_drug_size],
			property_drug_data[id][i][data_id]
		);
		mysql_tquery(m_Handle, query);
	}

	return 1;
}

Property_Refresh(id)
{
	if(IsValidDynamicPickup(PropertyData[id][PropertyPickup])) DestroyDynamicPickup(PropertyData[id][PropertyPickup]);
 	if(IsValidDynamicObject(PropertyData[id][PropertyXMRObject])) DestroyDynamicObject(PropertyData[id][PropertyXMRObject]);
 	if(IsValidDynamic3DTextLabel(PropertyData[id][PropertyMarketLabel])) DestroyDynamic3DTextLabel(PropertyData[id][PropertyMarketLabel]);

	if(IsValidDynamicArea(PropertyData[id][PropertyAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, PropertyData[id][PropertyAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(PropertyData[id][PropertyAreaID][0]);
	}

	if (IsValidDynamicArea(PropertyData[id][PropertyAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, PropertyData[id][PropertyAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(PropertyData[id][PropertyAreaID][1]);
	}

	switch(PropertyData[id][PropertyType])
	{
	    case 1:
	    {
 			format(PropertyData[id][PropertyAddress], MAX_PROPERTY_ADDRESS, "%i %s, %s, %s %i, San Andreas", id, GetStreet(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]), GetZoneName(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]), GetCityName(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]), ReturnAreaCode(GetZoneID(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2])));
	  		PropertyData[id][PropertyPickup] = CreateDynamicPickup(1314, 1, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]);
	    }
	    case 2: 
	    {
		    new link = PropertyData[id][PropertyComplexLink]; 
		    format(PropertyData[id][PropertyAddress], MAX_PROPERTY_ADDRESS, "%i %s, %s, %s %i, San Andreas", id, GetStreet(PropertyData[link][PropertyEnter][0], PropertyData[link][PropertyEnter][1], PropertyData[link][PropertyEnter][2]), GetZoneName(PropertyData[link][PropertyEnter][0], PropertyData[link][PropertyEnter][1], PropertyData[link][PropertyEnter][2]), GetCityName(PropertyData[link][PropertyEnter][0], PropertyData[link][PropertyEnter][1], PropertyData[link][PropertyEnter][2]), ReturnAreaCode(GetZoneID(PropertyData[link][PropertyEnter][0], PropertyData[link][PropertyEnter][1], PropertyData[link][PropertyEnter][2])));
	    }
		case 3: format(PropertyData[id][PropertyAddress], MAX_PROPERTY_ADDRESS, "%i %s, %s, %s %i, San Andreas", id, GetStreet(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]), GetZoneName(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]), GetCityName(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]), ReturnAreaCode(GetZoneID(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2])));
	}

	if(!PropertyData[id][PropertyOwnerID] && PropertyData[id][PropertyFaction] == -1) 
	{
        PropertyData[id][PropertyMarketLabel] = 
        CreateDynamic3DTextLabel(sprintf("%s[%i] Satýlýk:\nÜcret: $%s\nSeviye: %i\nKilit Seviyesi: 1\nAlarm Seviyesi: 1", Property_Type(id), id, MoneyFormat(PropertyData[id][PropertyMarketPrice]), PropertyData[id][PropertyLevel]), 0xC38A39FF, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2]+0.35, 10.0, .worldid = PropertyData[id][PropertyEnterWorld]);
	}

	if(PropertyData[id][PropertyHasXMR]) {
		PropertyData[id][PropertyXMRObject] = CreateDynamicObject(2103, PropertyData[id][PropertyXMR][0], PropertyData[id][PropertyXMR][1], PropertyData[id][PropertyXMR][2], PropertyData[id][PropertyXMR][3], PropertyData[id][PropertyXMR][4], PropertyData[id][PropertyXMR][5], PropertyData[id][PropertyExitWorld], PropertyData[id][PropertyExitInterior]);
	}

	new array[2]; array[0] = 25; array[1] = id;
	PropertyData[id][PropertyAreaID][0] = CreateDynamicSphere(PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2], 3.0, PropertyData[id][PropertyEnterWorld], PropertyData[id][PropertyEnterInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, PropertyData[id][PropertyAreaID][0], E_STREAMER_EXTRA_ID, array, 2);

	array[0] = 26; array[1] = id;
	PropertyData[id][PropertyAreaID][1] = CreateDynamicSphere(PropertyData[id][PropertyExit][0], PropertyData[id][PropertyExit][1], PropertyData[id][PropertyExit][2], 3.0, PropertyData[id][PropertyExitWorld], PropertyData[id][PropertyExitInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, PropertyData[id][PropertyAreaID][1], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Property_Type(id)
{
	new typo[17];
	switch(PropertyData[id][PropertyType])
	{
		case 1: typo = "Apartman";
		case 2: typo = "Apartman Dairesi";
		case 3: typo = "Ev";
	}
	return typo;
}