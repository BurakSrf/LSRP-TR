CMD:uyusturucularim(playerid, params[])
{
    new id;
	if(sscanf(params, "U(-1)", id)) return SendUsageMessage(playerid, "/uyusturucularim [oyuncu ID/isim]");
    if(id == -1) {
    	SendClientMessageEx(playerid, COLOR_ADM, "%s Uyuþturucularý:", ReturnName(playerid, 0));
    	Player_ListDrugs(playerid, playerid);
    	return 1;
    }

	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 2.0)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
	SendClientMessageEx(id, COLOR_ADM, "%s Uyuþturucularý:", ReturnName(playerid, 0));
    Player_ListDrugs(playerid, id);
	return 1;
}

CMD:uver(playerid, params[])
{
	new id, slot, Float: amount, free_slot;
	if(sscanf(params, "uif", id, slot, amount)) return SendUsageMessage(playerid, "/uver [oyuncu ID/adý] [uyuþturucu slotu] [gram]");
	if(playerid == id) return SendErrorMessage(playerid, "Kendine uyuþturucu veremezsin.");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, id, 2.0)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
	if(slot < 1 || slot > 24) return SendErrorMessage(playerid, "Geçersiz uyuþturucu slotu belirttin.");
	if(!player_drug_data[playerid][slot][is_exist]) return SendErrorMessage(playerid, "Bu slotta uyuþturucun yok.");
	if(amount < 0.1 || amount > player_drug_data[playerid][slot][drug_amount])
		return SendErrorMessage(playerid, "Bu slotta bu kadar uyuþturucun yok.");

	free_slot = Drug_GetPlayerNextSlot(id);

	if(free_slot == -1) {
		return SendServerMessage(playerid, "%s üstünde daha fazla uyuþturucu bulunduramaz.", ReturnName(id, 0));
	}

	new drug_query[512];
	mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO player_drugs (player_dbid, drug_name, drug_type, drug_amount, drug_quality, drug_size) VALUES (%i, '%e', %i, %f, %i, %i)", 
		PlayerData[id][pSQLID], 
		player_drug_data[playerid][slot][drug_name], 
		player_drug_data[playerid][slot][drug_id], 
		amount, 
		player_drug_data[playerid][slot][drug_quality], 
		player_drug_data[playerid][slot][drug_size]
	);
	new Cache: cache = mysql_query(m_Handle, drug_query);

	player_drug_data[id][free_slot][data_id] = cache_insert_id();
	player_drug_data[id][free_slot][drug_id] = player_drug_data[playerid][slot][drug_id];
	format(player_drug_data[id][free_slot][drug_name], 64, "%s", player_drug_data[playerid][slot][drug_name]);
	player_drug_data[id][free_slot][drug_amount] = amount;
	player_drug_data[id][free_slot][drug_quality] = player_drug_data[playerid][slot][drug_quality];
	player_drug_data[id][free_slot][drug_size] = player_drug_data[playerid][slot][drug_size];
	player_drug_data[id][free_slot][is_exist] = true;

	cache_delete(cache);

	cmd_ame(playerid, sprintf("%s adlý kiþiye %s verir.", ReturnName(id, 0), Drug_GetName(player_drug_data[id][free_slot][drug_id])));
	SendClientMessageEx(playerid, COLOR_YELLOW, "%s adlý kiþiye %s - %s (%s) verdin.", ReturnName(id, 0), player_drug_data[id][free_slot][drug_name], Drug_GetName(player_drug_data[id][free_slot][drug_id]), Drug_GetType(player_drug_data[id][free_slot][drug_size]));
	SendClientMessageEx(id, COLOR_YELLOW, "%s sana %s - %s (%s) verdi.", ReturnName(playerid, 0), player_drug_data[id][free_slot][drug_name], Drug_GetName(player_drug_data[id][free_slot][drug_id]), Drug_GetType(player_drug_data[id][free_slot][drug_size]));

	player_drug_data[playerid][slot][drug_amount] -= amount;
	if(player_drug_data[playerid][slot][drug_amount] < 0.1) Drug_DefaultValues(playerid, slot);
	return 1;
}

CMD:ubirak(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Araç içerisinde bu komutu kullanamazsýn.");

	new slot, Float: amount;
	if(sscanf(params, "if", slot, amount)) {
		SendUsageMessage(playerid, "/ubirak [uyuþturucu slotu] [gram]");
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Uyuþturucuyu yerden almak için, /ual yazabilirsin."); 
		return 1;
	}

	if(slot < 1 || slot > 24) return SendErrorMessage(playerid, "Geçersiz uyuþturucu slotu belirttin.");
	if(!player_drug_data[playerid][slot][is_exist]) return SendErrorMessage(playerid, "Bu slotta uyuþturucun yok.");
	
	if(amount < 0.1 || amount > player_drug_data[playerid][slot][drug_amount])
		return SendErrorMessage(playerid, "Bu slotta bu kadar uyuþturucun yok.");

	new id = Iter_Free(Drops);
	if(id == -1) return SendErrorMessage(playerid, "Görünüþe göre uyuþturucuyu býrakmak þu anda mümkün deðil.");

	DropData[id][DropType] = 2;
	DropData[id][DropDrugAmount] = amount;
	DropData[id][DropDrugID] = player_drug_data[playerid][slot][drug_id];
	format(DropData[id][DropDrugName], 64, "%s", player_drug_data[playerid][slot][drug_name]);
	DropData[id][DropDrugQuality] = player_drug_data[playerid][slot][drug_quality];
	DropData[id][DropDrugSize] = player_drug_data[playerid][slot][drug_size];

	player_drug_data[playerid][slot][drug_amount] -= amount;
	if(player_drug_data[playerid][slot][drug_amount] < 0.1) Drug_DefaultValues(playerid, slot);

	GetPlayerPos(playerid, DropData[id][DropLocation][0], DropData[id][DropLocation][1], DropData[id][DropLocation][2]);
	DropData[id][DropInterior] = GetPlayerInterior(playerid); DropData[id][DropWorld] = GetPlayerVirtualWorld(playerid);

	DropData[id][DroppedBy] = PlayerData[playerid][pSQLID];
	DropData[id][DropObjID] = CreateDynamicObject(Drug_GetDropType(DropData[id][DropDrugSize]), DropData[id][DropLocation][0], DropData[id][DropLocation][1], DropData[id][DropLocation][2] - 1.0, 0.0, 0.0, 0.0, DropData[id][DropWorld], DropData[id][DropInterior]); 
	DropData[id][DropTimer] = SetTimerEx("Drop_DrugRemove", 600000, false, "i", id);
	Iter_Add(Drops, id);

	SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Uyuþturucu 10 dakika içerisinde kaybolacak. /ual yazarak geri alabilirsin.");
	cmd_ame(playerid, "yere bir þeyler býrakýr.");
	return 1;
}

Server:Drop_DrugRemove(id)
{
	if(IsValidDynamicObject(DropData[id][DropObjID])) {
		DestroyDynamicObject(DropData[id][DropObjID]);
	}

	KillTimer(DropData[id][DropTimer]);
	DropData[id][DropTimer] = -1;

	DropData[id][DropType] = 0;
	DropData[id][DropWeaponID] = DropData[id][DropWeaponAmmo] = 0;

	DropData[id][DropDrugAmount] = 0.0;
	DropData[id][DropType] = DropData[id][DropDrugID] = 0;
	DropData[id][DropDrugQuality] = DropData[id][DropDrugSize] = 0;
	format(DropData[id][DropDrugName], 64, "");

	for(new i = 0; i < 3; i++) DropData[id][DropLocation][i] = 0.0;
	DropData[id][DropInterior] = 0;
	DropData[id][DropWorld] = 0;
	DropData[id][DroppedBy] = 0;

	Iter_Remove(Drops, id);
	return 1;
}

CMD:ual(playerid, params[])
{
	new id = -1;
	if((id = Drop_Nearest(playerid)) != -1)
	{
		new free_slot = Drug_GetPlayerNextSlot(playerid);
		if(free_slot == -1) return SendErrorMessage(playerid, "Üstünde daha fazla uyuþturucu bulunduramazsýn.");

		new drug_query[512];
		mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO player_drugs (player_dbid, drug_name, drug_type, drug_amount, drug_quality, drug_size) VALUES (%i, '%e', %i, %f, %i, %i)", PlayerData[playerid][pSQLID], DropData[id][DropDrugName], DropData[id][DropDrugID], DropData[id][DropDrugAmount], DropData[id][DropDrugQuality], DropData[id][DropDrugSize]);
		new Cache: cache = mysql_query(m_Handle, drug_query);

		player_drug_data[playerid][free_slot][data_id] = cache_insert_id();
		player_drug_data[playerid][free_slot][drug_id] = DropData[id][DropDrugID];
		format(player_drug_data[playerid][free_slot][drug_name], 64, "%s", DropData[id][DropDrugName]);
		player_drug_data[playerid][free_slot][drug_amount] = DropData[id][DropDrugAmount];
		player_drug_data[playerid][free_slot][drug_quality] = DropData[id][DropDrugQuality];
		player_drug_data[playerid][free_slot][drug_size] = DropData[id][DropDrugSize];
		player_drug_data[playerid][free_slot][is_exist] = true;
		cache_delete(cache);

		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yakýnýnda bulunan %s - %s (%s) uyuþturucuyu aldýn.", DropData[id][DropDrugName], Drug_GetName(DropData[id][DropDrugID]), Drug_GetType(DropData[id][DropDrugSize]));
		cmd_ame(playerid, "yerden bir þeyler alýr.");
		Drop_DrugRemove(id);
		return 1;
	}

	SendErrorMessage(playerid, "Etrafýnda uyuþturucu alabileceðin yer yok.");
	return 1;
}

CMD:ukullan(playerid, params[])
{
	new slot, Float: amount, emote[128];
	if(sscanf(params, "ifS('Yok')[128]", slot, amount, emote)) return SendUsageMessage(playerid, "/ukullan [uyuþturucu slotu] [gram] [emote]");
	if(slot < 1 || slot > 20) return SendErrorMessage(playerid, "Geçersiz uyuþturucu slotu belirttin.");
	if(!player_drug_data[playerid][slot][is_exist]) return SendErrorMessage(playerid, "Bu slotta uyuþturucun yok.");
	
	if(amount < 0.1) return SendErrorMessage(playerid, "Tek seferde en az 0.1 gram %s kullanabilirsin.", Drug_GetName(player_drug_data[playerid][slot][drug_id]));
	if(amount > 0.3) return SendErrorMessage(playerid, "Tek seferde en fazla 0.3 gram %s kullanabilirsin.", Drug_GetName(player_drug_data[playerid][slot][drug_id]));
	if(player_drug_data[playerid][slot][drug_amount] < amount) return SendErrorMessage(playerid, "Bu slotta yeterli uyuþturucun yok.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "%0.1f gram %s kullandýn.", amount, Drug_GetName(player_drug_data[playerid][slot][drug_id]));
	if(strfind(emote, "Yok", true) != -1) cmd_ame(playerid, sprintf("%s kullanýr.", Drug_GetName(player_drug_data[playerid][slot][drug_id])));
	else cmd_ame(playerid, sprintf("%s", emote));

	Player_UseDrug(playerid, player_drug_data[playerid][slot][drug_id], player_drug_data[playerid][slot][drug_quality], amount);

	player_drug_data[playerid][slot][drug_amount] -= amount;
	if(player_drug_data[playerid][slot][drug_amount] < 0.1) Drug_DefaultValues(playerid, slot);
	return 1;
}

Player_SetTime(playerid)
{
	gettime(hour, minute, second); 
	SetPlayerTime(playerid, hour, minute);
	return 1;
}

Player_SetWeather(playerid)
{
	SetPlayerWeather(playerid, weather);
	return 1;
}

Server:Player_HealUp(playerid, amount)
{
	if(PlayerData[playerid][pDrugLoop] > 3)
	{
		KillTimer(PlayerData[playerid][pDrugTimer]);
		PlayerData[playerid][pDrugTimer] = -1;
		return 1;
	}

	if(GetPlayerInterior(playerid) != GetPVarInt(playerid, "drug_int"))
	{
		KillTimer(PlayerData[playerid][pDrugTimer]);
		PlayerData[playerid][pDrugTimer] = -1;
		return 1;
	}

	if(PlayerData[playerid][pMaxHealth] > 200)
	{
		KillTimer(PlayerData[playerid][pDrugTimer]);
		PlayerData[playerid][pDrugTimer] = -1;
		return 1;
	}

	PlayerData[playerid][pDrugLoop]++;
	PlayerData[playerid][pMaxHealth] += amount;

	new Float: hp;
	GetPlayerHealth(playerid, hp);
	new sonuc = (floatround(hp) + amount >= 100) ? 100 : floatround(hp) + amount;
	SetPlayerHealth(playerid, sonuc);
	return 1;
}

Player_UseDrug(playerid, drugid, quality, Float: amount = 0.0)
{
	new Float: total; //effect;
	PlayerData[playerid][pDrugUse] = drugid;
   	SetPVarInt(playerid, "drug_int", GetPlayerInterior(playerid));
    PlayerTextDrawHide(playerid, drug_effect[playerid]);
	KillTimer(PlayerData[playerid][pDrugTimer]);
	PlayerData[playerid][pDrugTimer] = -1;
	PlayerData[playerid][pDrugLoop] = 0;

	switch(drugid)
	{
		case DRUG_TYPE_XANAX:
		{
			PlayAnimation(playerid, "PED", "WALK_DRUNK", 4.1, 1, 1, 1, 1, 1, 1);
		}
		case DRUG_TYPE_MDMA:
		{
			total = (amount * randomEx(10, 15));
			PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
		}
	    case DRUG_TYPE_MARIJUANA, DRUG_TYPE_CRACK:
	    {
			InfoTD_MSG(playerid, 1, 8000, "\
				\" ~g~LMB ~w~\" TUSUYLA DUMANLANABILIR.~n~\
				\" ~r~ENTER ~w~\" TUSUYLA SIGARAYI ATABILIRSIN.");

			total = (amount * randomEx(10, 15));
		    PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
		   	PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	    }
	    case DRUG_TYPE_COCAINE:
	   	{
	   		total = (amount * randomEx(10, 15));
	    	PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
			PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
	   	}
	   	case DRUG_TYPE_ECSTASY:
	    {
	    	total = (amount * randomEx(10, 15));
	    	PlayerData[playerid][pDrugChgWeather] = gettime() + 4;
	    	PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
			PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
	    }
	    case DRUG_TYPE_QUAALUDES: 
	    {
	    	total = (amount * randomEx(8, 10));
		    PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
	    }
	    case DRUG_TYPE_PEYOTE: 
	    {
	    	total = (amount * randomEx(10, 15));
	    	PlayerData[playerid][pDrugChgWeather] = gettime() + 4;
	    	PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
	     	PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
	    }
	    case DRUG_TYPE_MORPHINE:
	    {
	    	if(amount > 0.2) cmd_crack3(playerid, "");
	    	new Float: hp; 	GetPlayerHealth(playerid, hp);
	    	SetPlayerHealth(playerid, hp - 3);
	    }
	    case DRUG_TYPE_HALOP:
	    {
	    	//effect = (quality * randomEx(45, 50));
	    	//SetPlayerDrunkLevel(playerid, effect);
	    	new Float: hp; 	GetPlayerHealth(playerid, hp);
	    }
	    case DRUG_TYPE_ASPIRIN:
	    {
	    	PlayerData[playerid][pDrugTime] = 0;
			Player_SetTime(playerid); Player_SetWeather(playerid); PlayerTextDrawHide(playerid, drug_effect[playerid]);
	    	new Float: hp; 	GetPlayerHealth(playerid, hp);
	    	//SetPlayerDrunkLevel(playerid, 0);
	    }
	    case DRUG_TYPE_STEROIDS:
	   	{
	   		total = (amount * randomEx(10, 15));
	   		//effect = (quality * randomEx(90, 110));
	   		PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
	       	PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
	       	//SetPlayerDrunkLevel(playerid, effect);
	   	}
	   	case DRUG_TYPE_HEROIN: 
	   	{
	   		total = (amount * randomEx(10, 15));
	   		//effect = (quality * randomEx(60, 62));
		    PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
		    
	        if(quality >= 70) {
			    PlayerTextDrawBoxColor(playerid, drug_effect[playerid], 0xFFFFFF50);
			    PlayerTextDrawShow(playerid, drug_effect[playerid]);
			}

			PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
			//SetPlayerDrunkLevel(playerid, effect);
	   	}
	   	case DRUG_TYPE_LSD:
	    {
	    	total = (amount * randomEx(10, 15));
	    	//effect = (quality * randomEx(90, 110));
		    PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
		    PlayerData[playerid][pDrugChgWeather] = gettime() + 4;
			PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
			//SetPlayerDrunkLevel(playerid, effect);
	    }
	    case DRUG_TYPE_METH, DRUG_TYPE_PCP:
	    {
	    	total = (amount * randomEx(10, 15));
	    	//effect = (quality * randomEx(90, 110));
		    PlayerData[playerid][pDrugTime] = gettime() + (floatround(amount) * 240);
			PlayerData[playerid][pDrugTimer] = SetTimerEx("Player_HealUp", 2000, true, "ii", playerid, floatround(total));
			//SetPlayerDrunkLevel(playerid, effect);
	    }
	}

	return 1;
}

CMD:uk(playerid, params[]) return cmd_ukoy(playerid, params);
CMD:ukoy(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) != -1)
	{
		if(!Property_Count(playerid)) return SendErrorMessage(playerid, "Hiç evin yok.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[h][PropertyCheck][0], PropertyData[h][PropertyCheck][1], PropertyData[h][PropertyCheck][2]))
		    return SendErrorMessage(playerid, "Zula noktasýna yakýn deðilsin.");

		new slot, Float: amount;
		if(sscanf(params, "if", slot, amount)) return SendUsageMessage(playerid, "/ukoy [uyuþturucu slotu] [gram]");
		if(slot < 1 || slot > 24) return SendErrorMessage(playerid, "Geçersiz slot belirttin.");
		if(!player_drug_data[playerid][slot][is_exist]) return SendErrorMessage(playerid, "Bu slotta uyuþturucun yok.");
		
		if(amount < 0.1 || amount > player_drug_data[playerid][slot][drug_amount]) {
			return SendErrorMessage(playerid, "Girdiðin miktarda uyuþturucun yok.");
		}

		if(GetPropertyDrugs(h) == MAX_PACK_SLOT-1) {
			return SendServerMessage(playerid, "Bu evde uyuþturucu koymaya yer kalmamýþ.");
		}

		new drug_query[512], free_slot = GetNextPropertyDrugSlot(h);
		mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO property_drugs (drug_name, drug_type, drug_amount, drug_quality, drug_size, property_id, placed_by) VALUES ('%e', %i, %f, %i, %i, %i, %i)", player_drug_data[playerid][slot][drug_name], player_drug_data[playerid][slot][drug_id], amount, player_drug_data[playerid][slot][drug_quality], player_drug_data[playerid][slot][drug_size], h, PlayerData[playerid][pSQLID]);
		new Cache:cache = mysql_query(m_Handle, drug_query);

	    property_drug_data[h][free_slot][data_id] = cache_insert_id();
	    property_drug_data[h][free_slot][property_id] = h;
	    property_drug_data[h][free_slot][prop_drug_id] = player_drug_data[playerid][slot][drug_id];
	    format(property_drug_data[h][free_slot][prop_drug_name], 64, "%s", player_drug_data[playerid][slot][drug_name]);
	    property_drug_data[h][free_slot][prop_drug_amount] = amount;
	    property_drug_data[h][free_slot][prop_drug_quality] = player_drug_data[playerid][slot][drug_quality];
	    property_drug_data[h][free_slot][prop_drug_size] = player_drug_data[playerid][slot][drug_size];
		property_drug_data[h][free_slot][is_exist] = true;

		cache_delete(cache);

		SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Uyuþturucu] Evin içerisine %0.1f gram %s %s koydun.", amount, Drug_GetName(player_drug_data[playerid][slot][drug_id]), player_drug_data[playerid][slot][drug_name]);
		cmd_ame(playerid, "evin içerisine bir þeyler koyar.");

		player_drug_data[playerid][slot][drug_amount] -= amount;
		if(player_drug_data[playerid][slot][drug_amount] < 0.1) Drug_DefaultValues(playerid, slot);
		return 1;
	} 
	else 
	{
		new slot, Float: amount;
		if(sscanf(params, "if", slot, amount)) return SendUsageMessage(playerid, "/ukoy [uyuþturucu slotu] [gram]");
		if(slot < 1 || slot > 24) return SendErrorMessage(playerid, "Geçersiz slot belirttin.");
		if(!player_drug_data[playerid][slot][is_exist]) return SendErrorMessage(playerid, "Bu slotta uyuþturucun yok.");
		
		if(amount < 0.1 || amount > player_drug_data[playerid][slot][drug_amount]) 
		{
			return SendErrorMessage(playerid, "Girdiðin miktarda uyuþturucun yok.");
		}

		if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
		{
			new Float: x, Float: y, Float: z;
			GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);
			new	vehicleid = GetNearestVehicle(playerid);

			if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction])
	            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

			if(CarData[vehicleid][carLocked])
				return SendServerMessage(playerid, "Bu araç kilitli.");

			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			if(!boot)
				return SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Ýlk önce bagajý açmalýsýn.");

			if(GetVehicleDrugs(vehicleid) == MAX_PACK_SLOT-1)
				return SendServerMessage(playerid, "Bu araçta uyuþturucu koymaya yer kalmamýþ.");

			new drug_query[512], free_slot = GetNextVehicleDrugSlot(vehicleid);
			mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO vehicle_drugs (drug_name, drug_type, drug_amount, drug_quality, drug_size, vehicle_id, placed_by) VALUES ('%e', %i, %f, %i, %i, %i, %i)", player_drug_data[playerid][slot][drug_name], player_drug_data[playerid][slot][drug_id], amount, player_drug_data[playerid][slot][drug_quality], player_drug_data[playerid][slot][drug_size], CarData[vehicleid][carID], PlayerData[playerid][pSQLID]);
			new Cache:cache = mysql_query(m_Handle, drug_query);

		    vehicle_drug_data[vehicleid][free_slot][data_id] = cache_insert_id();
		    vehicle_drug_data[vehicleid][free_slot][veh_id] = CarData[vehicleid][carID];
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_id] = player_drug_data[playerid][slot][drug_id];
		    format(vehicle_drug_data[vehicleid][free_slot][veh_drug_name], 64, "%s", player_drug_data[playerid][slot][drug_name]);
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_amount] = amount;
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_quality] = player_drug_data[playerid][slot][drug_quality];
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_size] = player_drug_data[playerid][slot][drug_size];
			vehicle_drug_data[vehicleid][free_slot][is_exist] = true;

			cache_delete(cache);

			SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Uyuþturucu] Aracýn içerisine %0.1f gram %s %s koydun.", amount, Drug_GetName(player_drug_data[playerid][slot][drug_id]), player_drug_data[playerid][slot][drug_name]);
			cmd_ame(playerid, "aracýn içerisine bir þeyler koyar.");

			player_drug_data[playerid][slot][drug_amount] -= amount;
			if(player_drug_data[playerid][slot][drug_amount] < 0.1) Drug_DefaultValues(playerid, slot);
			return 1;
		}
		else if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);

			if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction])
	            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

			if(GetVehicleDrugs(vehicleid) == MAX_PACK_SLOT-1)
				return SendServerMessage(playerid, "Bu araçta uyuþturucu koymaya yer kalmamýþ.");

			new drug_query[512], free_slot = GetNextVehicleDrugSlot(vehicleid);
			mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO vehicle_drugs (drug_name, drug_type, drug_amount, drug_quality, drug_size, vehicle_id, placed_by) VALUES ('%e', %i, %f, %i, %i, %i, %i)", player_drug_data[playerid][slot][drug_name], player_drug_data[playerid][slot][drug_id], amount, player_drug_data[playerid][slot][drug_quality], player_drug_data[playerid][slot][drug_size], CarData[vehicleid][carID], PlayerData[playerid][pSQLID]);
			new Cache:cache = mysql_query(m_Handle, drug_query);

		    vehicle_drug_data[vehicleid][free_slot][data_id] = cache_insert_id();
		    vehicle_drug_data[vehicleid][free_slot][veh_id] = CarData[vehicleid][carID];
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_id] = player_drug_data[playerid][slot][drug_id];
		    format(vehicle_drug_data[vehicleid][free_slot][veh_drug_name], 64, "%s", player_drug_data[playerid][slot][drug_name]);
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_amount] = amount;
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_quality] = player_drug_data[playerid][slot][drug_quality];
		    vehicle_drug_data[vehicleid][free_slot][veh_drug_size] = player_drug_data[playerid][slot][drug_size];
			vehicle_drug_data[vehicleid][free_slot][is_exist] = true;

			cache_delete(cache);

			SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Uyuþturucu] Aracýn içerisine %0.1f gram %s %s koydun.", amount, Drug_GetName(player_drug_data[playerid][slot][drug_id]), player_drug_data[playerid][slot][drug_name]);
			cmd_ame(playerid, "aracýn içerisine bir þeyler koyar.");

			player_drug_data[playerid][slot][drug_amount] -= amount;
			if(player_drug_data[playerid][slot][drug_amount] < 0.1) Drug_DefaultValues(playerid, slot);
			return 1;
		}
	}

	SendErrorMessage(playerid, "Etrafýnda uyuþturucunu býrakabileceðin yer yok.");
	return 1;
}

Player_GetDrugCount(playerid)
{
	new drug_count;
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(!player_drug_data[playerid][i][is_exist]) continue;
		drug_count++;
	}
	return drug_count;
}

Vehicle_GetDrugCount(vehicleid)
{
	new drug_count;
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(!vehicle_drug_data[vehicleid][i][is_exist]) continue;
		drug_count++;
	}
	return drug_count;
}

CMD:tuk(playerid, params[])return cmd_tumuyusturucularikoy(playerid, params);
CMD:tumuyusturucularikoy(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidCar(vehicleid)) return SendErrorMessage(playerid, "Bu komut sadece sisteme kayýtlý araçlarda kullanýlýr.");
	if(!Player_GetDrugCount(playerid)) return SendErrorMessage(playerid, "Hiç uyuþturucun yok.");

	new emote[128];
	if(sscanf(params, "S('Yok')[128]", emote)) return SendUsageMessage(playerid, "/tumuyusturucularikoy [emote]");

	new Float: placed_amount, vehicle_space = false;
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(!vehicle_drug_data[vehicleid][i][is_exist])
		{
			vehicle_space = true;
			break;
		}
	}

	if(!vehicle_space) return SendErrorMessage(playerid, "Bu araca daha fazla uyuþturucu koyamazsýn.");

	new drug_query[512];
	new car_space = 0, drug_space = 0;
	for(new i = 1; i < MAX_PACK_SLOT; ++i)
	{
		if(!vehicle_drug_data[vehicleid][i][is_exist])
		{
			car_space++;
			for(new j = 1; j < MAX_PACK_SLOT; ++j)
			{
				if(player_drug_data[playerid][j][is_exist])
				{
					drug_space++;

					placed_amount += player_drug_data[playerid][j][drug_amount];

					mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO vehicle_drugs (drug_name, drug_type, drug_amount, drug_quality, drug_size, vehicle_id, placed_by) VALUES ('%e', %i, %f, %i, %i, %i, %i)", player_drug_data[playerid][j][drug_name], player_drug_data[playerid][j][drug_id], player_drug_data[playerid][j][drug_amount], player_drug_data[playerid][j][drug_quality], player_drug_data[playerid][j][drug_size], CarData[vehicleid][carID], PlayerData[playerid][pSQLID]);
					new Cache:cache = mysql_query(m_Handle, drug_query);

				    vehicle_drug_data[vehicleid][i][data_id] = cache_insert_id();
					vehicle_drug_data[vehicleid][i][veh_drug_id] = player_drug_data[playerid][j][drug_id];
					format(vehicle_drug_data[vehicleid][i][veh_drug_name], 64, "%s", player_drug_data[playerid][j][drug_name]);
					vehicle_drug_data[vehicleid][i][veh_drug_amount] = player_drug_data[playerid][j][drug_amount];
					vehicle_drug_data[vehicleid][i][veh_drug_quality] = player_drug_data[playerid][j][drug_quality];
					vehicle_drug_data[vehicleid][i][veh_drug_size] = player_drug_data[playerid][j][drug_size];
					vehicle_drug_data[vehicleid][i][is_exist] = true;
					
					cache_delete(cache);

					Drug_DefaultValues(playerid, j);

					if(drug_space % car_space == 0)
						break;
				}
			}
		}
	}

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Uyuþturucu] Aracýn içerisine toplam %0.1f gram uyuþturucu koydun.", placed_amount);
	if(strfind(emote, "Yok", true) != -1) cmd_ame(playerid, "aracýn içerisinden bir þeyler alýr.");
	else cmd_ame(playerid, sprintf("%s", emote));
	return 1;
}

CMD:tua(playerid, params[]) return cmd_tumuyusturucularial(playerid, params);
CMD:tumuyusturucularial(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsValidCar(vehicleid)) return SendErrorMessage(playerid, "Bu komut sadece sisteme kayýtlý araçlarda kullanýlýr.");

	new free_slot = Drug_GetPlayerNextSlot(playerid);
	if(free_slot == -1) return SendErrorMessage(playerid, "Üstünde daha fazla uyuþturucu bulunduramazsýn.");
	if(!Vehicle_GetDrugCount(vehicleid)) return SendErrorMessage(playerid, "Bu araçta hiç uyuþturucu yok.");

	new emote[128];
	if(sscanf(params, "S('Yok')[128]", emote)) return SendUsageMessage(playerid, "/tumuyusturucularial [emote]");

	new drug_query[512];
	new Float: tooked_amount, player_space = 0, car_space = 0;
	for(new i = 1; i < MAX_PACK_SLOT; ++i)
	{
		if(!player_drug_data[playerid][i][is_exist])
		{
			player_space++;
			for (new j = 1; j < MAX_PACK_SLOT; j++)
			{
				if(vehicle_drug_data[vehicleid][j][is_exist])
				{
					car_space++;
					tooked_amount += vehicle_drug_data[vehicleid][j][veh_drug_amount];

					mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO player_drugs (player_dbid, drug_name, drug_type, drug_amount, drug_quality, drug_size) VALUES (%i, '%e', %i, %f, %i, %i)", PlayerData[playerid][pSQLID], vehicle_drug_data[vehicleid][j][veh_drug_name], vehicle_drug_data[vehicleid][j][veh_drug_id], vehicle_drug_data[vehicleid][j][veh_drug_amount], vehicle_drug_data[vehicleid][j][veh_drug_quality], vehicle_drug_data[vehicleid][j][veh_drug_size]);
					new Cache: cache = mysql_query(m_Handle, drug_query);

					player_drug_data[playerid][i][data_id] = cache_insert_id();
					player_drug_data[playerid][i][drug_id] = vehicle_drug_data[vehicleid][j][veh_drug_id];
					format(player_drug_data[playerid][i][drug_name], 64, "%s", vehicle_drug_data[vehicleid][j][veh_drug_name]);
					player_drug_data[playerid][i][drug_amount] = vehicle_drug_data[vehicleid][j][veh_drug_amount];
					player_drug_data[playerid][i][drug_quality] = vehicle_drug_data[vehicleid][j][veh_drug_quality];
					player_drug_data[playerid][i][drug_size] = vehicle_drug_data[vehicleid][j][veh_drug_size];
					player_drug_data[playerid][i][is_exist] = true;
					
					cache_delete(cache);

					Drug_VehicleDefaultValues(vehicleid, j);

					if(car_space % player_space == 0)
						break;
				}
			}
		}
	}

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "[Uyuþturucu] Aracýn içerisine toplam %0.1f gram uyuþturucu aldýn.", tooked_amount);
	if(strfind(emote, "Yok", true) != -1) cmd_ame(playerid, "aracýn içerisinden bir þeyler alýr.");
	else cmd_ame(playerid, sprintf("%s", emote));
	return 1;
}

GetVehicleDrugs(vehicleid)
{
	new count = 0;
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(vehicle_drug_data[vehicleid][i][veh_drug_id])
		{
			count++;
		}
	}
	return count;
}

GetNextVehicleDrugSlot(vehicleid)
{
	new i = 1;
	while(i != MAX_PACK_SLOT)
	{
		if(vehicle_drug_data[vehicleid][i][veh_drug_id] == 0)
		{
			return i;
		}
		i++;
	}
	return -1;
}

Vehicle_ListDrugs(playerid, vehicleid, bool:readonly)
{
	new principal_str[1024];

	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(vehicle_drug_data[vehicleid][i][is_exist])
			format(principal_str, sizeof(principal_str), "%s%i. %s - %s (%s: %0.1fg/%i.0g) (Kalite: %i)\n", principal_str, i, vehicle_drug_data[vehicleid][i][veh_drug_name], Drug_GetType(vehicle_drug_data[vehicleid][i][veh_drug_size]), Drug_GetName(vehicle_drug_data[vehicleid][i][veh_drug_id]), vehicle_drug_data[vehicleid][i][veh_drug_amount], Drug_GetMaxAmount(vehicle_drug_data[vehicleid][i][veh_drug_size]), vehicle_drug_data[vehicleid][i][veh_drug_quality]);
		else
			format(principal_str, sizeof(principal_str), "%s%i. [Boþ]\n", principal_str, i);
	}

	if(readonly) Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Bagaj: Uyuþturucular", principal_str, "<<", "");
	else Dialog_Show(playerid, VEHICLE_DRUGS, DIALOG_STYLE_LIST, "Bagaj: Uyuþturucular", principal_str, "Al", "<<");
	return 1;
}

Dialog:VEHICLE_DRUGS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = INVALID_VEHICLE_ID;
        vehicleid = !IsPlayerInAnyVehicle(playerid) ? GetNearestVehicle(playerid) : GetPlayerVehicleID(playerid);
		if(vehicleid == INVALID_VEHICLE_ID) return SendServerMessage(playerid, "Yakýnýnda araç yok.");

		if(!vehicle_drug_data[vehicleid][listitem+1][is_exist])
			return SendServerMessage(playerid, "Seçtiðiniz slot boþ gözüküyor.");

		new free_slot = Drug_GetPlayerNextSlot(playerid);
		if(free_slot == -1) return SendErrorMessage(playerid, "Üstünde daha fazla uyuþturucu bulunduramazsýn.");

		new drug_query[512];
		mysql_format(m_Handle, drug_query, sizeof(drug_query), "INSERT INTO player_drugs (player_dbid, drug_name, drug_type, drug_amount, drug_quality, drug_size) VALUES (%i, '%e', %i, %f, %i, %i)", PlayerData[playerid][pSQLID], vehicle_drug_data[vehicleid][listitem+1][veh_drug_name], vehicle_drug_data[vehicleid][listitem+1][veh_drug_id], vehicle_drug_data[vehicleid][listitem+1][veh_drug_amount], vehicle_drug_data[vehicleid][listitem+1][veh_drug_quality], vehicle_drug_data[vehicleid][listitem+1][veh_drug_size]);
		new Cache: cache = mysql_query(m_Handle, drug_query);

		player_drug_data[playerid][free_slot][data_id] = cache_insert_id();
		player_drug_data[playerid][free_slot][drug_id] = vehicle_drug_data[vehicleid][listitem+1][veh_drug_id];
		format(player_drug_data[playerid][free_slot][drug_name], 64, "%s", vehicle_drug_data[vehicleid][listitem+1][veh_drug_name]);
		player_drug_data[playerid][free_slot][drug_amount] = vehicle_drug_data[vehicleid][listitem+1][veh_drug_amount];
		player_drug_data[playerid][free_slot][drug_quality] = vehicle_drug_data[vehicleid][listitem+1][veh_drug_quality];
		player_drug_data[playerid][free_slot][drug_size] = vehicle_drug_data[vehicleid][listitem+1][veh_drug_size];
		player_drug_data[playerid][free_slot][is_exist] = true;

		cache_delete(cache);
		cmd_ame(playerid, sprintf("aracýn bagajýndan %s alýr.", Drug_GetName(vehicle_drug_data[vehicleid][listitem+1][veh_drug_id])));
        Drug_VehicleDefaultValues(vehicleid, listitem+1);
		return 1;
	}
	return 1;
}

Player_ListDrugs(playerid, id)
{
	new drug_count, drug_str[128];
	for(new i = 1; i < MAX_PACK_SLOT; i++)
	{
		if(!player_drug_data[playerid][i][is_exist]) continue;
		format(drug_str, sizeof(drug_str), "[ {FFFFFF}%i. %s - %s (%s: %0.1fg/%i.0g) (Kalite: %i) {FF6347}]", i, player_drug_data[playerid][i][drug_name], Drug_GetType(player_drug_data[playerid][i][drug_size]), Drug_GetName(player_drug_data[playerid][i][drug_id]), player_drug_data[playerid][i][drug_amount], Drug_GetMaxAmount(player_drug_data[playerid][i][drug_size]), player_drug_data[playerid][i][drug_quality]);
		SendClientMessage(id, COLOR_ADM, drug_str);
		drug_count++;
	}

	if(!drug_count) SendClientMessage(id, COLOR_WHITE, "Gösterilebilecek uyuþturucu yok.");
	return 1;
}

Drug_GetMaxAmount(id)
{
	switch(id)
	{
		case 1: return 7;
		case 2: return 14;
		case 3: return 21;
	}
	return 1;
}

Drug_GetType(id)
{
	new txt[20];
	switch(id)
	{
		case 1: txt = "Küçük";
		case 2: txt = "Orta";
		case 3: txt = "Büyük";
	}
	return txt;
}

Drug_GetDropType(id)
{
	switch(id)
	{
		case 1: return 19896;
		case 2: return 11748;
		case 3: return 2814;
	}
	return 1;
}

Drug_GetName(id)
{
	new txt[20];
	switch(id)
	{
		case 1: txt = "Marijuana";
        case 2: txt = "Crack";
        case 3: txt = "Kokain";
        case 4: txt = "Ekstazi";
        case 5: txt = "LSD";
        case 6: txt = "Metamfetamin";
        case 7: txt = "PCP";
        case 8: txt = "Eroin";
        case 9: txt = "Aspirin";
        case 10: txt = "Haloperidol";
        case 11: txt = "Morfin";
        case 12: txt = "Xanax";
        case 13: txt = "MDMA";
        case 14: txt = "Fenetol";
        case 15: txt = "Anabolik Steroid";
        case 16: txt = "Meskalin";
        case 17: txt = "Quaaludes";
        case 18: txt = "Peyote";
	}
	return txt;
}

Drug_DefaultValues(playerid, slot = -1)
{
	if(slot == -1)
	{
		for(new i = 1; i < MAX_PACK_SLOT; i++)
		{
			player_drug_data[playerid][i][drug_id] = 0;
			format(player_drug_data[playerid][i][drug_name], 64, "");
			player_drug_data[playerid][i][drug_amount] = 0.0;
			player_drug_data[playerid][i][drug_quality] = 0;
			player_drug_data[playerid][i][drug_size] = 0;
			player_drug_data[playerid][i][is_exist] = false;
		}
	} else {
		new query[64];
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM player_drugs WHERE id = %i", player_drug_data[playerid][slot][data_id]);
		mysql_tquery(m_Handle, query);

		player_drug_data[playerid][slot][drug_id] = 0;
		format(player_drug_data[playerid][slot][drug_name], 64, "");
		player_drug_data[playerid][slot][drug_amount] = 0.0;
		player_drug_data[playerid][slot][drug_quality] = 0;
		player_drug_data[playerid][slot][drug_size] = 0;
		//player_drug_data[playerid][slot][drug_used] = false;
		player_drug_data[playerid][slot][is_exist] = false;
		player_drug_data[playerid][slot][data_id] = 0;
	}
	return 1;
}

Drug_PropertyDefaultValues(propertyid, slot = -1)
{
	if(slot == -1)
	{
		for(new i = 1; i < MAX_PACK_SLOT; i++)
		{
			property_drug_data[propertyid][i][property_id] = -1;
			property_drug_data[propertyid][i][prop_drug_id] = 0;
			format(property_drug_data[propertyid][i][prop_drug_name], 64, "");
			property_drug_data[propertyid][i][prop_drug_amount] = 0.0;
			property_drug_data[propertyid][i][prop_drug_quality] = 0;
			property_drug_data[propertyid][i][prop_drug_size] = 0;
			property_drug_data[propertyid][i][is_exist] = false;
		}
	} else {
		property_drug_data[propertyid][slot][property_id] = -1;
		property_drug_data[propertyid][slot][prop_drug_id] = 0;
		format(property_drug_data[propertyid][slot][prop_drug_name], 64, "");
		property_drug_data[propertyid][slot][prop_drug_amount] = 0.0;
		property_drug_data[propertyid][slot][prop_drug_quality] = 0;
		property_drug_data[propertyid][slot][prop_drug_size] = 0;
		property_drug_data[propertyid][slot][is_exist] = false;

		new query[64];
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM property_drugs WHERE id = %i", property_drug_data[propertyid][slot][data_id]);
		mysql_tquery(m_Handle, query);

		property_drug_data[propertyid][slot][data_id] = 0;
	}
	return 1;
}

Drug_VehicleDefaultValues(vehicleid, slot = -1)
{
	if(slot == -1)
	{
		for(new i = 1; i < MAX_PACK_SLOT; i++)
		{
			vehicle_drug_data[vehicleid][i][veh_id] = 0;
			vehicle_drug_data[vehicleid][i][veh_drug_id] = 0;
			format(vehicle_drug_data[vehicleid][i][veh_drug_name], 64, "");
			vehicle_drug_data[vehicleid][i][veh_drug_amount] = 0.0;
			vehicle_drug_data[vehicleid][i][veh_drug_quality] = 0;
			vehicle_drug_data[vehicleid][i][veh_drug_size] = 0;
			vehicle_drug_data[vehicleid][i][is_exist] = false;
		}
	} 
	else 
	{
		new query[78];
		mysql_format(m_Handle, query, sizeof(query), "DELETE FROM vehicle_drugs WHERE id = %i", vehicle_drug_data[vehicleid][slot][data_id]);
		mysql_tquery(m_Handle, query);

		vehicle_drug_data[vehicleid][slot][veh_id] = 0;
		vehicle_drug_data[vehicleid][slot][veh_drug_id] = 0;
		format(vehicle_drug_data[vehicleid][slot][veh_drug_name], 64, "");
		vehicle_drug_data[vehicleid][slot][veh_drug_amount] = 0.0;
		vehicle_drug_data[vehicleid][slot][veh_drug_quality] = 0;
		vehicle_drug_data[vehicleid][slot][veh_drug_size] = 0;
		vehicle_drug_data[vehicleid][slot][is_exist] = false;
		vehicle_drug_data[vehicleid][slot][data_id] = 0;
	}
	return 1;
}

Drug_GetPlayerNextSlot(id)
{
	new i = 1;
	while(i != MAX_PACK_SLOT)
	{
		if(!player_drug_data[id][i][is_exist])
		{
			return i;
		}
		i++;
	}
	return -1;
}