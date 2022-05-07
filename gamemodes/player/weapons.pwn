CMD:kontrol(playerid, params[])
{
	new option[12];
	if(sscanf(params, "s[12]", option)) return SendUsageMessage(playerid, "/kontrol [(s)ilah/(u)yusturucu]");
    if(!strcmp(option, "silah", true) || !strcmp(option, "s", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) != -1)
		{
			if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[h][PropertyCheck][0], PropertyData[h][PropertyCheck][1], PropertyData[h][PropertyCheck][2]))
		    	return SendErrorMessage(playerid, "Zula noktasýna yakýn deðilsin.");

		    ListPropertyWeaps(playerid, h);
	 		return 1;
		}
		else 
		{
			if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
			{
			    new Float: x, Float: y, Float: z;
				GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);
				new vehicleid = GetNearestVehicle(playerid);

				if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece özel araçlarda kullanýlýr.");
				if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction] && !FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
		            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

				if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z)) return SendErrorMessage(playerid, "Aracýn bagajýna yakýn deðilsin.");
				if(CarData[vehicleid][carLocked]) return SendErrorMessage(playerid, "Bu araç kilitli.");
				ListTrunkWeapons(playerid, vehicleid);
				return 1;
			}
			else if(IsPlayerInAnyVehicle(playerid))
			{
				new	vehicleid = GetPlayerVehicleID(playerid);
				if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece özel araçlarda kullanýlýr.");
				if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction] && !FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
		            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

				ListTrunkWeapons(playerid, vehicleid);
				return 1;
			}
		}

		SendErrorMessage(playerid, "Etrafýnda kontrol edebileceðin bir þey yok.");
	}
 	else if(!strcmp(option, "uyusturucu", true) || !strcmp(option, "u", true))
	{
		new h = -1;
		if((h = IsPlayerInProperty(playerid)) != -1)
		{
			if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[h][PropertyCheck][0], PropertyData[h][PropertyCheck][1], PropertyData[h][PropertyCheck][2]))
		    	return SendErrorMessage(playerid, "Zula noktasýna yakýn deðilsin.");

		    Property_ListDrugs(playerid, h, false);
	 		return 1;
		}
		else 
		{
			if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
			{
			    new Float: x, Float: y, Float: z;
				GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);
				new vehicleid = GetNearestVehicle(playerid);

				if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece özel araçlarda kullanýlýr.");
				if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction] && !FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
		            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

				if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z)) return SendErrorMessage(playerid, "Aracýn bagajýna yakýn deðilsin.");
				if(CarData[vehicleid][carLocked]) return SendErrorMessage(playerid, "Bu araç kilitli.");
				Vehicle_ListDrugs(playerid, vehicleid, false);
				return 1;
			}
			else if(IsPlayerInAnyVehicle(playerid))
			{
				new	vehicleid = GetPlayerVehicleID(playerid);
				if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece özel araçlarda kullanýlýr.");
				if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction] && !FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
		            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

		    	Vehicle_ListDrugs(playerid, vehicleid, false);
		    	return 1;
		    }
		}

		SendErrorMessage(playerid, "Etrafýnda kontrol edebileceðin bir þey yok.");
	}
	else SendServerMessage(playerid, "Hatalý parametre girdin.");
	return 1;
}

CMD:silah(playerid, params[])
{
	new specifier[24];
	if(sscanf(params, "s[24]", specifier))
	{
		SendUsageMessage(playerid, "/silah [ayarla/kemik/sakla]");
		return 1;
	}

	new weaponid = GetPlayerWeapon(playerid);
    if(!weaponid) return SendErrorMessage(playerid, "Silah tutmuyorsun.");
    if(!Player_HasWeapon(playerid, weaponid)) return SendErrorMessage(playerid, "Bu silah sende yok.");
    if(!IsWeaponWearable(weaponid)) return SendErrorMessage(playerid, "Bu silah düzenlenemez.");

    if(!strcmp(specifier, "ayarla"))
    {
        if(EditingDisplay[playerid]) return SendErrorMessage(playerid, "Zaten bir silah düzenliyorsun.");
        if(WeaponSettings[playerid][weaponid-22][WeaponHidden]) return SendErrorMessage(playerid, "Saklamýþ olduðun silahý düzenleyemezsin.");

        new index = weaponid - 22;
        SetPlayerArmedWeapon(playerid, 0);
        SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), ReturnWeaponsModel(weaponid), WeaponSettings[playerid][index][WeaponBone], WeaponSettings[playerid][index][WeaponPos][0], WeaponSettings[playerid][index][WeaponPos][1], WeaponSettings[playerid][index][WeaponPos][2], WeaponSettings[playerid][index][WeaponPos][3], WeaponSettings[playerid][index][WeaponPos][4], WeaponSettings[playerid][index][WeaponPos][5], 1.0, 1.0, 1.0);
        EditAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
        EditingDisplay[playerid] = weaponid;
    }
	else if(!strcmp(specifier, "kemik"))
	{
		if(EditingDisplay[playerid]) return SendErrorMessage(playerid, "Zaten bir silah düzenliyorsun.");
        
		new 
			primary[454], sub[60];

		for(new j = 1; j <= 18; j++) 
		{
			format(sub, sizeof(sub), "%s\n", Clothing_Bone(j));
			strcat(primary, sub);
		}
        
        Dialog_Show(playerid, BONE_EDIT, DIALOG_STYLE_LIST, "Kemik", primary, "Seç", "Ýptal");
        EditingDisplay[playerid] = weaponid;
	}
	else if(!strcmp(specifier, "sakla"))
    {
    	if(EditingDisplay[playerid]) return SendErrorMessage(playerid, "Silah düzenlerken saklayamazsýn.");
        if(!IsWeaponHideable(weaponid)) return SendErrorMessage(playerid, "Bu silah saklanamaz.");

        new index = weaponid - 22, query[256];
        if (WeaponSettings[playerid][index][WeaponHidden])
        {
            SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Artýk %s isimli silah üstünde görünür halde olacak.", ReturnWeaponName(weaponid));
            WeaponSettings[playerid][index][WeaponHidden] = false;
        }
        else
        {
            if(IsPlayerAttachedObjectSlotUsed(playerid, GetWeaponObjectSlot(weaponid)))
                RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));

            SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Artýk %s isimli silah üstünde görünmez halde olacak.", ReturnWeaponName(weaponid));
            WeaponSettings[playerid][index][WeaponHidden] = true;
        }

        mysql_format(m_Handle, query, sizeof(query), "INSERT INTO weapon_attachments (playerdbid, WeaponID, Hidden) VALUES (%i, %i, %i) ON DUPLICATE KEY UPDATE Hidden = VALUES(Hidden)", PlayerData[playerid][pSQLID], weaponid, WeaponSettings[playerid][index][WeaponHidden]);
        mysql_tquery(m_Handle, query);
    }
    else SendErrorMessage(playerid, "Hatalý parametre girdiniz.");
	return 1;
}

Dialog:BONE_EDIT(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        new weaponid = EditingDisplay[playerid], query[150];
        WeaponSettings[playerid][weaponid - 22][WeaponBone] = listitem + 1;
        SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s silahýnýn kemik bölgesini deðiþtirdin.", ReturnWeaponName(weaponid));
        mysql_format(m_Handle, query, sizeof(query), "INSERT INTO weapon_attachments (playerdbid, WeaponID, BoneID) VALUES (%i, %i, %i) ON DUPLICATE KEY UPDATE BoneID = VALUES(BoneID)", PlayerData[playerid][pSQLID], weaponid, listitem + 1);
        mysql_tquery(m_Handle, query);
	}
	
	EditingDisplay[playerid] = 0;
	return 1;
}

CMD:silahver(playerid, params[])
{
	if(IsLAWFaction(playerid)) return UnAuthMessage(playerid);
 	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Araç içinde bu komutu kullanamazsýn.");

	new	playerb, wepid;
	if(sscanf(params, "ui", playerb, wepid)) return SendUsageMessage(playerid, "/silahver [oyuncu ID/isim] [silah ID]");
	if(playerb == playerid) return SendErrorMessage(playerid, "Kendine silah veremezsin.");
	if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
	if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
	if(!GetDistanceBetweenPlayers(playerid, playerb, 2.0)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
 	if(IsPlayerInAnyVehicle(playerb)) return SendErrorMessage(playerid, "Belirttiðin kiþi araç içinde olmamalý.");

	if(wepid <= 1 || wepid > 46 || wepid == 35 || wepid == 36 || wepid == 37 || wepid == 38 || wepid == 39 || wepid == 21 || wepid == 19)
	    return SendErrorMessage(playerid, "Hatalý silah ID girdin.");

	if(!Player_HasWeapon(playerid, wepid)) return SendErrorMessage(playerid, "Bu silah sende yok.");
	if(!Player_HasWeapon(playerb, wepid)) return SendErrorMessage(playerid, "Bu silah belirttiðin kiþide mevcut.");

	SendClientMessageEx(playerid, COLOR_ORANGE, "SERVER: %s isimli kiþiye %i mermili %s verdin.", ReturnName(playerb, 0), PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(wepid) ], ReturnWeaponName(wepid));
	SendClientMessageEx(playerb, COLOR_ORANGE, "SERVER: %s sana %i mermili %s verdi.", ReturnName(playerid, 0), PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(wepid) ], ReturnWeaponName(wepid));
	
	GivePlayerWeapon(playerb, wepid, PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(wepid) ]);
	PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(wepid) ] = 0;
	PlayerData[playerid][pWeapons][ Weapon_GetSlotID(wepid) ] = 0;
	Player_RemoveWeapon(playerid, wepid);
	return 1;
}

CMD:silahlarim(playerid, params[])
{
	if(IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Silahý býrakmak için, /silahbirak [silah ID]"); 

	new count;
	for(new i = 0; i < 4; i++) if(PlayerData[playerid][pWeaponsAmmo][i] > 0)
	{
		SendClientMessageEx(playerid, COLOR_ADM, "[ {FFFFFF}%i. %s - %i mermi {FF6347}]", PlayerData[playerid][pWeapons][i], ReturnWeaponName(PlayerData[playerid][pWeapons][i]), PlayerData[playerid][pWeaponsAmmo][i]);
		count++;
	}

	if(!count) SendClientMessage(playerid, COLOR_WHITE, "Hiç silahýn yok.");
	return 1;
}

CMD:silahbirak(playerid, params[])
{
	if(IsLAWFaction(playerid)) return UnAuthMessage(playerid);
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ADM, "HATA: Araç içerisinde bu komutu kullanamazsýn.");

	new weaponid;
	if(sscanf(params, "i", weaponid)) 
	{
		SendUsageMessage(playerid, "/silahbirak [silah ID]");
		SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Silahý yerden almak için, /silahal yazabilirsin."); 
		return 1;
	}

	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
		return SendErrorMessage(playerid, "Geçersiz silah ID belirttin.");

	if(!Player_HasWeapon(playerid, weaponid)) return SendErrorMessage(playerid, "Bu silah sende yok.");

	new id = Iter_Free(Drops);
	if(id == -1) return SendErrorMessage(playerid, "Görünüþe göre silahý býrakmak þu anda mümkün deðil.");
	new weap_slot = Weapon_GetSlotID(weaponid);

	DropData[id][DropType] = 1;
	DropData[id][DropWeaponID] = weaponid;
	DropData[id][DropWeaponAmmo] = PlayerData[playerid][pWeaponsAmmo][weap_slot];

	PlayerData[playerid][pWeapons][weap_slot] = 0;
	PlayerData[playerid][pWeaponsAmmo][weap_slot] = 0; 
	Player_RemoveWeapon(playerid, weaponid);

	GetPlayerPos(playerid, DropData[id][DropLocation][0], DropData[id][DropLocation][1], DropData[id][DropLocation][2]);
	DropData[id][DropInterior] = GetPlayerInterior(playerid); DropData[id][DropWorld] = GetPlayerVirtualWorld(playerid);

	DropData[id][DroppedBy] = PlayerData[playerid][pSQLID];
	DropData[id][DropObjID] = CreateDynamicObject(ReturnWeaponsModel(weaponid), DropData[id][DropLocation][0], DropData[id][DropLocation][1], DropData[id][DropLocation][2] - 1.0, 80.0, 0.0, 0.0, DropData[id][DropWorld], DropData[id][DropInterior]); 
	DropData[id][DropTimer] = SetTimerEx("Drop_GunRemove", 600000, false, "i", id);
	Iter_Add(Drops, id);

	SendClientMessage(playerid, COLOR_ADM, "[!] Silahýn 10 dakika içerisinde kaybolacak. /silahal yazarak geri alabilirsin.");
	cmd_ame(playerid, sprintf("yere %s model silah býrakýr.", ReturnWeaponName(weaponid)));
	return 1;
}

Server:Drop_GunRemove(id)
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

CMD:silahkoy(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) != -1)
	{
		if(IsLAWFaction(playerid)) return UnAuthMessage(playerid);
		if(!Property_Count(playerid)) return SendErrorMessage(playerid, "Hiç evin yok.");
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[h][PropertyCheck][0], PropertyData[h][PropertyCheck][1], PropertyData[h][PropertyCheck][2]))
		    return SendErrorMessage(playerid, "Zula noktasýna yakýn deðilsin.");

		new weapid, slot;
		if(sscanf(params, "i", weapid)) return SendUsageMessage(playerid, "/silahkoy [silah ID]");
		if(!Player_HasWeapon(playerid, weapid)) return SendServerMessage(playerid, "Bu silah sende yok.");
		if(GetPropertyWeps(h) == MAX_PACK_SLOT-1) return SendServerMessage(playerid, "Bu evde silah koymaya yer kalmamýþ.");
		
		slot = GetNextPropertyWeapSlot(h);

		new weap_query[200];
		mysql_format(m_Handle, weap_query, sizeof(weap_query), "INSERT INTO property_weapons (weapon, ammo, property_id, placed_by) VALUES(%i, %i, %i, %i)", PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ], PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ], h, PlayerData[playerid][pSQLID]);
		mysql_tquery(m_Handle, weap_query, "AddWeaponToProperty", "iiiii", playerid, h, slot, PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ], PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ]);
		return 1;
	} 
	else
	{

		new
			Float: x,
			Float: y,
			Float: z,
			weapid,
			slot;

		if(sscanf(params, "i", weapid)) return SendUsageMessage(playerid, "/silahkoy [silah ID]");
		if(!Player_HasWeapon(playerid, weapid)) return SendServerMessage(playerid, "Bu silah sende yok.");

		if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
		{
			GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);
			new	vehicleid = GetNearestVehicle(playerid);

			if(IsValidRentalCar(vehicleid)) return UnAuthMessage(playerid);

			if(IsLAWFaction(playerid) && !IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction]) 
				return UnAuthMessage(playerid);

			if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction])
	            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			if(!boot)
				return SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Ýlk önce bagajý açmalýsýn.");

			if(GetVehicleTrunkWeps(vehicleid) == MAX_WEP_SLOT-1)
				return SendServerMessage(playerid, "Bu araçta silah koymaya yer kalmamýþ.");

			slot = GetNextVehicleTrunkSlot(vehicleid);
			//ammo = ReturnWeaponAmmo(playerid, weapon_id);

			if(FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
			{
			    vehicle_weap_data[vehicleid][slot][data_id] = 0;
			    vehicle_weap_data[vehicleid][slot][veh_wep] = weapid;
			    vehicle_weap_data[vehicleid][slot][veh_ammo] = PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ];
			    vehicle_weap_data[vehicleid][slot][is_exist] = true;
			    vehicle_weap_data[vehicleid][slot][veh_id] = CarData[vehicleid][carID];
				for(new i = 0; i < 6; i++) vehicle_weap_data[vehicleid][slot][wep_offset][i] = 0.0;

				Player_RemoveWeapon(playerid, weapid);
				PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ] = 0;
				PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ] = 0;
			    cmd_ame(playerid, sprintf("%s model araca %s koyar.", ReturnVehicleName(vehicleid), ReturnWeaponName(weapid)));
			} else {
				new weap_query[300];
				mysql_format(m_Handle, weap_query, sizeof(weap_query), "INSERT INTO vehicle_weapons (weapon, ammo, vehicle_id, placed_by) VALUES(%i, %i, %i, %i)", PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ], PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ], CarData[vehicleid][carID], PlayerData[playerid][pSQLID]);
				mysql_tquery(m_Handle, weap_query, "AddWeaponToTrunk", "iiiii", playerid, vehicleid, slot, PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ], PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ]);
			}
			return 1;
		}
		else if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);

			if(IsValidRentalCar(vehicleid)) return UnAuthMessage(playerid);

			if(IsLAWFaction(playerid) && !IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction]) 
				return UnAuthMessage(playerid);

			if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction])
	            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

			if(GetVehicleTrunkWeps(vehicleid) == MAX_WEP_SLOT-1)
				return SendServerMessage(playerid, "Bu araçta silah koymaya yer kalmamýþ.");

			slot = GetNextVehicleTrunkSlot(vehicleid);
			//ammo = ReturnWeaponAmmo(playerid, weapon_id);

			if(FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
			{
			    vehicle_weap_data[vehicleid][slot][data_id] = 0;
			    vehicle_weap_data[vehicleid][slot][veh_wep] = weapid;
			    vehicle_weap_data[vehicleid][slot][veh_ammo] = PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ];
			    vehicle_weap_data[vehicleid][slot][is_exist] = true;
			    vehicle_weap_data[vehicleid][slot][veh_id] = CarData[vehicleid][carID];
				for(new i = 0; i < 6; i++) vehicle_weap_data[vehicleid][slot][wep_offset][i] = 0.0;

				Player_RemoveWeapon(playerid, weapid);
				PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ] = 0;
				PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ] = 0;
			    cmd_ame(playerid, sprintf("%s model araca %s koyar.", ReturnVehicleName(vehicleid), ReturnWeaponName(weapid)));
			} else {
				new weap_query[300];
				mysql_format(m_Handle, weap_query, sizeof(weap_query), "INSERT INTO vehicle_weapons (weapon, ammo, vehicle_id, placed_by) VALUES(%i, %i, %i, %i)", PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ], PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ], CarData[vehicleid][carID], PlayerData[playerid][pSQLID]);
				mysql_tquery(m_Handle, weap_query, "AddWeaponToTrunk", "iiiii", playerid, vehicleid, slot, PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapid) ], PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapid) ]);
			}
			return 1;
		}
	}
	
	SendErrorMessage(playerid, "Etrafýnda silahýný býrakabileceðin yer yok.");
	return 1;
}

CMD:silahal(playerid, params[])
{
	new h = -1;
	if((h = IsPlayerInProperty(playerid)) != -1)
	{
		if(PropertyData[h][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[h][PropertyCheck][0], PropertyData[h][PropertyCheck][1], PropertyData[h][PropertyCheck][2]))
	    	return SendErrorMessage(playerid, "Zula noktasýna yakýn deðilsin.");

	    new
			slot;

		if(sscanf(params, "i", slot)) return SendUsageMessage(playerid, "/silahal [slot]");
		if(slot < 1 || slot > 20) return SendServerMessage(playerid, "Hatalý slot girdiniz.");
		if(!property_weap_data[h][slot][is_exist]) return SendErrorMessage(playerid, "Seçtiðiniz slot boþ gözüküyor.");
		if(Player_HasWeapon(playerid, property_weap_data[h][slot][prop_wep]))  return SendErrorMessage(playerid, "Bu silah zaten sende var.");
        RemoveWeaponFromProperty(playerid, h, slot);
		return 1;
	}
	else 
	{
		if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
		{
		    new Float: x, Float: y, Float: z;
			GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);
			new vehicleid = GetNearestVehicle(playerid);

			if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece özel araçlarda kullanýlýr.");
			if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction] && !FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
	            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

			if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z)) return SendErrorMessage(playerid, "Aracýn bagajýna yakýn deðilsin.");
			if(CarData[vehicleid][carLocked]) return SendErrorMessage(playerid, "Bu araç kilitli.");

			new
				slot;

			if(sscanf(params, "i", slot)) return SendUsageMessage(playerid, "/silahal [slot]");
			if(slot < 1 || slot > 5) return SendServerMessage(playerid, "Hatalý slot girdiniz.");
			if(!vehicle_weap_data[vehicleid][slot][is_exist]) return SendErrorMessage(playerid, "Seçtiðiniz slot boþ gözüküyor.");
			if(Player_HasWeapon(playerid, vehicle_weap_data[vehicleid][slot][veh_wep])) return SendErrorMessage(playerid, "Bu silah zaten sende var.");
			RemoveWeaponFromTrunk(playerid, vehicleid, slot);
			return 1;
		}
		else if(IsPlayerInAnyVehicle(playerid))
		{
			new	vehicleid = GetPlayerVehicleID(playerid);
			if(!IsValidCar(vehicleid)) return SendServerMessage(playerid, "Bu komut sadece özel araçlarda kullanýlýr.");
			if(IsValidFactionCar(vehicleid) && PlayerData[playerid][pFaction] != CarData[vehicleid][carFaction] && !FactionData[CarData[vehicleid][carFaction]][FactionCopPerms])
	            return SendServerMessage(playerid, "Bu araca eriþimin yok.");

			new
				slot;

			if(sscanf(params, "i", slot)) return SendUsageMessage(playerid, "/silahal [slot]");
			if(slot < 1 || slot > 5) return SendServerMessage(playerid, "Hatalý slot girdiniz.");
			if(!vehicle_weap_data[vehicleid][slot][is_exist]) return SendErrorMessage(playerid, "Seçtiðiniz slot boþ gözüküyor.");
			if(Player_HasWeapon(playerid, vehicle_weap_data[vehicleid][slot][veh_wep])) return SendErrorMessage(playerid, "Bu silah zaten sende var.");
			RemoveWeaponFromTrunk(playerid, vehicleid, slot);
			return 1;
		}
	}

	new id = -1;
	if((id = Drop_Nearest(playerid)) != -1)
	{
		if(DropData[id][DropType] != 1)
			return SendErrorMessage(playerid, "Yerdeki silah deðil.");

		if(Player_HasWeapon(playerid, DropData[id][DropWeaponID])) 
			return SendErrorMessage(playerid, "Bu silah zaten sende var.");

		GivePlayerWeapon(playerid, DropData[id][DropWeaponID], DropData[id][DropWeaponAmmo]);
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yakýnýnda bulunan %s model silahý %i mermisiyle yerden aldýn.", ReturnWeaponName(DropData[id][DropWeaponID]), DropData[id][DropWeaponAmmo]);
		cmd_ame(playerid, sprintf("yerden %s model silahý alýr.", ReturnWeaponName(DropData[id][DropWeaponID])));
		Drop_GunRemove(id);
		return 1;
	}

	SendErrorMessage(playerid, "Etrafýnda silah alabileceðin yer yok.");
	return 1;
}

ListTrunkWeapons(playerid, vehicleid)
{
	new principal_str[256];
	for(new i = 1; i < MAX_WEP_SLOT; i++)
	{
		if(vehicle_weap_data[vehicleid][i][is_exist])
			format(principal_str, sizeof(principal_str), "%s%i. %s[Mermi: %i]\n", principal_str, i, ReturnWeaponName(vehicle_weap_data[vehicleid][i][veh_wep]), vehicle_weap_data[vehicleid][i][veh_ammo]);
		else
			format(principal_str, sizeof(principal_str), "%s%i. [Boþ]\n", principal_str, i);
	}

	Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Bagaj: Silahlar", principal_str, "<<", "");
	return 1;
}

Server:AddWeaponToTrunk(playerid, vehicleid, slot, weapon, ammo)
{
	//if(!vehicle_weap_data[vehicleid][slot][data_id]) return 1;

    vehicle_weap_data[vehicleid][slot][data_id] = cache_insert_id();
    vehicle_weap_data[vehicleid][slot][veh_wep] = weapon;
    vehicle_weap_data[vehicleid][slot][veh_ammo] = ammo;
    vehicle_weap_data[vehicleid][slot][is_exist] = true;
    vehicle_weap_data[vehicleid][slot][veh_id] = CarData[vehicleid][carID];

	for(new i = 0; i < 6; i++) vehicle_weap_data[vehicleid][slot][wep_offset][i] = 0.0;

	new Float: player_pos[3];
	GetPlayerPos(playerid, player_pos[0], player_pos[1], player_pos[2]);

    SetPVarInt(playerid, "getVehicleID", vehicleid);
    SetPVarInt(playerid, "getSlot", slot);
    EditingObject[playerid] = 7;

    vehicle_weap_data[vehicleid][slot][temp_object] = CreateDynamicObject(ReturnWeaponsModel(weapon), player_pos[0], player_pos[1], player_pos[2], 0, 0, 0);
	EditDynamicObject(playerid, vehicle_weap_data[vehicleid][slot][temp_object]);

	Player_RemoveWeapon(playerid, weapon);
	PlayerData[playerid][pWeaponsAmmo][ Weapon_GetSlotID(weapon) ] = 0;
	PlayerData[playerid][pWeapons][ Weapon_GetSlotID(weapon) ] = 0;
	//RemovePlayerWeapon(playerid, weapon);

	SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}W{FF6347} veya {FFFFFF}SPACE{FF6347} tuþlarýna basarak kamerayý çevirebilirsin.");
    cmd_ame(playerid, sprintf("%s model araca %s koyar.", ReturnVehicleName(vehicleid), ReturnWeaponName(weapon)));
	return 1;
}

RemoveWeaponFromTrunk(playerid, vehicleid, slot)
{	
	GivePlayerWeapon(playerid, vehicle_weap_data[vehicleid][slot][veh_wep], vehicle_weap_data[vehicleid][slot][veh_ammo]);
	cmd_ame(playerid, sprintf("%s model araçtan %s alýr.", ReturnVehicleName(vehicleid), ReturnWeaponName(vehicle_weap_data[vehicleid][slot][veh_wep])));

	if(vehicle_weap_data[vehicleid][slot][data_id])
	{
		new remove_query[64];
		mysql_format(m_Handle, remove_query, sizeof(remove_query), "DELETE FROM vehicle_weapons WHERE id = %i", vehicle_weap_data[vehicleid][slot][data_id]);
		mysql_tquery(m_Handle, remove_query);
	}

	if(IsValidDynamicObject(vehicle_weap_data[vehicleid][slot][temp_object])) DestroyDynamicObject(vehicle_weap_data[vehicleid][slot][temp_object]);
    vehicle_weap_data[vehicleid][slot][data_id] = 0;
	vehicle_weap_data[vehicleid][slot][veh_wep] = 0;
    vehicle_weap_data[vehicleid][slot][veh_ammo] = 0;
    vehicle_weap_data[vehicleid][slot][is_exist] = false;
    for(new i = 0; i < 6; i++) vehicle_weap_data[vehicleid][slot][wep_offset][i] = 0.0;
	return 1;
}

GetVehicleTrunkWeps(vehicleid)
{
	new count = 0;
	for(new i = 1; i < MAX_WEP_SLOT; i++)
	{
		if(vehicle_weap_data[vehicleid][i][veh_wep])
		{
			count++;
		}
	}
	return count;
}

GetNextVehicleTrunkSlot(vehicleid)
{
	new i = 1;
	while(i != MAX_WEP_SLOT)
	{
		if(vehicle_weap_data[vehicleid][i][veh_wep] == 0)
		{
			return i;
		}
		i++;
	}
	return -1;
}

//wip of new warehouse
/*CMD:orderammo(playerid, params[])
{
	if(!pLoggedIn[playerid])return true;
	if(!IsIllegalFaction(playerid))
		return SendClientMessage(playerid, COLOR_ADM, "HATA: Birlikte deðilsin..");

	new weaponName[128], ammo, totalPrice, string[128];
	if(sscanf(params, "s[128]i", weaponName, ammo)) {
		SendClientMessage(playerid, COLOR_ADM, "KULLANIM:{FFFFFF} /buygun [weapon] [ammo]");
		SendClientMessage(playerid, COLOR_GRAD2, "[ colt: $50 ] [ deagle: $25 ] [ shotgun: $50 ] [ rifle: $150 ] [ M4: $500 ] [ AK: $130 ] ");
		SendClientMessage(playerid, COLOR_GRAD2, "[ Sniper Rifle: $5,000 ] [ TEC: $80 ] [ UZI: $80 ] [ MP5: $450 ] [ Armour (50%): $3000 ] [ Armour (85%): $5000 ]  ");
		SendClientMessage(playerid, COLOR_GRAD2, "[ Molotov: $1500 ] [ Grenade: $2000 ] ");
		return true;
	}

	if(ammo < 1)
		return SendClientMessage(playerid, COLOR_ADM, "HATA: Geçersiz mermi deðeri.");

 	if(ammo > 100)
		return SendClientMessage(playerid, COLOR_ADM, "HATA: Bir seferde 100 mermi alabilirsin.");

	if(strmatch(weaponName, "colt")){
		if(!Player_HasWeapon(playerid, WEAPON_COLT45))
		return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 25 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_COLT45, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "deagle")){
		if(!Player_HasWeapon(playerid, WEAPON_DEAGLE))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 38 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_DEAGLE, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "shotgun")){
		if(!Player_HasWeapon(playerid, WEAPON_SHOTGUN))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 38 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_SHOTGUN, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "rifle")){
		if(!Player_HasWeapon(playerid, WEAPON_RIFLE))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 100 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_RIFLE, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "M4")){
		if(!Player_HasWeapon(playerid, WEAPON_M4))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 500 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_M4, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "AK")){
		if(!Player_HasWeapon(playerid, WEAPON_AK47))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 130 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_AK47, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "Sniper Rifle")){
		if(!Player_HasWeapon(playerid, WEAPON_SNIPER))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 5000 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_SNIPER, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "TEC")){
		if(!Player_HasWeapon(playerid, WEAPON_TEC9))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 80 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_TEC9, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "UZI")){
		if(!Player_HasWeapon(playerid, WEAPON_UZI))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 80 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_UZI, ammo, totalPrice);
	}
	else if(strmatch(weaponName, "MP5")){
		if(!Player_HasWeapon(playerid, WEAPON_MP5))
			return SendClientMessage(playerid, COLOR_ADM, "HATA:{FFFFFF} Elinde bu silah yok.");

		totalPrice = 450 * ammo;

		if( PlayerData[playerid][pMoney] < totalPrice ) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Bunu karþýlayacak paran yok.");

		format(string, sizeof(string), "Are you sure you want to buy ammo for $%s?", MoneyFormat(totalPrice));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPurchaseAmmo", WEAPON_MP5, ammo, totalPrice);
	}
	else return SendClientMessage(playerid, COLOR_ADM, "SERVER: Geçersiz Parametre.");
	return true;
}*/